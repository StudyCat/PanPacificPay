import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPCreateImportPurseInputPasswordPage extends StatefulWidget {
  TPCreateImportPurseInputPasswordPage({Key key, this.type}) : super(key: key);

  final int type; // 0创建钱包 1添加钱包

  @override
  _TPCreateImportPurseInputPasswordPageState createState() =>
      _TPCreateImportPurseInputPasswordPageState();
}

class _TPCreateImportPurseInputPasswordPageState
    extends State<TPCreateImportPurseInputPasswordPage> {
  
  String _password = '';

  String _walletName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.type == 0 ? '创建钱包' : '导入钱包',
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
          height: ScreenUtil().setHeight(340),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              _getSingleInputView('钱包名', '请输入您的钱包名称', false,(String purseName){
                _walletName = purseName;
              }),
              _getSingleInputView('密码', '请输入您的安全密码', true,(String password){
                _password = password;
              }),
            ],
          )),
      Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(340) - ScreenUtil().setHeight(40),left: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60))  / 2- ScreenUtil().setWidth(185)),
        child: Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(370),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
              child: Text('确定',style: TextStyle(color : Colors.white,fontSize: ScreenUtil().setSp(24)),), 
              onPressed: (){
                if (_walletName.length == 0){
                  Fluttertoast.showToast(msg: '请输入钱包名称');
                  return;
                }
                if (_password.length == 0){
                  Fluttertoast.showToast(msg: '请输入安全密码');
                  return;
                }
                 if (_password == TPDataManager.instance.password) {
                   if (widget.type == 0){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatingPursePage(type: TPCreatingPursePageType.create,walletName: _walletName,)));
                   }else {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TPImportPursePage(walletName: _walletName,)));
                   }
                 }else {
                   Fluttertoast.showToast(msg: '安全密码不正确');
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
}
