import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/register&login/Model/tld_register_model_manager.dart';
import 'package:dragon_sword_purse/tld_not_purse_page.dart';
import 'package:dragon_sword_purse/tld_tabbar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPRegisterInviteCodePage extends StatefulWidget {
  TPRegisterInviteCodePage({Key key,this.pramater}) : super(key: key);

  final TPRegisterPramater pramater;

  @override
  _TPRegisterInviteCodePageState createState() =>
      _TPRegisterInviteCodePageState();
}

class _TPRegisterInviteCodePageState extends State<TPRegisterInviteCodePage> {

   TPRegisterModelManager _modelManager;

  bool _isLoading = false;

  TextEditingController _inviteController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _inviteController = TextEditingController();

    _modelManager = TPRegisterModelManager();
  }

  void _register(){
    if (widget.pramater.inviteCode == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterVerifyCode);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.register(widget.pramater, (String token) async {
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      TPDataManager.instance.acceptanceToken = token;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('acceptanceToken', token);
      if (TPDataManager.instance.purseList.length > 0){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TPTabbarPage()), (route) => route == null);
      }else{
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TPNotPurseHomePage()), (route) => route == null);
      }
    }, (TPError error){
       if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading,child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'register_page',
        transitionBetweenRoutes: false,
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        middle: Text(I18n.of(context).register),
        automaticallyImplyLeading: true,
      ),
    );
  }

  Widget _getBodyWidget() {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(100)),
      child: Column(
      children: <Widget>[
        _getCodeRowWidget(),
         Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child:  Divider(
              height: ScreenUtil().setHeight(2),
              color: Color.fromARGB(255, 221, 221, 221),
            ),
          ),
        Padding(
          padding:  EdgeInsets.only(top :ScreenUtil().setHeight(120)),
          child: Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
         height : ScreenUtil().setHeight(80),
         child : CupertinoButton(
           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
           color: Theme.of(context).primaryColor,
           child: Text(I18n.of(context).register,style: TextStyle(fontSize : ScreenUtil().setSp(30),color :Colors.white),),
           onPressed: () {
               _register();
           }, 
         )
       ),
        ) 
      ],
    ),
    );
  }
  
  Widget _getCodeRowWidget(){
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(400),
                child: CupertinoTextField(
                  controller: _inviteController,
                  padding: EdgeInsets.zero,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color.fromARGB(255, 51, 51, 51)),
                  placeholderStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color.fromARGB(255, 153, 153, 153)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                  ),
                  placeholder: '请输入邀请码',
                  onChanged: (str){
                    widget.pramater.inviteCode = str;
                  },
                ),
              ),
             Padding(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(10),right:0,top: 0,bottom: 0),
                child: Container(
                 width: ScreenUtil().setWidth(100),
                 height: ScreenUtil().setHeight(80),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),  
                   child: Icon(IconData(0xe606,fontFamily : 'appIconFonts'),color: Theme.of(context).primaryColor,),
                   onPressed: () async{
                     await _scanPhoto();
                   }),
               ),
        )]);
  }

  Future _scanPhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TPScanQrCodePage(
                  scanCallBack: (String result) {
                    _modelManager.getInvationCodeFromQrCode(result,
                        (String inviteCode) {
                      _inviteController.text = inviteCode;
                      widget.pramater.inviteCode = inviteCode;
                    }, (TPError error) {
                      Fluttertoast.showToast(
                          msg: error.msg,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1);
                    });
                  },
                )));
   }

}
