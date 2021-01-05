
import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/View/tld_sale_suspend_button.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/View/tp_new_sale_cell.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_sale_firstpage_cell.dart';
import '../../DetailSale/Page/tld_detail_sale_page.dart';
import '../View/tld_sale_not_data_view.dart';
import '../Model/tld_sale_model_manager.dart';
import '../../../Exchange/FirstPage/Page/tld_exchange_page.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPSalePage extends StatefulWidget {
  TPSalePage({Key key,this.type,this.didRefreshUserInfo}) : super(key: key);

  final int type;

  final Function didRefreshUserInfo; 

  @override
  _TPSalePageState createState() => _TPSalePageState();
}

class _TPSalePageState extends State<TPSalePage> with AutomaticKeepAliveClientMixin {
  List _saleDatas;

  TPSaleModelManager _modelManager;

  RefreshController _refreshController;

  bool _isLoading;

  // StreamSubscription _systemSubscreption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TPSaleModelManager();
     _saleDatas = [];
    _isLoading = false;

    _refreshController = RefreshController(initialRefresh: true);

    getSaleListInfo();

    // _registerSystemEvent();
    _addSystemMessageCallBack();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // _systemSubscreption.cancel();
    TPNewIMManager().removeSystemMessageReceiveCallBack();
  }

    void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103 || contentType == 104){
        _refreshController.requestRefresh();
        getSaleListInfo();
      }
    });
  }


  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       _refreshController.requestRefresh();
  //       getSaleListInfo();
  //     }
  //   });
  // }

  void getSaleListInfo(){
    _modelManager.getSaleList(widget.type,(List dataList,TPTMissionUserInfoModel userInfoModel){
      if (mounted){
              setState(() {
        _saleDatas = List.from(dataList);
      });
      }
      widget.didRefreshUserInfo(userInfoModel);
      _refreshController.refreshCompleted();
    } , (TPError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

    void _cancelSale(TPSaleListInfoModel model,int index){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelSale(model, (){
      if (mounted){
              setState(() {
      _isLoading = false;
      _saleDatas.removeAt(index);
    });
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
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBody());
  }

  Widget _getRsfreshWidget(Widget widget){
    return SmartRefresher(
      controller:_refreshController,
      header: WaterDropHeader(complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete)),
      onRefresh: ()=> getSaleListInfo(),
      child: widget, 
      );
  }

  Widget _getBody() {
    if (_saleDatas.length > 0){
      return _getRsfreshWidget(ListView.builder(
              itemCount: _saleDatas.length,
              itemBuilder: (BuildContext context, int index) {
                TPSaleListInfoModel model = _saleDatas[index];
                return TPNewSaleCell(
                    model : model,
                    didClickCancelCallBack :  () => _cancelSale(model,index),
                    didClickItemCallBack : ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TPDetailSalePage(sellNo: model.sellNo,walletName: model.wallet.name,))));
              },
             ));
    }else{
      return _getRsfreshWidget(TPSaleNotDataView(didClickCallBack: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TPExchangePage())).then((dynamic value){
              _refreshController.requestRefresh();
              getSaleListInfo();
            });
          },));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
