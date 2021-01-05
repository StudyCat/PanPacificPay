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

  String _walletName;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _manager = TPCreatePurseModelManager();
  }

   @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == TPCreatePursePageType.create){
      title = '创建钱包';
    }else if(widget.type == TPCreatePursePageType.import){
      title = '导入钱包';
    }else {
      title = '设置安全密码';
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
        ),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe600, fontFamily: 'appIconFonts'),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                Navigator.of(context).pop();
              });
        }),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _getBodyWidget() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: 1,
        itemBuilder: (context, index) {
          return _getContentView();
        });
  }

  Widget _getContentView() {
    return Stack(children: [
      Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil.statusBarHeight,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 750 * 398,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assetss/images/have_logo_bg.png'),
                    fit: BoxFit.fill)),
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 750 * 398 -
                ScreenUtil().setHeight(30) +
                ScreenUtil.statusBarHeight,
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        child: _getInputView(),
      )
    ]);
  }

  Widget _getInputView() {
    return Stack(
      children: [
      Container(
          height: widget.type == TPCreatePursePageType.back ? ScreenUtil().setHeight(500) : ScreenUtil().setHeight(600),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          child: Column(
            children: widget.type == TPCreatePursePageType.back ? _getPasswordWidgetList() : _getCreateOrImportWidgetList()
          )),
      Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(widget.type == TPCreatePursePageType.back ? 500 : 600) - ScreenUtil().setHeight(40),left: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60))  / 2- ScreenUtil().setWidth(185)),
        child: Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(370),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
              child: Text('确定',style: TextStyle(color : Colors.white,fontSize: ScreenUtil().setSp(24)),), 
              onPressed: (){
                if (_walletName.length == 0 && widget.type != TPCreatePursePageType.back){
                  Fluttertoast.showToast(msg: '请输入钱包名称');
                  return;
                }
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
          ),
        ),
    ]);
  }

  Widget _getSingleInputView(String title,String placeholder,bool secret,Function textDidChangeCallBack) {
    return Column(
      children: <Widget>[
        Row(children: [
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(48),
                left: ScreenUtil().setWidth(36)),
            child: Container(
                width: ScreenUtil().setWidth(120),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: ScreenUtil().setSp(28),
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(48),
                left: ScreenUtil().setWidth(14)),
            child: Container(
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(320),
                child: CupertinoTextField(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(0, 0, 0, 0)),),
                    placeholder: placeholder,
                    placeholderStyle: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),
                    style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(24)),
                    obscureText: secret,
                    onChanged: (String text){
                      textDidChangeCallBack(text);
                    },
                    )),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
          child: Divider(
            height: ScreenUtil().setHeight(2),
            color: Color.fromARGB(255, 208, 208, 208),
            indent: ScreenUtil().setWidth(22),
            endIndent: ScreenUtil().setWidth(22),
          ),
        )
      ],
    );
  }

  List<Widget> _getCreateOrImportWidgetList(){
    return [
        _getSingleInputView('钱包名', '请输入您的钱包名称', false,(String purseName){
                _walletName = purseName;
              }),
        _getSingleInputView('密码', '请输入您的安全密码', true,(String password){
              setState(() {
                _password = password;
              });
        }),
        _getSingleInputView('确认密码', '请再次输入您的安全密码', true,(String password){
              _surePassword = password;
        }),
        TPVerifyPasswordView(password: _password,)
    ];
  }

  List<Widget> _getPasswordWidgetList(){
    return [_getSingleInputView('密码', '请输入您的安全密码', true,(String password){
              _password = password;
        }),
        _getSingleInputView('确认密码', '请再次输入您的安全密码', true,(String password){
             setState(() {
                _password = password;
              });
        }),
        TPVerifyPasswordView(password: _password,)];
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CupertinoNavigationBar(
  //       border: Border.all(
  //         color: Color.fromARGB(0, 0, 0, 0),
  //       ),
  //       heroTag: 'create_purse_page',
  //       transitionBetweenRoutes: false,
  //       middle: Text(I18n.of(context).setSafePassword),
  //       backgroundColor: Color.fromARGB(255, 242, 242, 242),
  //       actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
  //     ),
  //     body: LoadingOverlay(isLoading: _isLoading,child: SingleChildScrollView(
  //       child:  _getBodyWidget(context),),
  //     ),
  //     backgroundColor: Color.fromARGB(255, 242, 242, 242),
  //   );
  // }

  // Widget _getBodyWidget(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(40), left: ScreenUtil().setWidth(30)),
  //         child: Text(
  //           I18n.of(context).pleaseSetSefePassword,
  //           style: TextStyle(
  //               fontSize: ScreenUtil().setSp(28),
  //               color: Color.fromARGB(255, 51, 51, 51)),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(20),
  //             left: ScreenUtil().setWidth(30),
  //             right: ScreenUtil().setWidth(30)),
  //         child: Center(
  //             child: TPClipInputCell(
  //           placeholder: I18n.of(context).pleaseEnterPassword,
  //           isNeedSecretShow: true,
  //           textFieldEditingCallBack: (String string) {
  //             setState(() {
  //               _password = string;
  //             });
  //           },
  //         )),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(32), left: ScreenUtil().setWidth(30)),
  //         child: Text(
  //           I18n.of(context).confirmationPassword,
  //           style: TextStyle(
  //               fontSize: ScreenUtil().setSp(28),
  //               color: Color.fromARGB(255, 51, 51, 51)),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(20),
  //             left: ScreenUtil().setWidth(30),
  //             right: ScreenUtil().setWidth(30)),
  //         child: Center(
  //             child: TPClipInputCell(
  //           placeholder: I18n.of(context).pleaseEnterYourPasswordAgain,
  //           isNeedSecretShow: true,
  //           textFieldEditingCallBack: (String string) {
  //             _surePassword = string;
  //           },
  //         )),
  //       ),
  //       Container(
  //         padding: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(32),
  //             left: ScreenUtil().setWidth(30),
  //             right: ScreenUtil().setWidth(30)),
  //         width: size.width,
  //         child: TPVerifyPasswordView(
  //           password: _password,
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(
  //             top: ScreenUtil().setHeight(150),
  //             left: ScreenUtil().setWidth(100),
  //             right: ScreenUtil().setWidth(100)),
  //         height: ScreenUtil().setHeight(80),
  //         width: size.width - ScreenUtil().setWidth(200),
  //         child: CupertinoButton(
  //             child: Text(
  //               I18n.of(context).sureBtnTitle,
  //               style: TextStyle(
  //                   fontSize: ScreenUtil().setSp(28), color: Colors.white),
  //             ),
  //             padding: EdgeInsets.all(0),
  //             color: Theme.of(context).primaryColor,
  //             onPressed: () {
  //               if (_isHaveCapital() &&
  //                   _isHaveLowercase() &&
  //                   _isHaveNum() &&
  //                   _isLengthLegal()) {
  //                 if (_password == _surePassword) {
  //                   _registerUser();
  //                 } else {
  //                   Fluttertoast.showToast(
  //                       msg: I18n.of(navigatorKey.currentContext).TheSurePasswordIsNot,
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       timeInSecForIosWeb: 1);
  //                 }
  //               } else {
  //                 Fluttertoast.showToast(
  //                     msg: I18n.of(navigatorKey.currentContext).doesNotMeetPasswordStrength,
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     timeInSecForIosWeb: 1);
  //               }
  //             }),
  //       )
  //     ],
  //   );
  // }

  void _registerUser(){
      _savePassword();
      if (widget.type == TPCreatePursePageType.create){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPCreatingPursePage(type: TPCreatingPursePageType.create,walletName: _walletName,)));
      }else if (widget.type == TPCreatePursePageType.import){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPImportPursePage(walletName: _walletName,)));
      }else {
        Navigator.pop(context);
          if (widget.setPasswordSuccessCallBack != null){
                widget.setPasswordSuccessCallBack();
          }
          
      }
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
