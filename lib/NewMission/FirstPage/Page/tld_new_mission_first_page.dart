import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_firt_page_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_deal_mission_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_my_mission_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_publish_mission_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_new_mission_my_mission_no_wallet_view.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TPNewMissionPageControl extends ValueNotifier<String>{
  TPNewMissionPageControl(String adressWallet) : super(adressWallet);
}

class TPNewMissionFirstPage extends StatefulWidget {
  TPNewMissionFirstPage({Key key}) : super(key: key);

  @override
  _TPNewMissionFirstPageState createState() => _TPNewMissionFirstPageState();
}

class _TPNewMissionFirstPageState extends State<TPNewMissionFirstPage> with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  // StreamSubscription _unreadSubscription;

  // bool _haveUnreadMessage;

  List<Widget> _pages = [];

  TabController _tabController;

  TPWalletInfoModel _infoModel;

  TPNewMissionPageControl _control;

  bool _isLoading = false;

  List<String> _tabTitles = [];

  String _progress = '';

  TPNewMissionFirstPageModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPNewMissionFirstPageModelManager();

    _control = TPNewMissionPageControl(null);

    // _haveUnreadMessage = TPIMManager.instance.unreadMessage.length > 0;

    // _registerUnreadMessageEvent();

    String walletAddress = TPDataManager.instance.missionWalletAddress;
    if (walletAddress != null){
      _getMissionWallet(walletAddress);
    }else{
      _chooseWallet();
    }
  }

  // void _registerUnreadMessageEvent(){
  //   _unreadSubscription = eventBus.on<TPHaveUnreadMessageEvent>().listen((event) {
  //     setState(() {
  //       _haveUnreadMessage = event.haveUnreadMessage;
  //     });
  //   });
  // }

  void _getMissionWallet(String walletAddress){
    // Future.delayed(Duration.zero,(){
    List purseList = TPDataManager.instance.purseList;
    String haveWallet = '';
    for (TPWallet item in purseList) {
      if (item.address == walletAddress){
        haveWallet = item.address;
        break;
      }
    }


    if (haveWallet.length == 0){
      _chooseWallet();
    }else{
      _getWalletInfo(walletAddress);
    }
  }

  _getWalletInfo(String walletAddress){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getWalletInfo(walletAddress, (TPWalletInfoModel infoModel){
      if (mounted){
        setState(() {
        _infoModel = infoModel;
        _isLoading = false;
      });
      }
    }, (TPError error){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  _chooseWallet(){
    Future.delayed(Duration.zero,(){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel)async{
       if (mounted){
         setState(() {
           _infoModel = infoModel;
           
           _control.value = infoModel.walletAddress;
         });
       }
       SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.setString('missionWalletAddress', infoModel.walletAddress);
      },)));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // _unreadSubscription.cancel();
  }

  void _getTabControlAndPage(){
    if(int.parse(_infoModel.walletLevel) > 9 && (_tabTitles.length == 2 || _tabTitles.length == 0)){
    _tabController = TabController(length: 3,vsync: this);
    
    _tabTitles = [
      "做任务",
      "我的任务",
      '发布任务'
    ];

     _pages = [TPNewMissionDealMissionPage(walletAddress: _infoModel.walletAddress,control: _control,getProgressCallBack: (String progress){
       if(_progress != progress){
         setState(() {
          _progress = progress;
       });
       }
     },),TPNewMissionMyMissionPage(walletAddress:_infoModel.walletAddress,corntrol: _control,),TPNewMissionPublishMissionPage(walletAddress:_infoModel.walletAddress,corntrol: _control)];
    }else if (int.parse(_infoModel.walletLevel) < 9 && (_tabTitles.length == 3 || _tabTitles.length == 0)){
      _tabController = TabController(length: 2,vsync: this);
    
      _tabTitles = [
      "做任务",
      "我的任务"
      ];

     _pages = [TPNewMissionDealMissionPage(walletAddress: _infoModel.walletAddress,control: _control,getProgressCallBack: (String progress){
       setState(() {
         _progress = progress;
       });
     },),TPNewMissionMyMissionPage(walletAddress:_infoModel.walletAddress,corntrol: _control,)];
    }

    _tabController.addListener(() {
      _control.value = _infoModel.walletAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
      body: _getLoadingWidegt(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
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
    ),
    );
  }

  Widget _getLoadingWidegt(){
    
    return LoadingOverlay(isLoading: _isLoading,child: _infoModel != null ? _getBodyWidget():_getNoWalletWidget(),);
  }

  Widget _getNoWalletWidget(){
    return TPNewMissionMyMissionNoWalletView(didClickChooseBtnCallBack: (){
      _chooseWallet();
    },);
  }

  
  Widget _getBodyWidget(){
    _getTabControlAndPage();
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: ()=>_chooseWallet(),
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

  Widget _getWalletRowView(){
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
      child : Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          RichText(text: TextSpan(
            text: 'L'+ '${_infoModel.walletLevel}' + ' ' + _infoModel.wallet.name + ' ($_progress)',
            style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32)),
            // children: <InlineSpan>[
            //   TextSpan(text : '0',style :TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(32)),),
            //   TextSpan(text : '/20）',style :TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32)),)
            // ]
          ),),
          _getChangePurseRowView()
        ],
      ),
      ),
    );
  }

  Widget _getChangePurseRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:<Widget>[
        Icon(IconData(0xe644,fontFamily: 'appIconFonts'),color: Theme.of(context).primaryColor,size: ScreenUtil().setWidth(30),),
        Text( '  切换钱包',
            style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)))
      ]
    );
  }

      @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
