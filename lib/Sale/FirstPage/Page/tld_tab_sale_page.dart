import 'dart:async';

import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_sale_order_wait_pass_tld_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';

class TPTabSalePage extends StatefulWidget {
  TPTabSalePage({Key key}) : super(key: key);

  @override
  _TPTabSalePageState createState() => _TPTabSalePageState();
}

class _TPTabSalePageState extends State<TPTabSalePage> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  List<String> _tabTitles = [];

  List<Widget> _pages = [
    TPSalePage(type: 0,),TPSaleOrderWaitTPPage()
  ];

  TabController _tabController;

  // StreamSubscription _unreadSubscription;

  // bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero,(){
      setState(() {
        _tabTitles = [
          I18n.of(context).onSaleTabTitle,
          I18n.of(context).waitReleaseTabTitle
        ];
      });
    });

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
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sale_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).commonPageTitle),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TPMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
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
    ));
  }

  Widget _getBodyWidget(){
    return _tabTitles.length > 0 ? Column(
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
    ) : Container();
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

