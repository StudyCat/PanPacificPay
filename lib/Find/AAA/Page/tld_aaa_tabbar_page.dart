import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_friend_team_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_person_center_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_plus_star_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPAAATabbarPage extends StatefulWidget {
  TPAAATabbarPage({Key key}) : super(key: key);

  @override
  _TPAAATabbarPageState createState() => _TPAAATabbarPageState();
}

class _TPAAATabbarPageState extends State<TPAAATabbarPage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/aaa_person_center.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/aaa_person_center_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('个人中心',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_aaa_plus_star.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_aaa_plus_star_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('团队升星',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_friend_team.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_friend_team_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(
        '好友圈',
        style: TextStyle(fontSize: 10),
      ),
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

    pages =  [
      TPAAAPersonCenterPage(),
      TPAAAPlusStarPage(),
      TPAAAFriendTeamPage()
      ];
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
              // eventBus.fire(TPAcceptanceTabbarClickEvent(index));
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