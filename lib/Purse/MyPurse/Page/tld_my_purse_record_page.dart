import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Model/tld_my_purse_model_manager.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/View/tld_empty_record_view.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_my_purse_recod_cell.dart';
import 'package:flutter/cupertino.dart';

class TPMyPurseRecordPage extends StatefulWidget {
  TPMyPurseRecordPage({Key key,this.type,this.walletAddress}) : super(key: key);
  final int type;
  final String walletAddress;
  @override
  _TPMyPurseRecordPageState createState() => _TPMyPurseRecordPageState();
}

class _TPMyPurseRecordPageState extends State<TPMyPurseRecordPage>{
  TPMyPurseModelManager _manager;

  int _page;

  List _dataSource;

  RefreshController _refreshController;

  StreamController _streamController;

  // StreamSubscription _systemSubscreiption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _page = 1;

    _dataSource = [];

    _manager = TPMyPurseModelManager();

    _refreshController = RefreshController(initialRefresh:true);

    _streamController = StreamController();

    _getPurseTransferList(_page);

    // _registerSystemEvent();
    _addSystemMessageCallBack();
  }

    void _addSystemMessageCallBack() {
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 105){
        _page = 1;
        _refreshController.requestRefresh();
        _getPurseTransferList(_page);
      }
    });
  }


  // void _registerSystemEvent(){
  //   _systemSubscreiption = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 105){
  //       _page = 1;
  //       _refreshController.requestRefresh();
  //       _getPurseTransferList(_page);
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
    // _systemSubscreiption.cancel();
  }

  void _getPurseTransferList(int page){
    _manager.getPurseTransferList(_page, widget.type, widget.walletAddress, (List value){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
        if (mounted){
          _streamController.sink.add(_dataSource);
        }
      }
      _dataSource.addAll(value);
      if (mounted){
          _streamController.sink.add(_dataSource);
        }
      if (value.length > 0){
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
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top :ScreenUtil().setHeight(20)),
      child: TPEmptyListView(
        getListViewCellCallBack:(int index){
          TPPurseTransferInfoModel infoModel = _dataSource[index];
          return TPMyPurseRecordCell(transferInfoModel: infoModel,walletAddress: widget.walletAddress,);
        }, getEmptyViewCallBack:(){
          return TPEmptyRecordView();
        }, streamController: _streamController
        ,refreshCallBack:(){
           _page = 1;
        _getPurseTransferList(_page);
        },loadCallBack: (){
           _getPurseTransferList(_page);
        },refreshController: _refreshController,) 
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}