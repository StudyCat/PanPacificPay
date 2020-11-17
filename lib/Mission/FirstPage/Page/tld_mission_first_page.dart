import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_model_manager.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_get_mission_action_sheet.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_mission_cell.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_wallet_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_mission_root_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPMissionFirstPage extends StatefulWidget {
  TPMissionFirstPage({Key key}) : super(key: key);

  @override
  _TPMissionFirstPageState createState() => _TPMissionFirstPageState();
}

class _TPMissionFirstPageState extends State<TPMissionFirstPage> with AutomaticKeepAliveClientMixin {


  TPMissionFirstModelManager _modelManager;

  int _page = 1;

  List _dataSource = [];

  StreamController _streamController;

  RefreshController _refreshController;

  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _streamController = StreamController();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPMissionFirstModelManager();

    _getMissionList(_page);
  }

  void _getMissionList(int page){
    _modelManager.getMissionListInfo(page, (List resultList){
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
    }, (TPError error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _getMission(TPGetTaskPramaterModel pramaterModel){
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getMission(pramaterModel, (int taskWalletId){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '领取任务成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPMissionRootPage(taskWalletId: taskWalletId,))).then((value){
        _page = 1;
        _getMissionList(_page);
      }); 
    }, (TPError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget());
  }

  Widget _getBodyWidget(){
    return TPEmptyListView(getListViewCellCallBack: (int index){
      TPMissionListModel model = _dataSource[index];
       return TPMissionFirstMissionCell(model: model,didClickGetBtnCallBack:(){
         showModalBottomSheet(context: context, builder: (context){
          return TPGetMissionActionSheet(taskNo: model.taskNo,didClickSureGetBtnCallBack: (pramaterModel){
             _getMission(pramaterModel);
           },);
         });
       },timeIsOverRefreshUICallBack: (){
         _page = 1;
         _getMissionList(_page);
       },);
    }, getEmptyViewCallBack: (){
      return TPEmptyDataView(imageAsset: 'assetss/images/no_data.png', title: '暂无可领取的任务');
    }, streamController: _streamController,
    refreshController: _refreshController,
    refreshCallBack: (){
      _page = 1;
      _getMissionList(_page);
    },
    loadCallBack: (){
      _getMissionList(_page);
    },
    ); 
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}