import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonModelManager/tld_qr_code_model_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_deteail_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_unopen_red_envelope_alert_view.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/tp_purse_info_list_view.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/View/tp_add_purse_action_sheet.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tp_create_import_purse_input_password_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/message_button.dart';
import '../View/purse_first_cell.dart';
import '../View/purse_cell.dart';
import '../View/purse_bottom_cell.dart';
import '../../MyPurse/Page/tld_my_purse_page.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import '../../../ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../CommonFunction/tld_common_function.dart';
import '../Model/tld_purse_model_manager.dart';

class TPPursePage extends StatefulWidget {
  TPPursePage({Key key,this.didClickMoreBtnCallBack}) : super(key: key);
  final Function didClickMoreBtnCallBack;

  @override
  _TPPursePageState createState() => _TPPursePageState();
}

class _TPPursePageState extends State<TPPursePage> with AutomaticKeepAliveClientMixin {
  TPPurseModelManager _manager;

  List _dataSource;

  double _totalAmount;

  RefreshController _controller;

  // StreamSubscription _unreadSubscription;

  TPQRCodeModelManager _qrCodeModelManager;

  StreamSubscription _refreshSubscription;

  bool _isLoading = false;

  // bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TPPurseModelManager();

    _dataSource = [];

    _totalAmount = 0.0;

    _controller = RefreshController(initialRefresh: true);

    _qrCodeModelManager = TPQRCodeModelManager();

    // _haveUnreadMessage = TPIMManager.instance.unreadMessage.length > 0;

    // _registerUnreadMessageEvent();

    _registerRefreshEvent();

    _getPurseInfoList(context);
  }

  // void _registerUnreadMessageEvent(){
  //   _unreadSubscription = eventBus.on<TPHaveUnreadMessageEvent>().listen((event) {
  //     setState(() {
  //       _haveUnreadMessage = event.haveUnreadMessage;
  //     });
  //   });
  // }

  void _registerRefreshEvent(){
    _refreshSubscription = eventBus.on<TPRefreshFirstPageEvent>().listen((event) {
      _controller.requestRefresh();
      _getPurseInfoList(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // _unreadSubscription.cancel();

    _refreshSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SmartRefresher(
        controller: _controller,
        child: _getBodyWidget(context),
        header: WaterDropHeader(complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete),),
        onRefresh:()=>_getPurseInfoList(context),
        ),
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
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TPMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: IconButton(icon: Icon(IconData(0xe6fe,fontFamily: 'appIconFonts'),color: Colors.white,), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (contenxt) => TPScanQrCodePage(
                  scanCallBack: (String qrCode){
                    _qrCodeModelManager.scanQRCodeResult(qrCode, (TPQRcodeCallBackModel callBackModel) async {
                      if (callBackModel.type == QRCodeType.redEnvelope){
                        _getRedEnvelopeInfo(callBackModel.data);
                      }else if(callBackModel.type == QRCodeType.transfer){
                        String toWalletAddres = callBackModel.data;
                         navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=> TPEchangeChooseWalletPage(
                            transferWalletAddress: toWalletAddres,
                            type: TPEchangeChooseWalletPageType.transfer,
                           ))).then((value) => _getPurseInfoList(context));
                      }else if (callBackModel.type == QRCodeType.inviteCode){
                        String inviteCode = callBackModel.data;
                        String token = await TPDataManager.instance.getAcceptanceToken();
                        if (token == null){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => TPAcceptanceLoginPage(inviteCode: inviteCode,)));
                        }else{
                          Fluttertoast.showToast(msg: '您已注册TP票据');
                        }
                      }
                    }, (TPError error){
                      Fluttertoast.showToast(msg: error.msg);
                    });
                  },
                )));
        },
      ),
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
      return TPPurseInfoListView(walletList: _dataSource,didClickItemCallBack: (int dataIndex){
        TPWalletInfoModel model = _dataSource[dataIndex];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  TPMyPursePage(wallet: model.wallet,changeNameSuccessCallBack: (String name){
                  setState(() {
                    TPDataManager.instance.purseList;
                  });
                },);
              },
            ),
          ).then((value) => _getPurseInfoList(context));
      },
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
    // else if (index == _dataSource.length + 3){
    //   return _getActionWidget();
    // }else {
    //   TPWalletInfoModel model = _dataSource[index - 2];
    //   return TPPurseFirstPageCell(
    //     walletInfo: model,
    //     didClickCallBack: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return  TPMyPursePage(wallet: model.wallet,changeNameSuccessCallBack: (String name){
    //               setState(() {
    //                 TPDataManager.instance.purseList;
    //               });
    //             },);
    //           },
    //         ),
    //       ).then((value) => _getPurseInfoList(context));
    //     },
    //   );
    // }
  }

  void _createPurse(BuildContext context) async{
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
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return TPCreateImportPurseInputPasswordPage(type : 0);
      }
    ));
    // jugeHavePassword(context, (){
    //    Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatingPursePage(type: TPCreatingPursePageType.create,)));
    // },TPCreatePursePageType.create,null);
  }

  void _importPurse(BuildContext context) async{
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
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return TPCreateImportPurseInputPasswordPage(type : 1);
      }
    ));

    // jugeHavePassword(context,(){
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> TPImportPursePage()));
    // },TPCreatePursePageType.import,null);
  }

  void _getPurseInfoList(BuildContext context){
    _manager.getWalletListData((List purseInfoList){
      _totalAmount = 0.0;
      _dataSource = [];
      if (mounted){
              setState(() {
        for (TPWalletInfoModel item in purseInfoList) {
          _totalAmount = _totalAmount + double.parse(item.value);
        }
        _dataSource = List.from(purseInfoList);
      });
      }
      _controller.refreshCompleted();
    }, (TPError error){
      _controller.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

  void _getRedEnvelopeInfo(String redEnvelopeId){
    setState(() {
      _isLoading = true;
    });
    _manager.getRedEnvelopeInfo(redEnvelopeId, (TPDetailRedEnvelopeModel redEnvelopeModel){
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
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.msg);
      }
    });
  }


  void _recieveRedEnvelope(String walletAddress,String redEnvelopeId){
    setState(() {
      _isLoading = true;
    });
    _manager.recieveRedEnvelope(redEnvelopeId, walletAddress, (int recieveLogId){
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

   Widget _getActionWidget(){
    List purseList = TPDataManager.instance.purseList;
    bool isHaveImport = false;
    for (TPWallet wallet in purseList) {
        if (wallet.type != null && wallet.type == 1){
          isHaveImport = true;
          break;
        }else{
          
        }
    }

    if (isHaveImport){
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(30))
      ,child: getButton(()=>(){}, I18n.of(context).createWalletBtnTitle, MediaQuery.of(context).size.width * 2,Theme.of(context).primaryColor));
    }else{
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(30)),
        child  :Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getButton(()=>(){
                  _createPurse(context);
                }, I18n.of(context).createWalletBtnTitle, MediaQuery.of(context).size.width,Theme.of(context).primaryColor),
                getButton(()=>(){
                  _importPurse(context);
                }, I18n.of(context).importWalletBtnTitle, MediaQuery.of(context).size.width,Theme.of(context).hintColor),
              ]));
    }
  }

  Widget getButton(Function didClickCallBack,String title, double scrrenWidth,Color color){
      return Container(
                 width : (scrrenWidth  - ScreenUtil().setWidth(100)) / 2.0,
                  child: CupertinoButton(
                  color: color,
              onPressed: () => didClickCallBack(),
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                  child: Text(
                           title,
                           textAlign: TextAlign.center,
                           style : TextStyle(color: Colors.white,fontSize: 14)),
                      ),
              );
  } 

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
}
///////