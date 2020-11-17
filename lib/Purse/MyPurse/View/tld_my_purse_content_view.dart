import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Page/tld_my_purse_record_page.dart';

class TPMyPurseContentView extends StatefulWidget  {
  TPMyPurseContentView({Key key,this.walletAddress}) : super(key: key);

  final String walletAddress;

  @override
  _TPMyPurseContentViewState createState() => _TPMyPurseContentViewState();
}

class _TPMyPurseContentViewState extends State<TPMyPurseContentView>
    with SingleTickerProviderStateMixin {
  List<String> _tabTitles = [
    I18n.of(navigatorKey.currentContext).allRecord,
    I18n.of(navigatorKey.currentContext).receiveRecorder,
    I18n.of(navigatorKey.currentContext).transferRecorder,
  ];

  TabController _tabController;

  @override
  void initState() {

    super.initState();

    _tabController = TabController(length: _tabTitles.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
            labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
            indicatorColor: Theme.of(context).hintColor,
            labelColor: Color.fromARGB(255, 51, 51, 51),
            unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          Expanded(
              child: TabBarView(
            children: [
              TPMyPurseRecordPage(type: 0,walletAddress: widget.walletAddress,),
              TPMyPurseRecordPage(type: 2,walletAddress: widget.walletAddress,),
              TPMyPurseRecordPage(type: 1,walletAddress: widget.walletAddress,),
            ],
            controller: _tabController,
          ))
        ],
      ),
    );
  }

  // @override

  // bool get wantKeepAlive => true;
}
