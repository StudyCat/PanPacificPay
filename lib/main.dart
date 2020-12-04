import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'dart:async';
import 'CommonWidget/tld_data_manager.dart';
import 'tld_home_page.dart';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
  final JPush jPush = JPush();

  Future<void> initPlatformState() async {
    TPNewIMManager().init();

    jPush.setup(
      appKey: '553c2e8d1d518aa0a1359151',
      channel: "developer-default",
      production: false,
      debug: false,
    );

     jPush.getRegistrationID().then((rid)  {
      TPDataManager _manager = TPDataManager.instance;
      _manager.registrationID = rid;
    });

    jPush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true)
    );

    try {

      jPush.addEventHandler(
          onReceiveNotification: (Map<String,dynamic>message) async {
            
          },
          onOpenNotification: (Map<String,dynamic>message) async {
            if (Platform.isAndroid){
            Map extras = message['extras'];
            Map dataMap = jsonDecode(extras['cn.jpush.android.EXTRA']);
            int type  = int.parse(dataMap['contentType']);
            if (type == 100 || type == 101 || type == 102 || type == 103 || type == 104 || type == 107){
              navigatorKey.currentState.push( MaterialPageRoute(builder: (context) => TPDetailOrderPage(orderNo: dataMap['orderNo'],)));
            }else if ((type > 199 && type < 205) ||type == 207 || type == 208){
              String cashNo = dataMap['cashNo'];
              navigatorKey.currentState.push( MaterialPageRoute(builder: (context)=>TPAcceptanceDetailWithdrawPage(cashNo:cashNo,)));
            }else if (type == 105){
              String walletAddress = dataMap['toAddress'];
                List purseList = TPDataManager.instance.purseList;
                TPWallet wallet;
                for (TPWallet item in purseList) {
                  if (item.address == walletAddress){
                    wallet = item;
                    break;
                  }
                }
              navigatorKey.currentState.push( MaterialPageRoute(builder: (context) => TPMyPursePage(wallet: wallet,changeNameSuccessCallBack: (str){},)));
            }else if (type == 106){
              String appealId = dataMap['appealId'];
              navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => TPJustNoticePage(appealId: int.parse(appealId))));
            }
          }
          }
      );
    } on Exception {
      print("---->获取平台版本失败");
    }
  }

  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initPlatformState();
  }

  
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  StreamSubscription _messageSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // _registerEvent();  
  }


  // void _registerEvent(){
  //   _messageSubscription = eventBus.on<TPMessageEvent>().listen((event) {
  //       List messageList = event.messageList;
  //       for (TPMessageModel item in messageList) {
  //         if (item.messageType == 2){
  //           _incrementCounter(item);
  //         }
  //       }
  //   });
  // }

    // void _incrementCounter(TPMessageModel model) async {
    //    bool isFromOther = false; //是否为别人发的消息
    //    String fromAddress = model.fromAddress;
    //    List purseList = TPDataManager.instance.purseList;
    //    List addressList = [];          
    //    for (TPWallet item in purseList) {
    //        addressList.add(item.address);
    //    }
    //   if (!addressList.contains(fromAddress)){
    //       isFromOther = true;
    //    }
    //   if (isFromOther){
    //    String content;
    //    if (model.contentType == 1){
    //      content = model.content;
    //    }else{
    //      content = '[图片]';
    //    }
    //    Map map = model.toJson();
    //    String mapJson = jsonEncode(map);
    //    String title = '来自订单号'+ model.orderNo + '的聊天消息'; 
    //    var android = new AndroidNotificationDetails(
    //     'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
    //     priority: Priority.High,importance: Importance.Max
    //    );
    //    var iOS = new IOSNotificationDetails();
    //    var platform = new NotificationDetails(android, iOS);
    //    await flutterLocalNotificationsPlugin.show(
    //      0, title, content, platform,
    //      payload:mapJson);
    //    }
    // }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
   
  }

  Future<void> onSelectNotification(String playload) async {
    Map message = jsonDecode(playload);
    // TPMessageModel model =  TPMessageModel.fromJson(message);
    // navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => TPIMPage(otherGuyWalletAddress: model.fromAddress,selfWalletAddress: model.toAddress,orderNo: model.orderNo,)));
  }

  @override
  void dispose() { 
    _messageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'TP',
      navigatorKey: navigatorKey,
       localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: I18n.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (deviceLocale, supportedLocales){
        TPDataManager.instance.currentLocal = deviceLocale;
        if (deviceLocale.languageCode == "zh"){
          return Locale("zh", "CN");
        }else{
          return Locale("en", "UN");
        }
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 1, 141, 248),
        hintColor: Color.fromARGB(255, 254, 168, 89)
      ),
      home: TPHomePage(),
      // home: PlatformChannel(),
    );
  }
}









