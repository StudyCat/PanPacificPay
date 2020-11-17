import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_mission_progress_model_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/expention_layout.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_body_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_header_cell.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_publish_mission_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_publish_mission_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_new_mission_no_publish_mission_view.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_publish_mission_button.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/View/tld_sale_not_data_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPNewMissionPublishMissionPage extends StatefulWidget {
  TPNewMissionPublishMissionPage({Key key, this.walletAddress, this.corntrol})
      : super(key: key);

  final String walletAddress;

  final TPNewMissionPageControl corntrol;

  @override
  _TPNewMissionPublishMissionPageState createState() =>
      _TPNewMissionPublishMissionPageState();
}

class _TPNewMissionPublishMissionPageState
    extends State<TPNewMissionPublishMissionPage>
    with AutomaticKeepAliveClientMixin {
  List _dataSource;

  TPNewMissionPublishMissionModelManager _modelManager;

  RefreshController _refreshController;

  StreamController _streamController;

  bool _isLoading;

  String _walletAddress = '';

  int _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TPNewMissionPublishMissionModelManager();
    _dataSource = [];
    _isLoading = false;

    _walletAddress = widget.walletAddress;

    _refreshController = RefreshController(initialRefresh: true);

    _streamController = StreamController();

    _page = 1;
    _getPublishList(_page);
    widget.corntrol.addListener(() {
      if (_walletAddress != widget.corntrol.value) {
        _walletAddress = widget.corntrol.value;

        _refreshController.requestRefresh();
        _page = 1;
        _getPublishList(_page);
      }
    });
  }

  void _getPublishList(int page) {
    if (_walletAddress.length == 0) {
      Fluttertoast.showToast(msg: '请先选择钱包');
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      return;
    }
    _modelManager.getPublishMissionList(_walletAddress, page, (List result) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(result);
      if(mounted){
        _streamController.sink.add(_dataSource);
      }
      if (result.length > 0) {
        _page = page + 1;
      }
    }, (TPError error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

    void _cancelPublish(String taskBuyNo,int index){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelPublish(taskBuyNo, (){
      Fluttertoast.showToast(msg: '取消发布成功',toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      if (mounted){
      setState(() {
      _isLoading = false;
      });
      _dataSource.removeAt(index);
      _streamController.sink.add(_dataSource);
      }
    }, (TPError error){
      if (mounted){
              setState(() {
      _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBody());
  }

  Widget _getRsfreshWidget(Widget widget) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete)),
      onRefresh: () {
        _page = 1;
        _getPublishList(_page);
      },
      child: widget,
    );
  }

  Widget _getHaveDataBodyWidget() {
    return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
        child: SingleChildScrollView(
            child: ExpansionLayoutList(
          expandedHeaderPadding: EdgeInsets.zero,
          children: _getExpansionPanelList(),
        )));
  }

  List<ExpansionPanel> _getExpansionPanelList() {
    List<ExpansionPanel> result = [];
    for (int i = 0; i < _dataSource.length; i++) {
      TPMissionProgressModel item = _dataSource[i];
      ExpansionPanel panel = ExpansionPanel(
          headerBuilder: (BuildContext context, bool isOpen) {
            return TPMyMissionHeaderCell(
              progressModel: item,
              isOpen: item.isOpen,
              didClickOpenBtnCallBack: () {
                setState(() {
                  item.isOpen = !item.isOpen;
                });
              },
              didClickItemCallBack: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> tlddetail(taskWalletId: widget.taskWalletId,)));
              },
              didClickCanccelBtnCallBack: ()=> _cancelPublish(item.taskBuyNo,i),
            );
          },
          body: ListBody(
              children: _getExpansionContent(item.taskOrderList, item.taskBuyNo)),
          isExpanded: item.isOpen);
      result.add(panel);
    }
    return result;
  }

  List<Widget> _getExpansionContent(List orderList, String taskNo) {
    List<Widget> result = [];
    for (TaskOrderListModel item in orderList) {
      result.add(TPMYMissionBodyCell(
        model: item,
        taskNo: taskNo,
        didClickItemCallBack: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TPDetailOrderPage(
                        orderNo: item.orderNo,
                      ))).then((value) {
            // _refreshController.requestRefresh();
          });
        },
        didClickIMBtnCallBack: () {
          
        String toUserName = '';
        if (item.amIBuyer){
          toUserName = item.sellerUserName;
        }else{
          toUserName = item.buyerUserName;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TPIMPage(toUserName: toUserName,orderNo: item.orderNo,))).then((value){
          _refreshController.requestRefresh();
        });
        },
      ));
    }
    return result;
  }

  Widget _getBody() {
    return StreamBuilder(
      stream: _streamController.stream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List data = snapshot.data;
        if (data.length > 0) {
          return Stack(
            alignment: FractionalOffset(0.9, 0.95),
            children: <Widget>[
              _getRsfreshWidget(_getHaveDataBodyWidget()),
              TPPublishMissionButton(
                didClickCallBack: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPPublishMissionPage(walletAddress: widget.walletAddress,))).then((dynamic value){
                _refreshController.requestRefresh();
                _page = 1;
                _getPublishList(_page);
              });
                },
              )
            ],
          );
        } else {
          return _getRsfreshWidget(TPNewMissionNoPublishMissionView(
            didClickCallBack: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPPublishMissionPage(walletAddress: widget.walletAddress,))).then((dynamic value){
                _refreshController.requestRefresh();
                _page = 1;
                _getPublishList(_page);
            },
          );}));
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
