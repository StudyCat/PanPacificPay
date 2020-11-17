import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_sign_list_member_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_sign_list_mine_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPSignListPage extends StatefulWidget {
  TPSignListPage({Key key}) : super(key: key);

  @override
  _TPSignListPageState createState() => _TPSignListPageState();
}

class _TPSignListPageState extends State<TPSignListPage> with SingleTickerProviderStateMixin {

    List<String> _tabTitles = [
      '我的',
      '成员'
  ];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sign_list_page',
        transitionBetweenRoutes: false,
        middle: Text('签到记录'),
        // trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.inviteProfitDescUrl,title: '推广收益说明',)));
        // }),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50),
                top: ScreenUtil().setHeight(20)),
            child: TabBar(
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
              indicatorColor: Theme.of(context).hintColor,
              labelColor: Color.fromARGB(255, 51, 51, 51),
              unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              TPSignListMinePage(),
              TPSignListMemberPage()
            ],
            controller: _tabController,
          ))
        ],
      );
  }
}