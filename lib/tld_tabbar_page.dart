
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_choose_wallet.dart';
import 'package:dragon_sword_purse/Drawer/UserAgreement/Page/tld_user_agreement_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_login_code_cell.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Model/tld_revieve_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_deteail_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_unopen_red_envelope_alert_view.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_find_root_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Page/tld_mission_first_root_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Page/tld_transfer_accounts_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_tab_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import './Buy/FirstPage/Page/tld_buy_page.dart';
import './Purse/FirstPage/Page/tld_purse_page.dart';
import 'Purse/FirstPage/View/purse_firstpage_sideslip.dart';
import 'Notification/tld_more_btn_click_notification.dart';
import 'Drawer/IntegrationDesc/Page/tld_integration_desc_page.dart';
import 'Drawer/AboutUs/Page/tld_about_us_page.dart';
import 'Drawer/UserFeedback/Page/tld_user_feedback_page.dart';
import 'package:uni_links/uni_links.dart';


class TPTabbarPage extends StatefulWidget {
  TPTabbarPage({Key key}) : super(key: key);

  @override
  _TPTabbarPageState createState() => _TPTabbarPageState();
}

class _TPTabbarPageState extends State<TPTabbarPage> with WidgetsBindingObserver {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_purse.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_purse_unsel.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      title: Text(
        I18n.of(navigatorKey.currentContext).wallet,
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_buy.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_buy_unsel.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).buyBtnTitle,
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_sale.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_sale_unsel.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).sale,
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_find.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_find_unsel.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
      title: Text(I18n.of(navigatorKey.currentContext).findPageTitle,
          style: TextStyle(
            fontSize: 10,
          ))
    )
  ];

  List pages = [TPPursePage(), TPBuyPage(),TPTabSalePage(),TPFindRootPage()];

  int currentIndex;

  PageController _pageController;

  TPRecieveRedEnvelopeModelManager _redEnvelopeModelManager;

  bool _isLoading = false;

  StreamSubscription<String> _sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _redEnvelopeModelManager = TPRecieveRedEnvelopeModelManager();

    WidgetsBinding.instance.addObserver(this);
    currentIndex = 0;
    _pageController = PageController();
    
    _loginIM();

    _initPlatformStateForStringUniLinks();

    _initUniLinks();
  }

  _loginIM()async{
    String username = await TPDataManager.instance.getUserName();
    String password = await TPDataManager.instance.getPassword();
    if (username != null && password != null){
          TPNewIMManager().loginJpush(username, password);
    }
  }

   Future<Null> _initUniLinks() async {
    print('------获取参数--------');
    // Platform messages may fail, so we use a try/catch PlatformException.
      _sub = getLinksStream().listen((String link) async {
       Uri uri = Uri.parse(link);
       Map queryParameter = uri.queryParameters;
      if (queryParameter.containsKey('type')) {
        int type = int.parse(queryParameter['type']);
        String dataJson = queryParameter['data'];
        Map data = jsonDecode(dataJson);
        if (type == 1){
          String redEnvelopeId = data['redEnvelopeId'];
          _getRedEnvelopeInfo(redEnvelopeId);
        }else if (type == 2){
          String toWalletAddres = data['walletAddress'];
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TPEchangeChooseWalletPage(
            transferWalletAddress: toWalletAddres,
            type: TPEchangeChooseWalletPageType.transfer,
          )));
        }else if (type == 3){
           String inviteCode = data['inviteCode'];
           String token = await TPDataManager.instance.getAcceptanceToken();
           if (token == null){
             Navigator.push(context, MaterialPageRoute(builder:(context) => TPAcceptanceLoginPage(inviteCode: inviteCode,)));
           }else{
             Fluttertoast.showToast(msg: '您已注册TP票据');
           }
        }
      }
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
   }
  
  //处理外部应用调起TP
   _initPlatformStateForStringUniLinks() async {
    // Get the latest link
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      if (initialLink == null) {
        return;
      }
      if (initialLink == TPDataManager.instance.lastLink) {
        return;
      }
      TPDataManager.instance.lastLink = initialLink;
      Uri uri = Uri.parse(initialLink);
      Map queryParameter = uri.queryParameters;
      if (queryParameter.containsKey('type')) {
        int type = int.parse(queryParameter['type']);
        String dataJson = queryParameter['data'];
        Map data = jsonDecode(dataJson);
        if (type == 1){
          String redEnvelopeId = data['redEnvelopeId'];
          _getRedEnvelopeInfo(redEnvelopeId);
        }else if (type == 2){
          String toWalletAddres = data['walletAddress'];
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TPEchangeChooseWalletPage(
            transferWalletAddress: toWalletAddres,
            type: TPEchangeChooseWalletPageType.transfer,
          )));
        }else if (type == 3){
           String inviteCode = data['inviteCode'];
           String token = await TPDataManager.instance.getAcceptanceToken();
           if (token == null){
             Navigator.push(context, MaterialPageRoute(builder:(context) => TPAcceptanceLoginPage(inviteCode: inviteCode,)));
           }else{
             Fluttertoast.showToast(msg: '您已注册TP票据');
           }
        }
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
  }

    void _getRedEnvelopeInfo(String redEnvelopeId){
    _redEnvelopeModelManager.getRedEnvelopeInfo(redEnvelopeId, (TPDetailRedEnvelopeModel redEnvelopeModel){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      showDialog(context: context,builder:(context) => TPUnopenRedEnvelopeAlertView(
        redEnvelopeModel: redEnvelopeModel,
        didClickOpenButtonCallBack: (String walletAddress){
          _recieveRedEnvelope(walletAddress, redEnvelopeId);
        },
        ));
    }, (TPError error){
      if(mounted){
        Fluttertoast.showToast(msg: error.msg);
      }
    });
  }


  void _recieveRedEnvelope(String walletAddress,String redEnvelopeId){
    setState(() {
      _isLoading = true;
    });
    _redEnvelopeModelManager.recieveRedEnvelope(redEnvelopeId, walletAddress, (int recieveLogId){
       if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPDetailRecieveRedEnvelopePage(receiveLogId: recieveLogId,)));
    }, (TPError error){
       if(mounted){
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
      drawer: TPPurseSideslipView(
        didClickCallBack: (int index) {
          Navigator.pop(context);
          if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TPPaymentChooseWalletPage()));
          } else if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TPIntegrationDescPage()));
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TPAboutUsPage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TPUserFeedBackPage()));
          }else {
            // TPUserAgreementPage
            Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.tldWalletAgreement,title: I18n.of(context).userAgreement,)));
          }
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color.fromARGB(255, 153, 153, 153),
        iconSize: 26,
        onTap: (index) => _getPage(index),
      ),
      body: Builder(builder: (BuildContext context) {
        return LoadingOverlay(isLoading: _isLoading, child: NotificationListener<TPMoreBtnClickNotification>(
          onNotification: (TPMoreBtnClickNotification notifcation) {
            Scaffold.of(context).openDrawer();
            return true;
          },
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return pages[index];
            },
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            onPageChanged: (int index) {

              setState(() {
                currentIndex = index;
              });
              eventBus.fire(TPBottomTabbarClickEvent(index));
              if (index == 0){
                  eventBus.fire(TPRefreshFirstPageEvent());
              }else if(index == 2){
                  eventBus.fire(TPRefreshMessageListEvent(3));
              }
            },
          ),
        ));
      }),
    );
  }

  void _getPage(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

     @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: {
      }// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:{
      }
        break;
      case AppLifecycleState.paused:{
      } // 应用程序不可见，后台
        break;
      default : {
      }
        break;
    }
  }

}
