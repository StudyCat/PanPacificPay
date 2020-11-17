import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Model/tld_exchange_choose_wallet_model_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Model/tld_acceptance_login_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_invite_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_login_code_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_scan_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';



class TPAcceptanceLoginPage extends StatefulWidget {
  TPAcceptanceLoginPage({Key key,this.inviteCode}) : super(key: key);

  final String inviteCode;

  @override
  _TPAcceptanceLoginPageState createState() => _TPAcceptanceLoginPageState();
}

class _TPAcceptanceLoginPageState extends State<TPAcceptanceLoginPage> {
  bool _isLoading = false;
  
  TPAcceptanceLoginModelManager _manager;

  ValueNotifier<String> _cellPhone;

  TPAcceptanceLoginPramater _pramater;

  String _walletName = '';

  TextEditingController _inviteController;

  List titles = [
    I18n.of(navigatorKey.currentContext).cellPhoneNumber,
    I18n.of(navigatorKey.currentContext).WalletAddress,
    I18n.of(navigatorKey.currentContext).verifyCode,
  ];

  List placeholders = [
    I18n.of(navigatorKey.currentContext).pleaseEnterYourCellPhoneNumber,
    I18n.of(navigatorKey.currentContext).chooseWallet,
    I18n.of(navigatorKey.currentContext).pleaseEnterVerifyCode,
  ];

    @override
  void initState() { 
    super.initState();

    _pramater = TPAcceptanceLoginPramater();
    _pramater.inviteCode = widget.inviteCode;
    // _pramater.telCode = '123465';

    _cellPhone = ValueNotifier('');  

    _manager = TPAcceptanceLoginModelManager();

    _inviteController = TextEditingController();
  }

  void _getMessageCode(){
    _manager.getMessageCode(_pramater.tel,_pramater.walletAddress, (){

    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _loginUser(){
    if (_pramater.tel == null){
      Fluttertoast.showToast(msg: '请填写手机号码');
      return;
    }
    if (_pramater.telCode == null){
      Fluttertoast.showToast(msg: '请填写短信验证码');
      return;
    }
    if (_pramater.walletAddress == null){
      Fluttertoast.showToast(msg: '请选择钱包');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _manager.loginWithPramater(_pramater, (String token){
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPAcceptanceTabbarPage()));
    }, (TPError error){
      setState(() {
        _isLoading = false;
      });
      if (error.code == -3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TPAcceptanceInviteLoginPage(pramater: _pramater,)));
      }else {
        Fluttertoast.showToast(msg: error.msg);
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
        heroTag: 'acceptance_login_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).tldBillAccountLogin),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }



   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index == 0) {
          String content = '';
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TPClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
            _pramater.tel = string;
            _cellPhone.value = string;
        },),
        );
        }else if(index == 1){
          return TPExchangeNormalCell(
            type: TPExchangeNormalCellType.normalArrow,
            title: titles[index],
            content:  _walletName.length > 0? _walletName: I18n.of(context).chooseWallet,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setSp(2),
            didClickCallBack: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                _pramater.walletAddress = infoModel.walletAddress;
                setState(() {
                  _walletName = infoModel.wallet.name;
                });
              },)));
            },
          );
        }else if(index == 2){
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TPAcceptanceLoginCodeCell(walletAddress: _pramater.walletAddress,cellPhone: _cellPhone,title : titles[index],placeholder: placeholders[index],didClickSendCodeBtnCallBack: (){
            _getMessageCode();
          },telCodeDidChangeCallBack: (String telCode){
            _pramater.telCode = telCode;
          },),);
        }else{
          return Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text(I18n.of(context).login,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              _loginUser();
            }),
          );
        }
      }
    );
  }

  //  Future _scanPhoto() async {
  //   var status = await Permission.camera.status;
  //   if (status == PermissionStatus.denied ||
  //       status == PermissionStatus.restricted ||
  //       status == PermissionStatus.undetermined) {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.camera,
  //     ].request();
  //     return;
  //   }

  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => TPScanQrCodePage(
  //                 scanCallBack: (String result) {
  //                   _manager.getInvationCodeFromQrCode(result,
  //                       (String inviteCode) {
  //                     _inviteController.text = inviteCode;
  //                     _pramater.inviteCode = inviteCode;
  //                   }, (TPError error) {
  //                     Fluttertoast.showToast(
  //                         msg: error.msg,
  //                         toastLength: Toast.LENGTH_SHORT,
  //                         timeInSecForIosWeb: 1);
  //                   });
  //                 },
  //               )));
  // }

}