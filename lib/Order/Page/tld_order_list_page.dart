import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_order_list_content_page.dart';
import '../View/tld_order_list_screen_view.dart';

class TPOrderListPage extends StatefulWidget {
  TPOrderListPage({Key key,this.walletAddress}) : super(key: key);

  final String walletAddress;

  @override
  _TPOrderListPageState createState() => _TPOrderListPageState();
}

class _TPOrderListPageState extends State<TPOrderListPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  TPOrderListScreenViewController _screenViewController;

  TPOrderListContentController _contentController;

  List<String> _tabTitles = [
    I18n.of(navigatorKey.currentContext).buyingTabTitle,
    I18n.of(navigatorKey.currentContext).saleTabTitle,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _screenViewController = TPOrderListScreenViewController(true);

    _contentController = TPOrderListContentController(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'order_list_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).orderListPageTitle),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        trailing: CupertinoButton(
            child: Icon(
              IconData(0xe60a, fontFamily: 'appIconFonts'),
              color: Color.fromARGB(255, 51, 51, 51),
            ),
            padding: EdgeInsets.all(0),
            minSize: 20,
            onPressed: () {
              _screenViewController.value = !_screenViewController.value;
            }),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
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
            children: [TPOrderListContentPage(type: 1,controller: _contentController,walletAddress:widget.walletAddress), TPOrderListContentPage(type: 2,controller: _contentController,walletAddress: widget.walletAddress,)],
            controller: _tabController,
          ))
        ],
      ),
      TPOrderListScreenView(controller: _screenViewController,didClickSureBtnCallBack: (int status){
        _contentController.value = status;
      },)
    ]);
  }
}
