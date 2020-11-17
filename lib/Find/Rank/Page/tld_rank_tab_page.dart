import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_accptance_page.dart';
import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_mine_page.dart';
import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_normal_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRankTabPage extends StatefulWidget {
  TPRankTabPage({Key key}) : super(key: key);

  @override
  _TPRankTabPageState createState() => _TPRankTabPageState();
}

class _TPRankTabPageState extends State<TPRankTabPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> _tabTitles = [
    "承兑收益",
    '我的记录'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'rank_tab_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).tldBillRank),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    return TPRankAccptancePage();
    
    
    // Column(
    //     children: <Widget>[
    //       _getTabbar(),
    //       Expanded(
    //           child: TabBarView(
    //         children: [
    //           TPRankAccptancePage(),
    //           TPRankMinePage()
    //         ],
    //         controller: _tabController,
    //       ))
    //     ],
    //   );
  }

  Widget _getTabbar(){
    return Stack(
      children: <Widget>[
        Container(
            decoration : BoxDecoration(
                image: DecorationImage(image: AssetImage('assetss/images/rank_back.png'),fit: BoxFit.fitWidth)
            ),
            height: MediaQuery.of(context).size.width / 1025 * 276,
        ),
         Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50),
                top: ScreenUtil().setHeight(10)),
            child: TabBar(
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
              indicatorColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).hintColor,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          )
      ],
    );

  }
}