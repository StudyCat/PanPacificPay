import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/MerchantJoin/Model/tp_merchant_info_model_manager.dart';
import 'package:dragon_sword_purse/Find/MerchantJoin/View/tp_merchant_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPMerchantInfoPage extends StatefulWidget {
  TPMerchantInfoPage({Key key}) : super(key: key);

  @override
  _TPMerchantInfoPageState createState() => _TPMerchantInfoPageState();
}

class _TPMerchantInfoPageState extends State<TPMerchantInfoPage> {

  TPMerchantInfoModelManager _modelManager;

  bool _isLoading = false;

  TPMerchantInfoModel _infoModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPMerchantInfoModelManager();
    _getInfo();
  }

  void _getInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getMerchantInfo((TPMerchantInfoModel infoModel){
      if (mounted){
        setState(() {
          _isLoading = false;
          _infoModel = infoModel;
        });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
          _isLoading = true;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text('商户接入'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: _infoModel == null ? Container() : _getBodyWidget(),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30),right: ScreenUtil().setWidth(30),left: ScreenUtil().setWidth(30)),
      child: SingleChildScrollView(child :Container(
        margin: EdgeInsets.only(bottom : ScreenUtil().setHeight(30)),
        padding: EdgeInsets.only(bottom : ScreenUtil().setHeight(30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            _merchantNameRowWidget(),
            _getTitleWidget('商户ID'),
            TPMerchantInfoItem(content : _infoModel.merchantId),
            _getTitleWidget('API公钥'),
            TPMerchantInfoItem(content : _infoModel.merchantPrivateKey),
            _getTitleWidget('文档地址'),
            TPMerchantInfoItem(content : _infoModel.apiDocUrl),
            _getTitleWidget('商户钱包地址'),
            TPMerchantInfoItem(content : _infoModel.walletAddress),
            _getTitleWidget('商户钱包私钥'),
            TPMerchantInfoItem(content : _infoModel.walletPrivateKey),
          ]
        ),
      ),
    ));
  }

  Widget _merchantNameRowWidget(){
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20),top : ScreenUtil().setHeight(20)),
      child: Row(
        children : [
          Text(_infoModel.realName,style : TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(28))),
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(100)),
            child: Text(_infoModel.appName,style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28))),
          )
        ]
      ),
    );
  } 


  Widget _getTitleWidget(String title){
    return  Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20),top : ScreenUtil().setHeight(20)),
            child: Text(title,style : TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(28))),
          );
  }
}