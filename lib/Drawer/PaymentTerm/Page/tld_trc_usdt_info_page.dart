import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_create_payment_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/View/tld_payment_addree_cell.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/View/tld_wechat_alipay_choice_qrcode_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

class TPTRCUSDTInfoPage extends StatefulWidget {
  TPTRCUSDTInfoPage({Key key,this.typeModel,this.walletAddress,this.paymentModel}) : super(key: key);

  final String walletAddress;

  final TPPaymentTypeModel typeModel;


  final TPPaymentModel paymentModel;

  @override
  _TPTRCUSDTInfoPageState createState() => _TPTRCUSDTInfoPageState();
}

class _TPTRCUSDTInfoPageState extends State<TPTRCUSDTInfoPage> {
   List titles;

  List placeholders;

  String title;

  TPCreatePaymentPramaterModel _pramaterModel;

  TPCreatePaymentModelManager _manager;

  bool _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loading = false;
    _manager = TPCreatePaymentModelManager();

    _pramaterModel = TPCreatePaymentPramaterModel();
    _pramaterModel.walletAddress = widget.walletAddress;
    _pramaterModel.account = '';
      titles = [ '真实姓名',widget.typeModel.payName  + '地址'];
      placeholders = ['请输入您的真实姓名','请输入您的地址'];
      title = widget.typeModel.payName + '账号信息';

    _pramaterModel.type = widget.typeModel.payType;

    if (widget.paymentModel != null){
      _pramaterModel.payId = widget.paymentModel.payId.toString();
      _pramaterModel.imageUrl = widget.paymentModel.imageUrl;
      _pramaterModel.account = widget.paymentModel.account;
      _pramaterModel.realName = widget.paymentModel.realName;
    }
  }

   void createPayment(){
     if (_pramaterModel.account.length == 0){
       Fluttertoast.showToast(msg: '请输入钱包地址');
       return;
     }
    setState(() {
      _loading = true;
    });
      _manager.createPayment(_pramaterModel, (){
        String msg =  widget.typeModel.payName + '添加成功';
        Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
        Navigator.of(context).pop();
      }, (TPError error){
      if (mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: error.msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  void updatePayment(){
    if (_pramaterModel.account.length == 0){
       Fluttertoast.showToast(msg: '请输入钱包地址');
       return;
     }
    setState(() {
      _loading = true;
    });
      _manager.updatePayment(_pramaterModel, (){
        String msg =  widget.typeModel.payName + '修改成功';
        Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
        Navigator.of(context).pop();
      }, (TPError error){
      if (mounted){
        setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: error.msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'wechat_alipay_info_page',
        transitionBetweenRoutes: false,
        middle: Text(title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
          String content = _pramaterModel.realName;
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TPClipTitleInputCell(
                content: content,
                title: titles[index],
                placeholder: placeholders[index],
                textFieldEditingCallBack: (String string) {
                    _pramaterModel.realName = string;
                }
              ),
            );
          }else if (index == titles.length - 1){
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TPPaymentAddressCell(
                content: _pramaterModel.account,
                title: titles[index],
                placeholder: placeholders[index],
                textChangedCallBack: (String text){
                  _pramaterModel.account = text;
                },
              ),
            );
          }else {
            return Column(
            children :<Widget>[
              Padding(padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
              child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text(I18n.of(context).statementPleaseEnterYourPaymentMethodCarefully,style: TextStyle(
                  fontSize : ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)
                ),),
              ),
              ),
              Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text(I18n.of(context).save,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              if (_pramaterModel.payId.length == 0){
                      createPayment();
                    }else{
                      updatePayment();
                    }
            }),
            )
            ]
          ); 
          }
        });
  }

}