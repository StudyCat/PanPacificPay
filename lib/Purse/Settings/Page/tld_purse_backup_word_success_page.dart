import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tld_tabbar_page.dart';

class TPPurseBackupWordSuccessPage extends StatefulWidget {
  TPPurseBackupWordSuccessPage({Key key}) : super(key: key);

  @override
  _TPPurseBackupWordSuccessPageState createState() =>
      _TPPurseBackupWordSuccessPageState();
}

class _TPPurseBackupWordSuccessPageState
    extends State<TPPurseBackupWordSuccessPage> {
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
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ),
        heroTag: 'purse_backup_word_success_page',
        transitionBetweenRoutes: false,
        middle: Text('备份助记词'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(214),
          ),
          child: Center(
              child: Image.asset('assetss/images/purse_success.png')),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(68),
          ),
          child: Center(
              child: Text('钱包助记词备份成功！',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
          ),
          child: Center(
              child: Text('请妥善保管您的助记词\n切勿丢失或泄漏给他',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.center,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
           top: ScreenUtil().setHeight(80),
          ),
          child: Center(
            child: Container(
              height : ScreenUtil().setHeight(80),
              width :  ScreenUtil().setWidth(540),
              child: CupertinoButton(child: Text('完成',style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Colors.white)), padding: EdgeInsets.all(0),color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(4)),onPressed: (){
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TPTabbarPage()), (route) => route == null);
              }),
            ),
          ),
        )
      ],
    );
  }
}
