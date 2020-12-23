import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../CommonWidget/tld_clip_input_cell.dart';
import '../View/tld_verify_password_view.dart';
import 'tld_creating_purse_page.dart';
import '../Model/create_purse_model_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../CommonWidget/tld_data_manager.dart';

enum TPCreatePursePageType{
  create,
  import,
  back
}

class TPCreatePursePage extends StatefulWidget {
  TPCreatePursePage({Key key,@required this.type,this.setPasswordSuccessCallBack}) : super(key: key);

  final TPCreatePursePageType type;

  final Function setPasswordSuccessCallBack;

  @override
  _TPCreatePursePageState createState() => _TPCreatePursePageState();
}

class _TPCreatePursePageState extends State<TPCreatePursePage> {
  String _password;

  String _surePassword;

  TPCreatePurseModelManager _manager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _manager = TPCreatePurseModelManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'create_purse_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).setSafePassword),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: SingleChildScrollView(
        child:  _getBodyWidget(context),),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(40), left: ScreenUtil().setWidth(30)),
          child: Text(
            I18n.of(context).pleaseSetSefePassword,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 51, 51, 51)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Center(
              child: TPClipInputCell(
            placeholder: I18n.of(context).pleaseEnterPassword,
            isNeedSecretShow: true,
            textFieldEditingCallBack: (String string) {
              setState(() {
                _password = string;
              });
            },
          )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(32), left: ScreenUtil().setWidth(30)),
          child: Text(
            I18n.of(context).confirmationPassword,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 51, 51, 51)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Center(
              child: TPClipInputCell(
            placeholder: I18n.of(context).pleaseEnterYourPasswordAgain,
            isNeedSecretShow: true,
            textFieldEditingCallBack: (String string) {
              _surePassword = string;
            },
          )),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(32),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          width: size.width,
          child: TPVerifyPasswordView(
            password: _password,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(150),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                I18n.of(context).sureBtnTitle,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_isHaveCapital() &&
                    _isHaveLowercase() &&
                    _isHaveNum() &&
                    _isLengthLegal()) {
                  if (_password == _surePassword) {
                    _registerUser();
                  } else {
                    Fluttertoast.showToast(
                        msg: I18n.of(navigatorKey.currentContext).TheSurePasswordIsNot,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: I18n.of(navigatorKey.currentContext).doesNotMeetPasswordStrength,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                }
              }),
        )
      ],
    );
  }

  void _registerUser(){
      _savePassword();
      // if (widget.type == TPCreatePursePageType.create){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => TPCreatingPursePage(type: TPCreatingPursePageType.create,)));
      // }else if (widget.type == TPCreatePursePageType.import){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => TPImportPursePage()));
      // }else {
        Navigator.pop(context);
          if (widget.setPasswordSuccessCallBack != null){
                widget.setPasswordSuccessCallBack();
          }
          
      // }
  }

  void _savePassword() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('password', _password);
    TPDataManager.instance.password = _password;
  }

  bool _isHaveCapital() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[A-Z]").hasMatch(_password);
  }

  bool _isHaveLowercase() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[a-z]").hasMatch(_password);
  }

  bool _isHaveNum() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[0-9]").hasMatch(_password);
  }

  bool _isLengthLegal() {
    if (_password == null) {
      return false;
    }
    return (_password.length > 7 && _password.length < 33);
  }
}
