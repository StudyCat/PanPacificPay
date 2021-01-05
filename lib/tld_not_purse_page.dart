import 'dart:async';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/purse_bottom_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/purse_first_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/tp_purse_info_list_view.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/View/tp_add_purse_action_sheet.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tp_create_import_purse_input_password_page.dart';

class TPNotPurseHomePage extends StatefulWidget {
  TPNotPurseHomePage({Key key}) : super(key: key);

  @override
  _TPNotPurseHomePageState createState() => _TPNotPurseHomePageState();
}

class _TPNotPurseHomePageState extends State<TPNotPurseHomePage> with WidgetsBindingObserver {

  TPDataBaseManager _manager;

  List _dataSource = [];

  double _totalAmount = 0.0;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _dataSource = [];

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
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: _getBodyWidget(context),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).commonPageTitle,style: TextStyle(color : Colors.white),),
        automaticallyImplyLeading: false,
    ));
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _getListViewItem(context,index),
      itemCount: 3,
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
    if (index == 0) {
      return TPPurseHeaderCell(totalAmount:  _totalAmount,);
    }else if (index == 1){
      return TPPurseInfoListView(walletList: _dataSource,
      didClickAddPurseCallBack: (){
        showModalBottomSheet(context: context, builder: (context){
          return TPAddPurseActionSheet(
            didClickCreatePurseCallBack: (){
              _createPurse(context);
            },
            didClickImportPurseCallBack: (){
              _importPurse(context);
            },
          );
        });
      },
      );
    }else {
      return TPPurseFirstPageBottomCell();
    } 
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
    String password = await TPDataManager.instance.getPassword();
    if (password == null){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatePursePage(type: TPCreatePursePageType.create,setPasswordSuccessCallBack: (){
         },)));
         return;
    }
     Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreateImportPurseInputPasswordPage(type : 0)));
    // jugeHavePassword(context, () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => TPCreatingPursePage(
    //                 type: TPCreatingPursePageType.create,
    //               )));
    // }, TPCreatePursePageType.create, null);
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
    String password = await TPDataManager.instance.getPassword();
    if (password == null){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatePursePage(type: TPCreatePursePageType.import,setPasswordSuccessCallBack: (){
         },)));
         return;
    }
     Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreateImportPurseInputPasswordPage(type : 1)));
    // jugeHavePassword(context, () {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => TPImportPursePage()));
    // }, TPCreatePursePageType.import, null);
  }
}
