import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_profit_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_list_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceWithdrawTabPage extends StatefulWidget {
  TPAcceptanceWithdrawTabPage({Key key}) : super(key: key);

  @override
  _TPAcceptanceWithdrawTabPageState createState() => _TPAcceptanceWithdrawTabPageState();
}

class _TPAcceptanceWithdrawTabPageState extends State<TPAcceptanceWithdrawTabPage> with SingleTickerProviderStateMixin {
 TabController _tabController;

  List<String> _tabTitles = [
    I18n.of(navigatorKey.currentContext).withdraw,
    I18n.of(navigatorKey.currentContext).withdrawRecord
  ];

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
        heroTag: 'acceptance_withdraw_tab_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).withdrawRecord),
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
              TPAcceptanceWithdrawListPage(type: TPAcceptanceProfitListPageType.withdrawing,),
              TPAcceptanceWithdrawListPage(type: TPAcceptanceProfitListPageType.withdrawHistory,)
            ],
            controller: _tabController,
          ))
        ],
      );
  }
}