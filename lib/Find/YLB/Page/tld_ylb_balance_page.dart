import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_balance_son_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_balance_son_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPYLBBalancePage extends StatefulWidget {
  TPYLBBalancePage({Key key}) : super(key: key);

  @override
  _TPYLBBalancePageState createState() => _TPYLBBalancePageState();
}

class _TPYLBBalancePageState extends State<TPYLBBalancePage> with SingleTickerProviderStateMixin {
 TabController _tabController;

  List _tabTitles = [];

  TPYLBBalanceSonModelManager _modelManager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
    });

    _modelManager = TPYLBBalanceSonModelManager();
    _getTabName();
  }

  void _getTabName(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getTabName((List tabList){
      if (mounted){
        setState(() {
          _isLoading = false;
          _tabTitles = tabList;
        });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'rank_tab_page',
        transitionBetweenRoutes: false,
        middle: Text('TP余利宝'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.billDescUrl,title: '余利宝说明',)));
        }),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _tabTitles.length > 0 ? _getBodyWidget(context) : Container(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    
    return Column(
        children: <Widget>[
          _getTabbar(),
          Expanded(
              child: TabBarView(
            children: [
              TPYLBBalanceSonPage(type: 1,),
              TPYLBBalanceSonPage(type: 2,),
              TPYLBBalanceSonPage(type: 3,),
              TPYLBBalanceSonPage(type: 4,)
            ],
            controller: _tabController,
          ))
        ],
      );
  }

  Widget _getTabbar(){
    return Stack(
      children: <Widget>[
        Container(
            decoration : BoxDecoration(
                image: DecorationImage(image: AssetImage('assetss/images/rank_back.png'),fit: BoxFit.fitWidth)
            ),
            height: MediaQuery.of(context).size.width / 1025 * 276,
        ),
         Padding(
            padding: EdgeInsets.only(
                // left: ScreenUtil().setWidth(50),
                // right: ScreenUtil().setWidth(50),
                top: ScreenUtil().setHeight(10)),
            child: Center(
              child: TabBar(
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
              isScrollable: true,
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
              indicatorColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).hintColor,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            ),
          )
      ],
    );

  }
}