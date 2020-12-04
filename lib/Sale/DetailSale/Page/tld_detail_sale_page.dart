
import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model.dart';
import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_detail_sale_info_view.dart';
import '../View/tld_detail_sale_row_view.dart';

class TPDetailSalePage extends StatefulWidget {
  final String sellNo;
  final String walletName;
  TPDetailSalePage({Key key,this.sellNo,this.walletName}) : super(key: key);

  @override
  _TPDetailSalePageState createState() => _TPDetailSalePageState();
}

class _TPDetailSalePageState extends State<TPDetailSalePage> {

  TPDetailSaleModel _saleModel;

  bool _isLoading;

  // StreamSubscription _systemSubscreption;

  List titles = [
  ];


  TPDetailSaleModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero,(){
      setState(() {
        titles = [
          I18n.of(context).paymentTermLabel,
          I18n.of(context).saleWalletLabel,
          I18n.of(context).minimumPurchaseAmountLabel,
          I18n.of(context).maximumPurchaseAmountLabel,
          I18n.of(context).serviceChargeRateLabel,
          I18n.of(context).serviceChargeLabel,
          I18n.of(context).anticipatedToAccount,
          I18n.of(context).createTimeLabel
        ];
      });
    });

    _modelManager = TPDetailSaleModelManager();
    _isLoading = true;

    getDetailInfo();

    // _registerSystemEvent();
    _addSystemMessageCallBack();
  }


  void getDetailInfo(){
    _modelManager.getDetailSale(widget.sellNo, (TPDetailSaleModel detailModel){
      if (mounted){
              setState(() {
        _isLoading = false;
        _saleModel = detailModel;
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
        setState(() {
          _isLoading = true;
        });
        getDetailInfo();
      }
    });
  }

  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       getDetailInfo();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_sale_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).commonPageTitle),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: titles.length > 0 ? _getBodyWidget(context) : Container()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return  Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)), 
          child: Container(
            padding : EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
            color: Colors.white,
            child :  ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                String address = _saleModel != null ? _saleModel.walletAddress : '';
                return Padding(
                  padding: EdgeInsets.only(top : ScreenUtil().setHeight(36)),
                  child: Text(I18n.of(context).addressLabel + ':' + address,style:TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153))),
                );
              }else if (index == 1){
                return TPDetailSaleInfoView(saleModel: _saleModel,);
              }else{
                bool isShowIcon = false;
                String content  = '';
                int payStatus = 0;
                if (index == 2) {
                  isShowIcon = true;
                  payStatus = _saleModel != null ? _saleModel.payMethodVO.type : 0;
                }else if(index == 3){
                  content = widget.walletName;
                }else if(index == 4){
                  String amount = _saleModel != null ? _saleModel.max : '0';
                  content = amount + 'TP';  
                }else if (index == 5){
                  String amount = _saleModel != null ? _saleModel.maxAmount : '0';
                  content = amount + 'TP';  
                }else if(index == 6){
                  content = _saleModel != null ? (_saleModel.rate + '%') : '0.6%'; 
                }else if(index == 7){
                  content = _saleModel != null ? ('\$'+ _saleModel.charge) : '\$0';
                }else if(index == 8){
                  content = _saleModel != null ? ('\$'+ _saleModel.recCount) : '\$0';
                }else{
                  content = _saleModel != null ? formatDate(DateTime.fromMillisecondsSinceEpoch(_saleModel.createTime), [yyyy,'-',mm,'-',dd]): '';
                }
                return TPDetailSaleRowView(isShowIcon: isShowIcon,title: titles[index - 2],content: content,payStatus: payStatus,);
              }
           },
          )
          ),
        ),
      );
  }
}