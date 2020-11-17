import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_profit_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/View/tld_ylb_recorder_profit_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPYLBRecorderProfitPage extends StatefulWidget {
  TPYLBRecorderProfitPage({Key key}) : super(key: key);

  @override
  _TPYLBRecorderProfitPageState createState() => _TPYLBRecorderProfitPageState();
}

class _TPYLBRecorderProfitPageState extends State<TPYLBRecorderProfitPage> {

  TPYLBRecorderProfitModelManager _modelManager;

  RefreshController _refreshController;

  List _dataSource;

  int _page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh:true);

    _modelManager = TPYLBRecorderProfitModelManager();

    _dataSource = [];
    _getProfitList(_page);
  }

  void _getProfitList(int page){
    _modelManager.getProfitList(page, (List profitList){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1){
        _dataSource = [];
      }
      if (mounted){
        setState(() {
          _dataSource.addAll(profitList);
        });
      }
      if (profitList.length > 0){
        _page = page + 1;
      }
    }, (TPError error){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text(I18n.of(context).pullUpToLoad);
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text(I18n.of(context).dropDownToLoadMoreData);
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _page = 1;
        _getProfitList(_page);
      },
      onLoading: (){
        _getProfitList(_page);
      },
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      return TPYLBRecorderProfitCell(listModel: _dataSource[index],);
     },
    );
  }
}