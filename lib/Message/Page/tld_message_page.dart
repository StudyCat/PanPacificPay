import 'package:dragon_sword_purse/Message/Model/tld_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_im_message_content_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_system_message_content_page.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPMessagePage extends StatefulWidget {
  TPMessagePage({Key key}) : super(key: key);

  @override
  _TPMessagePageState createState() => _TPMessagePageState();
}

class _TPMessagePageState extends State<TPMessagePage> with TickerProviderStateMixin{
  TabController _tabController;

  List _tabTitles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  Future.delayed(Duration.zero,(){
    setState(() {
          _tabTitles = [
      I18n.of(context).noticeTabLabel,
      I18n.of(context).systemMessageTabLabel,
    ];
    });
  });

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {

      eventBus.fire(TPRefreshMessageListEvent(_tabController.index + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'message_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).message),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return  _tabTitles.length > 0 ? Column(
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
              TPIMMessageContentPage(),
              TPSystemMessageContentPage()
            ],
            controller: _tabController,
          ))
        ],
      ) : Container();
  }
  

}