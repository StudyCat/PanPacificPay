import 'dart:async';

import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Purse/FirstPage/View/message_button.dart';
import 'IMUI/Page/tld_im_page.dart';
import 'Message/Page/tld_message_page.dart';
import 'ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'CommonFunction/tld_common_function.dart';
import 'ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import 'ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'dart:io';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart';

class TPNotPurseHomePage extends StatefulWidget {
  TPNotPurseHomePage({Key key}) : super(key: key);

  @override
  _TPNotPurseHomePageState createState() => _TPNotPurseHomePageState();
}

class _TPNotPurseHomePageState extends State<TPNotPurseHomePage> with WidgetsBindingObserver {

  TPDataBaseManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _manager = TPDataBaseManager();

    _initPlatformStateForStringUniLinks();
  }

    /// An implementation using a [String] link
  _initPlatformStateForStringUniLinks() async {
    // Get the latest link
    bool isHaveWallet = await _searchAllPurse();
    if (!isHaveWallet) {
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
      if (queryParameter.containsKey('path')) {
        String path = queryParameter['path'];
        if (path == 'createWallet') {
        jugeHavePassword(context, (){
          Future.delayed(Duration.zero,(){
             navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=> TPCreatingPursePage(type: TPCreatingPursePageType.create,)));
          });
        },TPCreatePursePageType.create,null);
        }
      }

    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    }
  }

  Future<bool> _searchAllPurse()async{
    await _manager.openDataBase();
     List allPurse = await _manager.searchAllWallet();
    await _manager.closeDataBase();
    allPurse == null ? TPDataManager.instance.purseList = [] : TPDataManager.instance.purseList = List.from(allPurse);

      if(allPurse != null && allPurse.length > 0){
          return true;
      }else{
        return false;
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).commonPageTitle),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(130)),
          child: Image.asset(
            'assetss/images/no_purse_page_icon.png',
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
          child: Text(I18n.of(context).noWalletHint,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: (size.width - ScreenUtil().setWidth(220)) / 2,
                height: ScreenUtil().setHeight(80),
                child: _getActionButton(I18n.of(context).createWalletBtnTitle, () {
                  _createPurse(context);
                }),
              ),
              Container(
                width: (size.width - ScreenUtil().setWidth(220)) / 2,
                height: ScreenUtil().setHeight(80),
                child: _getActionButton(I18n.of(context).importWalletBtnTitle, () {
                  _importPurse(context);
                }),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.white),
              child: Text(
                I18n.of(context).homePageNotice,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153)),
              )),
        )
      ],
    ));
  }

  Widget _getActionButton(String title, Function didClickCallBack) {
    return CupertinoButton(
        child: Text(
          title,
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        padding: EdgeInsets.all(0),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        onPressed: didClickCallBack);
  }

  void _createPurse(BuildContext context) async {
        var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    jugeHavePassword(context, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TPCreatingPursePage(
                    type: TPCreatingPursePageType.create,
                  )));
    }, TPCreatePursePageType.create, null);
  }

  void _importPurse(BuildContext context) async {
            var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    jugeHavePassword(context, () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TPImportPursePage()));
    }, TPCreatePursePageType.import, null);
  }

  

  //  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print("--" + state.toString());
  //   switch (state) {
  //     case AppLifecycleState.inactive: {
  //       TPIMManager.instance.isInBackState = true;
  //     }// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
  //       break;
  //     case AppLifecycleState.resumed:{
  //       TPIMManager.instance.isInBackState = false;
  //       TPIMManager.instance.connectClient();
  //     }
  //       break;
  //     case AppLifecycleState.paused:{
  //       TPIMManager.instance.isInBackState = true;
  //     } // 应用程序不可见，后台
  //       break;
  //     default : {
  //       TPIMManager.instance.isInBackState = true;
  //     }
  //       break;
  //   }
  // }

}
