import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_list_do_mission_page.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_list_mission_recorder_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PPMissionListPage extends StatefulWidget {
  PPMissionListPage({Key key}) : super(key: key);

  @override
  _PPMissionListPageState createState() => _PPMissionListPageState();
}

class _PPMissionListPageState extends State<PPMissionListPage> with SingleTickerProviderStateMixin {
  List<Widget> _pages;

  TabController _tabController;

  bool _isLoading = false;

  TPTMissionUserInfoModel _userInfoModel;

  List<String> _tabTitles = [ "做任务",
      "任务记录"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController =  TabController(length: 2,vsync: this);

    _pages =  [
    PPMissionListDoMissionPage(didRefreshUserInfo: (TPTMissionUserInfoModel userInfoModel){
      setState(() {
        _userInfoModel = userInfoModel;
      });
    },),
    PPMissionListMissionRecorderPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
      body: _getBodyWidget(),
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
         centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '任务',
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
        ),
        automaticallyImplyLeading: false,
          leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe600, fontFamily: 'appIconFonts'),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                Navigator.of(context).pop();
              });
        }),
        // trailing:  CupertinoButton(
        //             child: Icon(
        //               IconData(0xe663, fontFamily: 'appIconFonts'),
        //               color: Color.fromARGB(255, 51, 51, 51),
        //             ),
        //             padding: EdgeInsets.all(0),
        //             minSize: 20,
        //             onPressed: () {
        //               // Navigator.push(
        //               //     context,
        //               //     MaterialPageRoute(
        //               //         builder: (context) => TPOrderListPage()));
        //             })
        ),
      ),
    );
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
        // GestureDetector(
        //   child: _getWalletRowView(),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(
        //   left: ScreenUtil().setWidth(30),
        //   right: ScreenUtil().setWidth(30),
        //   top: ScreenUtil().setHeight(20)),
        //   child: TabBar(
        //     tabs: _tabTitles.map((title) {
        //       return Tab(text: title);
        //     }).toList(),
        //     labelStyle: TextStyle(
        //         fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
        //     unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
        //     indicatorColor: Theme.of(context).hintColor,
        //     labelColor: Color.fromARGB(255, 51, 51, 51),
        //     unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
        //     controller: _tabController,
        //     indicatorSize: TabBarIndicatorSize.label,
        //   ),
        // ),
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
              child: _userInfoModel != null ? CachedNetworkImage(imageUrl: _userInfoModel.avatar,fit: BoxFit.fill,) : Container(),
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