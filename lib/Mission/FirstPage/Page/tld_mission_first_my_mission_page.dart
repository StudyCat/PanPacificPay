import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_my_mission_model_manager.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_my_mission_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_mission_root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPMissionFirstMyMissionPage extends StatefulWidget {
  TPMissionFirstMyMissionPage({Key key}) : super(key: key);

  @override
  _TPMissionFirstMyMissionPageState createState() => _TPMissionFirstMyMissionPageState();
}

class _TPMissionFirstMyMissionPageState extends State<TPMissionFirstMyMissionPage> with AutomaticKeepAliveClientMixin {

  TPMissionFirstMyMissionModelManager _modelManager;

  int _page;

  List _dataSource = [];

  StreamController _streamController;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPMissionFirstMyMissionModelManager();

    _refreshController = RefreshController(initialRefresh: true);

    _streamController = StreamController();

    _page = 1;
    _getMyMissionList(_page);
  }

  void _getMyMissionList(int page){
    _modelManager.getMyMissionList(page, (List resultList){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(resultList);
      _streamController.add(_dataSource);
      if (resultList.length > 0) {
        _page = page + 1;
      }
    }, (TPError error){
       _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget(){
    return TPEmptyListView(getListViewCellCallBack: (int index){
      TPMissionInfoModel model = _dataSource[index];
       return TPMissionFirstMyMissionCell(
            model: model,
            didClickItemCallBack: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPMissionRootPage(taskWalletId: model.taskWalletId,)));
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