import 'dart:async';
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dataBase/tld_database_manager.dart';
import 'tld_not_purse_page.dart';
import 'tld_tabbar_page.dart';
import 'CommonWidget/tld_data_manager.dart';



class TPHomePage extends StatefulWidget {
  TPHomePage({Key key}) : super(key: key);

  @override
  _TPHomePageState createState() => _TPHomePageState();
}

class _TPHomePageState extends State<TPHomePage> {

  TPDataBaseManager _manager;

  bool isHavePurse;

  bool _isLogin;

  JPush jPush;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TPDataBaseManager();

    _isLogin = true;

    isHavePurse = false;

    // await _searchAllPurse();

    _checkIsLogin();

    _searchAllPurse();

    _openPermmision();

    _checkVersion();
  }

  void _openPermmision() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.notification,
      Permission.phone
      ].request();
  }

  void _checkVersion(){
    TPBaseRequest request = TPBaseRequest({},'common/tldVersionUpdate');
    request.postNetRequest((value) async{
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      if (version != value['tldVersion']) {
        showDialog(context: context,builder: (context){
        return TPAlertView(title: '版本更新',alertString: value['updateDesc'],sureTitle:  '更新',didClickSureBtn: (){
          _downloadNewApk(value['apkUrl']);
        },);
      });
      }
    }, (TPError error){

    });
  }

  _downloadNewApk(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  void _searchAllPurse()async{
    await _manager.openDataBase();
     List allPurse = await _manager.searchAllWallet();
    await _manager.closeDataBase();
    allPurse == null ? TPDataManager.instance.purseList = [] : TPDataManager.instance.purseList = List.from(allPurse);

      if(allPurse != null && allPurse.length > 0){
        if (mounted){
        setState(() {
          isHavePurse = true;
        });
        }
      }
  }

  void _checkIsLogin() async {
    var token = await TPDataManager.instance.getAcceptanceToken();
    setState(() {
      _isLogin = token != null; 
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
      if (isHavePurse){
        if (_isLogin){
          return TPTabbarPage();
        }else{
          return TPRegisterView();
        } 
      }else{
        return TPNotPurseHomePage();
      }

    // FutureBuilder(
    //   future: _searchAllPurse(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData){
    //       return Container(
    //         width: 0,
    //         height: 0,
    //       );
    //     }else{
    //        bool isHavePurse = snapshot.data;
    //     if(isHavePurse == false){
    //       return TPNotPurseHomePage();
    //     }else{
    //       return TPTabbarPage(); 
    //     }
    //     }
    //   },
    // );
  }
}