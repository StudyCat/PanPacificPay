import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_balance_page.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_recorder_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPYLBTabPage extends StatefulWidget {
  TPYLBTabPage({Key key}) : super(key: key);

  @override
  _TPYLBTabPageState createState() => _TPYLBTabPageState();
}

class _TPYLBTabPageState extends State<TPYLBTabPage> {
   List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/ylb_balance_sel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/ylb_balance_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(
        '余额',
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/ylb_recorder_sel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/ylb_recorder_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('记录',
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

    pages =  [TPYLBBalancePage(),TPYLBRecorderPage()];
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