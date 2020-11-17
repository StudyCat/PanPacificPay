import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_award_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_detail_order_page.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_list_mission_recorder_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PPMissionListMissionRecorderPage extends StatefulWidget {
  PPMissionListMissionRecorderPage({Key key}) : super(key: key);

  @override
  _PPMissionListMissionRecorderPageState createState() => _PPMissionListMissionRecorderPageState();
}

class _PPMissionListMissionRecorderPageState extends State<PPMissionListMissionRecorderPage> with AutomaticKeepAliveClientMixin {

  TPMissionListMissionRecorderModelManager _modelManager;

  int _page;

  List _dataSource;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _dataSource = [];
    _modelManager = TPMissionListMissionRecorderModelManager();
    _page = 1;
  }

  void _getOrderList(int page){
    _modelManager.getOrderList(page, (List orderList){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      if (_page == 1){
        _dataSource = [];
      }
      setState(() {
        _dataSource.addAll(orderList);
      });
      if (orderList.length > 0){
        _page = page + 1;
      }
    }, (TPError error){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _refreshWidget();
  }

    Widget _refreshWidget(){
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getBodWidget(),
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
        _getOrderList(_page);
      },
      onLoading: (){
        _getOrderList(_page);
      },
    );
  }

   Widget _getBodWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TPMissionOrderListModel model = _dataSource[index];
      return PPMissionListMissionRecorderCell(
        orderListModel: model,
        didClickItemCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PPMissionDetailOrderPage(orderNo: model.orderNo,),)).then((value){
            _page = 1;
            _refreshController.requestRefresh();
            // _getOrderList(_page);
          });
        },
      );
     },
    );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}