import 'dart:async';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_mission_hall_page.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_my_mission_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_order_list_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPMissionRootPage extends StatefulWidget {
  TPMissionRootPage({Key key,this.taskWalletId}) : super(key: key);

  final int taskWalletId;

  @override
  _TPMissionRootPageState createState() => _TPMissionRootPageState();
}

class _TPMissionRootPageState extends State<TPMissionRootPage> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin {

  List<String> _tabTitles = [
    "做任务",
    "任务进度"
  ];

  List<Widget> _pages;

  TabController _tabController;

  // StreamSubscription _unreadSubscription;

  // bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      TPMyMissionPage(taskWalletId: widget.taskWalletId,),TPMissionHallPage(taskWalletId: widget.taskWalletId)
    ];

    _tabController = TabController(length: 2, vsync: this);

    // _haveUnreadMessage = TPIMManager.instance.unreadMessage.length > 0;

    // _registerUnreadMessageEvent();
  }

  // void _registerUnreadMessageEvent(){
  //   _unreadSubscription = eventBus.on<TPHaveUnreadMessageEvent>().listen((event) {
  //     setState(() {
  //       _haveUnreadMessage = event.haveUnreadMessage;
  //     });
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _unreadSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'mission_root_page',
        transitionBetweenRoutes: false,
        middle: Text('TP钱包'),
        trailing: Container(
            width: ScreenUtil().setWidth(160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPOrderListPage()));
                    }),
                MessageButton(
                  didClickCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TPMessagePage())),
                )
              ],
            )),
      ),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(20)),
          child: TabBar(
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
        ),
        Expanded(
          child: TabBarView(
            children: _pages,
            controller: _tabController,
          )
          )
      ],
    );
  }

      @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}