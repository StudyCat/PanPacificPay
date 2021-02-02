import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_sale_order_wait_pass_tld_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
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
  List<String> _tabTitles = [I18n.of(navigatorKey.currentContext).onSaleTabTitle,I18n.of(navigatorKey.currentContext).waitReleaseTabTitle];

  TPTMissionUserInfoModel _userInfoModel;

  List<Widget> _pages = [];

  TabController _tabController;

  // StreamSubscription _unreadSubscription;

  // bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
    TPSalePage(type: 0,didRefreshUserInfo: (TPTMissionUserInfoModel userInfoModel){
      setState(() {
        _userInfoModel = userInfoModel;
      });
    },),TPSaleOrderWaitTPPage()
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
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         extendBodyBehindAppBar: true,
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(I18n.of(context).commonPageTitle,style: TextStyle(fontSize: ScreenUtil().setSp(32)),),
        automaticallyImplyLeading: false,
        actions :<Widget>[
            CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Colors.white,
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
                  color: Colors.white,
                  didClickCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TPMessagePage())),
                )
        ]
      ),
    ));
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
         Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil.statusBarHeight,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 750 * 450,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assetss/images/find_bg.png'),
                    fit: BoxFit.fill)),
            child: _getHeaderView(),
          )
        ],
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

   Widget _getHeaderView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : kToolbarHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
            child: Container(
              height : ScreenUtil().setHeight(80),
              width : ScreenUtil().setHeight(80),
              child: _userInfoModel != null ? CachedNetworkImage(imageUrl: _userInfoModel.avatar,fit: BoxFit.fitWidth) : Container(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: _getWalletRowView(),
        ),
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
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 222, 222, 222),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      ],
    );
  }

  Widget _getWalletRowView(){
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
      child : Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        child:RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: <InlineSpan>[
                    WidgetSpan(
                       child: _userInfoModel != null ? CachedNetworkImage(
                          imageUrl: _userInfoModel.userLevelIcon,
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setHeight(30),
                        ) : Container()
                    ),
                      TextSpan(
                    text: ' (',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(32)),),
                      TextSpan(
                        text:  _userInfoModel != null ? _userInfoModel.curQuota : '0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(32)),
                      ),
                      TextSpan(
                        text: _userInfoModel != null ? '/${_userInfoModel.totalQuota})' : '/0)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(32)),
                      )
                    ]),
              ),
      ),
    );
  }


    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

