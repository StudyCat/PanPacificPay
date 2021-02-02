import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_order_list_cell.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPSaleOrderWaitTPPage extends StatefulWidget {
  TPSaleOrderWaitTPPage({Key key}) : super(key: key);

  @override
  _TPSaleOrderWaitTPPageState createState() => _TPSaleOrderWaitTPPageState();
}

class _TPSaleOrderWaitTPPageState extends State<TPSaleOrderWaitTPPage>  {
 
  TPOrderListModelManager _modelManager;

  TPOrderListPramaterModel _pramaterModel;

  List _dataSource;

  RefreshController _refreshController;

  bool _isLoading = false;

  // StreamSubscription _systemSubscreption;

  StreamController _streamController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TPOrderListModelManager();

    _pramaterModel = TPOrderListPramaterModel();
    _pramaterModel.type = 2;
    _pramaterModel.page = 1;
    _pramaterModel.status = 1;

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _streamController = StreamController();

    _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
    
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
        _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
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

  void _sureSentCoin(String orderNo,String sellerAddress){
    jugeHavePassword(context, (){
      _sentCoin(orderNo,sellerAddress);
    }, TPCreatePursePageType.back, (){
      _sentCoin(orderNo,sellerAddress);
    });
  }

  void _sentCoin(String orderNo,String sellerAddress){
     setState(() {
      _isLoading = true;
    });
    _modelManager.sureSentCoin(orderNo, sellerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _pramaterModel.page = 1;
      _refreshController.requestRefresh();
      _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
      Fluttertoast.showToast(msg: I18n.of(context).sureReleaseTPSuccessMessage,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
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
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: TPEmptyListView(
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
      },));
  }

  Widget _getListItem(BuildContext context,int index){
    TPOrderListModel model = _dataSource[index];
    bool isBuyer =  false;
    // String selfAddress = isBuyer == true ? model.buyerAddress : model.sellerAddress;
    //  String otherAddress = isBuyer == false ? model.buyerAddress : model.sellerAddress;
    return TPOrderListCell(
      orderListModel: model,
      actionBtnTitle: I18n.of(context).releaseTPBtnTitle,
      didClickDetailBtnCallBack: (){
        _sureSentCoin(model.orderNo, model.sellerAddress);
        },
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
            _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
          });
      },
      didClickItemCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TPDetailOrderPage(orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel,_pramaterModel.page);
        });
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