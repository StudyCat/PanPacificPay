import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_profit_spill_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_profit_spill_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_profit_spill_unopen_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class TPAcceptanceProfitSpillPage extends StatefulWidget {
  TPAcceptanceProfitSpillPage({Key key,this.walletAddress}) : super(key: key);

  final String walletAddress;

  @override
  _TPAcceptanceProfitSpillPageState createState() => _TPAcceptanceProfitSpillPageState();
}

class _TPAcceptanceProfitSpillPageState extends State<TPAcceptanceProfitSpillPage> {

  RefreshController _refreshController;

  TPAcceptanceProfitSpillModelManager _modelManager;

  bool _isLoading = false;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPAcceptanceProfitSpillModelManager();
    _getSpillListInfo();
  }

  void _getSpillListInfo(){
    _modelManager.getSpillList((List spillList){
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted) {
        setState(() {
          _dataSource.addAll(spillList);
        });
      }
    }, (TPError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _getProfit(int overflowId){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getProfit(overflowId, (){
      _refreshController.requestRefresh();
      Fluttertoast.showToast(msg: '领取成功');
      if (mounted) {
        setState(() {
      _isLoading = false;
    });
      }
      _getSpillListInfo();
    },(TPError error){
      if (mounted) {
        setState(() {
      _isLoading = false;
    });
      }
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_sign_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).profitOverflowPool,),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.overflowProfitDescUrl,title: '收益溢出池说明',)));
        }),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51)
      ),
      body: _getRefresWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getRefresWidget(){
    return SmartRefresher(
      // enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      header: WaterDropHeader(
        complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      onRefresh: (){
        _getSpillListInfo();
      },
    );
  }


  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TPAcceptanceProfitSpillListModel model = _dataSource[index];
        if (model.lock == false) {
          return TPAcceptanceProfitSpillOpenCell(
          listModel: model,
          didClickwithdrawButtonCallBack: (){
            _getProfit(model.overflowId);
          },
        );
        }else{
          return TPAcceptanceProfitSpillUnopenCell(
            listModel: model,
            didClickItemCallBack: (){
               showDialog(
               context: context,
             builder: (context) => TPAlertView(alertString: model.tip,title: '温馨提示',didClickSureBtn: (){
             },),
      );
            },
          );
        }
     },
    );
  }

}