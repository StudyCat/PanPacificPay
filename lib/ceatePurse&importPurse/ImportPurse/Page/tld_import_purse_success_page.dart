import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../tld_tabbar_page.dart';

class TPImportPurseSuccessPage extends StatefulWidget {
  TPImportPurseSuccessPage({Key key}) : super(key: key);

  @override
  _TPImportPurseSuccessPageState createState() => _TPImportPurseSuccessPageState();
}

class _TPImportPurseSuccessPageState extends State<TPImportPurseSuccessPage> {

  bool _isLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkIsLogin();
  }

    void _checkIsLogin() async {
    var token = await TPDataManager.instance.getAcceptanceToken();
    setState(() {
      _isLogin = token != null; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
         leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
           color: Color.fromARGB(255, 51, 51, 51),
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Widget nextPage = _isLogin ? TPTabbarPage() : TPRegisterView();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => nextPage), (route) => route == null);
          },
        ),
       ),
        heroTag: 'import_purse_success_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).importWallet),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: _getBodyWidget(context),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child:  Center(
              child:Image.asset('assetss/images/purse_success.png')),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text(I18n.of(context).importSuccess,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
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
                Widget nextPage = _isLogin ? TPTabbarPage() : TPRegisterView();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => nextPage), (route) => route == null);
              }),
        ),
      ],
    ));
  }
}
