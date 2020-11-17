import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tld_create_payment_model_manager.dart';


class TPBankCardInfoPage extends StatefulWidget {
  TPBankCardInfoPage({Key key,this.walletAddress,this.paymentModel}) : super(key: key);

  final String walletAddress;

  final TPPaymentModel paymentModel;
  @override
  _TPBankCardInfoPageState createState() => _TPBankCardInfoPageState();
}

class _TPBankCardInfoPageState extends State<TPBankCardInfoPage> {
  
  TPCreatePaymentPramaterModel _pramaterModel;

  TPCreatePaymentModelManager _manager;

  bool _loading;

  List titles = [
    I18n.of(navigatorKey.currentContext).realNameLabel,
    I18n.of(navigatorKey.currentContext).bankCardNumLabel,
    I18n.of(navigatorKey.currentContext).openAccountBankLabel,
    I18n.of(navigatorKey.currentContext).quotaEveryday
  ];

  List placeholders = [
    I18n.of(navigatorKey.currentContext).pleaseEnterYourRealName,
    I18n.of(navigatorKey.currentContext).pleaseEnterYourBankCardNumber,
    I18n.of(navigatorKey.currentContext).pleaseEnterYourBankName,
    I18n.of(navigatorKey.currentContext).pleaseEnterYourLimitAmount
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _loading = false;

    _pramaterModel = TPCreatePaymentPramaterModel();
    _pramaterModel.type = 1;
    _pramaterModel.walletAddress = widget.walletAddress;

    if(widget.paymentModel != null){
      _pramaterModel.payId = widget.paymentModel.payId.toString();
      _pramaterModel.subBranch = widget.paymentModel.subBranch;
      _pramaterModel.account = widget.paymentModel.account;
      _pramaterModel.realName = widget.paymentModel.realName;
      _pramaterModel.quota = widget.paymentModel.quota;
    }

    _manager = TPCreatePaymentModelManager();


  }

  void createBankPayment(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.account.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写银行卡号",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.subBranch.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写开户行",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.quota.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写每日最低购买额度",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.createPayment(_pramaterModel, (){
      if (mounted){
        setState(() {
          _loading = false;
        });
      }
      Fluttertoast.showToast(
                      msg: "添加银行卡成功",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TPError error){
      if (mounted){
       setState(() {
        _loading = false;
      });
      }
    });
  }

  void updateBankInfo(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.account.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写银行卡号",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.subBranch.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写开户行",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.quota.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写每日限额",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.updatePayment(_pramaterModel, (){
      if(mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: "修改银行卡成功",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TPError error){
      if (mounted){
       setState(() {
        _loading = false;
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).bankCardInformation),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index < titles.length) {
          String content;
          if(index == 0){
            content = _pramaterModel.realName;
          }else if(index == 1){
            content = _pramaterModel.account;
          }else if(index == 2){
            content = _pramaterModel.subBranch;
          }else if(index == 3){
            content = _pramaterModel.quota;
          }
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TPClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
          if(index == 0){
            _pramaterModel.realName = string;
          }else if(index == 1){
            _pramaterModel.account = string;
          }else if(index == 2){
            _pramaterModel.subBranch = string;
          }else if(index == 3){
            _pramaterModel.quota = string;
          }
        },),
        );
        }else{
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
              if(_pramaterModel.payId.length == 0){
                createBankPayment();
              }else{
                updateBankInfo();
              }
            }),
            )
            ]
          ); 
        }
      }
    );
  }
}