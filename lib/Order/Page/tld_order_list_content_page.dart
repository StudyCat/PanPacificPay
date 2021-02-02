import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_detail_order_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_order_list_cell.dart';
import 'tld_detail_order_page.dart';
import '../../IMUI/Page/tld_im_page.dart';
import '../Model/tld_order_list_model_manager.dart';

class TPOrderListContentController  extends ValueNotifier<int>{
    TPOrderListContentController(int status) : super(status);
}


class TPOrderListContentPage extends StatefulWidget {
  TPOrderListContentPage({Key key,this.type,this.controller,this.walletAddress}) : super(key: key);

  final String walletAddress;

  final int type;

  final TPOrderListContentController controller;

  @override
  _TPOrderListContentPageState createState() => _TPOrderListContentPageState();
}

class _TPOrderListContentPageState extends State<TPOrderListContentPage> {

  TPOrderListModelManager _modelManager;

  TPOrderListPramaterModel _pramaterModel;

  List _dataSource;

  RefreshController _refreshController;

  // StreamSubscription _systemSubscreption;

  StreamController _streamController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TPOrderListModelManager();

    _pramaterModel = TPOrderListPramaterModel();
    _pramaterModel.type = widget.type;
    _pramaterModel.page = 1;
    if (widget.walletAddress != null){
      _pramaterModel.walletAddress =  widget.walletAddress;
    }

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _streamController = StreamController();

    _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);

    widget.controller.addListener(() {
      int status = widget.controller.value;
      if (status == null){
        if (_pramaterModel.status != null){
          _pramaterModel.status = null;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
        }
      }else{
        if (_pramaterModel.status != status){
           _pramaterModel.status = status;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
        }
      }
    });
    
    // _registerSystemEvent();

    _addSystemMessageCallBack();
  }

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
    // _systemSubscreption.cancel();
  }

    void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103 || contentType == 104){
        _pramaterModel.page = 1;
        _refreshController.requestRefresh();
      }
    });
  }

  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       _pramaterModel.page = 1;
  //       _refreshController.requestRefresh();
  //       _getOrderListDataWithPramaterModel(_pramaterModel);
  //     }
  //   });
  // }

  void _getOrderListDataWithPramaterModel(TPOrderListPramaterModel model,int page){
    _modelManager.getOrderList(model, (List orderList){
      if(page == 1){
        _dataSource = [];
        _streamController.sink.add(_dataSource);
      }
       _dataSource.addAll(orderList);
       _streamController.sink.add(_dataSource);
      if (orderList.length > 0){
        _pramaterModel.page = page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TPEmptyListView(
      getListViewCellCallBack:(int index){
        return _getListItem(context, index);
      } , getEmptyViewCallBack: (){
        return TPEmptyDataView(imageAsset: 'assetss/images/creating_purse.png', title: I18n.of(context).noOrderLabel);
      }, streamController: _streamController,
      refreshController: _refreshController,
      refreshCallBack: (){
        _pramaterModel.page = 1;
        _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
      },loadCallBack: (){
        _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
      },);
  }

  Widget _getListItem(BuildContext context,int index){
    TPOrderListModel model = _dataSource[index];
    bool isBuyer =  widget.type == 1 ? true : false;
    // String selfAddress = isBuyer == true ? model.buyerAddress : model.sellerAddress;
    //  String otherAddress = isBuyer == false ? model.buyerAddress : model.sellerAddress;
    return TPOrderListCell(
      orderListModel: model,
      didClickDetailBtnCallBack: (){
        if (model.orderType == 2 && model.amIBuyer == true){
           Navigator.push(context, MaterialPageRoute(builder: (context) => PPMissionDetailOrderPage(orderNo: model.orderNo,))).then((value) {
              _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          });
        }else{
           Navigator.push(context, MaterialPageRoute(builder: (context) => TPDetailOrderPage(orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
        });
        }
      },
      actionBtnTitle: I18n.of(context).detailButtonTitle,
      didClickIMBtnCallBack: (){
         String toUserName = '';
          if (model.amIBuyer){
            toUserName = model.sellerUserName;
          }else{
            toUserName = model.buyerUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPIMPage(toUserName: toUserName,orderNo: model.orderNo,))).then((value) {
            _pramaterModel.page = 1;
            _refreshController.requestRefresh();
          });
      },
      didClickItemCallBack: (){
      if (model.orderType == 2 && model.amIBuyer == true){
           Navigator.push(context, MaterialPageRoute(builder: (context) => PPMissionDetailOrderPage(orderNo: model.orderNo,))).then((value) {
              _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          });
        }else{
           Navigator.push(context, MaterialPageRoute(builder: (context) => TPDetailOrderPage(orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
        });
        }
      },
      didClickAppealBtn: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TPJustNoticePage(appealId: model.appealId,type: TPJustNoticePageType.appealWatching,))).then((value){
            _pramaterModel.page = 1;
            _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
         });
      },
      );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}