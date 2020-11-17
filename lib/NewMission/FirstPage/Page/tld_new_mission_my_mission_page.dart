import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_my_mission_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_new_mission_my_mission_cell.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPNewMissionMyMissionPage extends StatefulWidget {
  TPNewMissionMyMissionPage({Key key,this.walletAddress,this.corntrol}) : super(key: key);

  final String walletAddress;

  final TPNewMissionPageControl corntrol;

  @override
  _TPNewMissionMyMissionPageState createState() => _TPNewMissionMyMissionPageState();
}

class _TPNewMissionMyMissionPageState extends State<TPNewMissionMyMissionPage> with AutomaticKeepAliveClientMixin {

  List _dataSource = [];

  TPNewMissionMyMissionModelManager _modelManager;

  int _page;

  StreamController _streamController;

  RefreshController _refreshController;

  String _walletAddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _streamController = StreamController();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPNewMissionMyMissionModelManager();

    _walletAddress = widget.walletAddress;

    _page = 1;
    _getMyMissionList(_page);

    widget.corntrol.addListener(() {
      if (_walletAddress != widget.corntrol.value){
          _walletAddress = widget.corntrol.value;

          _refreshController.requestRefresh();
          _page = 1;
          _getMyMissionList(_page);
      }
    });
  }

   void _getMyMissionList(int page){
    if (_walletAddress.length == 0){
      Fluttertoast.showToast(msg: '请先选择钱包');
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      return;
    }
    _modelManager.getMyMissionList(_walletAddress,page,(List buyList){
       _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(buyList);
      if (mounted){
        _streamController.add(_dataSource);
      }
      if (buyList.length > 0) {
        _page = page + 1;
      }
    }, (TPError error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget(){
     return TPEmptyListView(getListViewCellCallBack: (int index){
      TPOrderListModel infoModel = _dataSource[index];
       return TPNewMissionMyMissionCell(
         model: infoModel,
         didClickIMBtnCallBack: (){

         },
         didClickItemCallBack: (){

         },
       );
    }, getEmptyViewCallBack: (){
      return TPEmptyDataView(imageAsset: 'assetss/images/no_data.png', title: '暂无任务');
    }, streamController: _streamController,
    refreshController: _refreshController,
    refreshCallBack: (){
      _page = 1;
      _getMyMissionList(_page);
    },
    loadCallBack: (){
      _getMyMissionList(_page);
    },
    ); 
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}