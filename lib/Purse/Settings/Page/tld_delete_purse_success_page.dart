import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../tld_tabbar_page.dart';
import '../../../tld_not_purse_page.dart';

class TPDeletePurseSuccessPage extends StatefulWidget {
  TPDeletePurseSuccessPage({Key key}) : super(key: key);

  @override
  _TPDeletePurseSuccessPageState createState() =>
      _TPDeletePurseSuccessPageState();
}

class _TPDeletePurseSuccessPageState extends State<TPDeletePurseSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'delete_purse_success_page',
        transitionBetweenRoutes: false,
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
              if (TPDataManager.instance.purseList.isEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TPNotPurseHomePage()),
                    (route) => route == null);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => TPTabbarPage()),
                    (route) => route == null);
              }
            },
          ),
        ),
        middle: Text('删除钱包'),
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
            child: Text('删除钱包成功！',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(250),
          ),
          child: Center(
            child: Container(
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(540),
              child: CupertinoButton(
                  child: Text('完成',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: Colors.white)),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  onPressed: () {
                    if (TPDataManager.instance.purseList.isEmpty) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPNotPurseHomePage()),
                          (route) => route == null);
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPTabbarPage()),
                          (route) => route == null);
                    }
                  }),
            ),
          ),
        )
      ],
    );
  }
}
