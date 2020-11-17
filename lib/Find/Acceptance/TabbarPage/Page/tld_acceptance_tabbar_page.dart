import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_bill_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_tab_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Page/tld_acceptance_order_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceTabbarPage extends StatefulWidget {
  TPAcceptanceTabbarPage({Key key}) : super(key: key);

  @override
  _TPAcceptanceTabbarPageState createState() => _TPAcceptanceTabbarPageState();
}

class _TPAcceptanceTabbarPageState extends State<TPAcceptanceTabbarPage> {

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_acceptance_bill.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_acceptance_bill_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(
        I18n.of(navigatorKey.currentContext).bill,
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_acceptance_order.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_acceptance_order_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).order,
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_acceptance_invite.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_acceptance_invite_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).invite,
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_acceptance_mine.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_acceptance_mine_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).mine,
          style: TextStyle(
            fontSize: 10,
          )),
    ),
  ];

  List pages;

  
  int currentIndex;

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentIndex = 0;

    _pageController = PageController();

    pages =  [TPAcceptanceBillListPage(), TPAcceptanceOrderListPage(), TPAcceptanceInvitationTabPage(),TPAcceptanceSignPage()];
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color.fromARGB(255, 153, 153, 153),
        iconSize: 26,
        onTap: (index) => _getPage(index),
      ),
      body: Builder(builder: (BuildContext context) {
        return PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return pages[index];
            },
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            onPageChanged: (int index) {
              eventBus.fire(TPAcceptanceTabbarClickEvent(index));
              setState(() {
                currentIndex = index;
              });
            },
          );
      }),
    );
  }

  void _getPage(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}