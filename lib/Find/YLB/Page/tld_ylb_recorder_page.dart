import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_recorder_profit_page.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_recorder_roll_in_out_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPYLBRecorderPage extends StatefulWidget {
  TPYLBRecorderPage({Key key}) : super(key: key);

  @override
  _TPYLBRecorderPageState createState() => _TPYLBRecorderPageState();
}

class _TPYLBRecorderPageState extends State<TPYLBRecorderPage> with SingleTickerProviderStateMixin {
 TabController _tabController;

  List<String> _tabTitles = [
    "收益",
    '转入',
    '转出'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
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
        middle: Text('TP余利宝'),
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
          _getTabbar(),
          Expanded(
              child: TabBarView(
            children: [
              TPYLBRecorderProfitPage(),
              TPYLBRecorderRollInOutPage(type: 1,),
              TPYLBRecorderRollInOutPage(type: 2,)
            ],
            controller: _tabController,
          ))
        ],
      );
  }

  Widget _getTabbar(){
    return 
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
              unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
    );

  }
}