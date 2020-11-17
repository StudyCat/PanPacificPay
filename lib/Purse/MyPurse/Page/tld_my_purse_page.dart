import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Model/tld_my_purse_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_my_purse_header.dart';
import '../View/tld_my_purse_content_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Settings/Page/tld_purse_setting_page.dart';
import '../../TransferAccounts/Page/tld_transfer_accounts_page.dart';
import '../../QRCode/Page/tld_qr_code_page.dart';
import '../../FirstPage/Model/tld_wallet_info_model.dart';

class TPMyPursePage extends StatefulWidget {
  TPMyPursePage({Key key,this.wallet,this.changeNameSuccessCallBack}) : super(key: key);

  final TPWallet wallet;

  final ValueChanged<String> changeNameSuccessCallBack;

  @override
  _TPMyPursePageState createState() => _TPMyPursePageState();
}

class _TPMyPursePageState extends State<TPMyPursePage> {
  TPWalletInfoModel _infoModel;

  TPMyPurseModelManager _modelManager;

  bool _isloading;

  // StreamSubscription _systemSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPMyPurseModelManager();

    _getWalletInfo();

    // _registerSystemEvent();
    _addSystemMessageCallBack();
  }

  void _getWalletInfo(){
    setState(() {
      _isloading = true;
    });
    _modelManager.getWalletData(widget.wallet, (TPWalletInfoModel infoModel){
      if (mounted){
              setState(() {
        _isloading = false;
        _infoModel = infoModel;
      });
      }
    }, (TPError error){
      if (mounted){
              setState(() {
        _isloading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 105){
        _getWalletInfo();
      }
    });
  }


  // void _registerSystemEvent(){
  //   _systemSubscription = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if(messageModel.contentType == 105){
  //       _getWalletInfo();
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
    // _systemSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'my_purse_page',
        transitionBetweenRoutes: false,
        middle: Text(widget.wallet.name,style: TextStyle(color : Colors.white),),
        trailing: Container(
            width: ScreenUtil().setWidth(160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TPOrderListPage(walletAddress : widget.wallet.address)));
                    }),
                CupertinoButton(
                    child: Icon(
                      IconData(0xe615, fontFamily: 'appIconFonts'),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TPPurseSettingPage(wallet : widget.wallet,nameChangeSuccessCallBack: (String name){
                              widget.changeNameSuccessCallBack(name);
                              setState(() {
                                widget.wallet.name = name;
                              });
                            },);
                          },
                        ),
                      );
                    }),
              ],
            )),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: LoadingOverlay(isLoading: _isloading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Column(children: <Widget>[
      TPMyPurseHeaderView(infoModel: _infoModel,didClickTransferAccountsBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TPTransferAccountsPage(walletInfoModel: _infoModel,transferSuccessCallBack: (String str){
          _getWalletInfo();
        },)));
      },
      didClickChangeBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TPExchangePage(infoModel: _infoModel,)));
      },
      didClickQRCodeBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TPQRCodePage(infoModel: _infoModel,)));
      },
      ),
      Expanded(
        child: TPMyPurseContentView(walletAddress: widget.wallet.address,),
      )
    ]);
  }
}
