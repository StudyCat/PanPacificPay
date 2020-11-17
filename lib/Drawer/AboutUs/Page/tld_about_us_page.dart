import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_about_us_header_cell.dart';

class TPAboutUsPage extends StatefulWidget {
  TPAboutUsPage({Key key}) : super(key: key);

  @override
  _TPAboutUsPageState createState() => _TPAboutUsPageState();
}

class _TPAboutUsPageState extends State<TPAboutUsPage> {
  List titles = [
    I18n.of(navigatorKey.currentContext).officialWebsite,
    I18n.of(navigatorKey.currentContext).VersionUpdating,
  ];

  List contents = ['http://www.tldollar.com\nhttp://www.tldwallet.com', I18n.of(navigatorKey.currentContext).TheCurrentVersionIsTheLatest];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'about_us_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).aboutUS),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return TPAboutUsHeaderCell();
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TPClipCommonCell(
                type: TPClipCommonCellType.normal,
                title: titles[index - 1],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
                content: contents[index - 1],
                contentStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153)),
              ),
            );
          }
        });
  }
}
