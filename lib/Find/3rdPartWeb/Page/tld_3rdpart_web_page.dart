import 'dart:convert';
import 'dart:math';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Model/tld_3rdpart_web_model_manager.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_pay_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Model/tld_transfer_accounts_model_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TP3rdPartWebPage extends StatefulWidget {
  TP3rdPartWebPage({Key key,this.urlStr,this.isNeedHideNavigation}) : super(key: key);

  final String urlStr;

  final bool isNeedHideNavigation;

  @override
  _TP3rdPartWebPageState createState() => _TP3rdPartWebPageState();
}

class _TP3rdPartWebPageState extends State<TP3rdPartWebPage> {

  String _title = '';

  WebViewController _controller;

  bool _loading = false;

  TP3rdPartWebModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TP3rdPartWebModelManager();
  }


  void _signPramater(Map pramaterMap,String walletAddress){
    _manager.getRequestSign(pramaterMap, walletAddress, (Map data){
      String status = _getPayStatus(200, '验签成功', data);
      _payCallBackToWeb(status);
    });
  }

   void _tranferAmount(TPTranferAmountPramaterModel pramaterModel) {
    //   if (pramaterModel.fromWalletAddress == null){
    //     Fluttertoast.showToast(msg: '请先选择支付钱包');
    //     return;
    //   }
    //   setState(() {
    //     _loading = true;
    //   });
    // _manager.transferAmount(pramaterModel, (int txId) {
    //   if (mounted) {
    //     setState(() {
    //       _loading = false;
    //     });
    //   }


    //   Fluttertoast.showToast(
    //   msg: '充值成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
    //   String status = _getPayStatus(200, '充值成功', '$txId');
    //   _payCallBackToWeb(status);
    // }, (TPError error) {
    //   if (mounted) {
    //     setState(() {
    //       _loading = false;
    //     });
    //   }
    //   Fluttertoast.showToast(
    //       msg: error.msg,
    //       toastLength: Toast.LENGTH_SHORT,
    //       timeInSecForIosWeb: 1);
    //   String status = _getPayStatus(error.code, error.msg, '');
    //   _payCallBackToWeb(status);
    // });
  }

  void _payCallBackToWeb(String status){
    _controller?.evaluateJavascript("getTransferStatus('$status')")
                ?.then((result) {
                  
    });
  }

  String _getPayStatus(int code,String mesg,Map data){
    Map callBackMap = {'code':code,'msg':mesg,'data':data};
    String callBackMapStr = jsonEncode(callBackMap);
    return callBackMapStr;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNeedHideNavigation == false){
       return Scaffold(
        appBar: CupertinoNavigationBar(
          border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
          ),
          heroTag: 'web_page',
          transitionBetweenRoutes: false,
          middle: Text(_title),
          backgroundColor: Color.fromARGB(255, 242, 242, 242),
          actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        ),
        body: widget.urlStr.length > 0 ? LoadingOverlay(isLoading: _loading, child: _getWebWidget()) : Container(),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }else{
     return Scaffold(
       body : Padding(
       padding: EdgeInsets.only(top : MediaQuery.of(context).padding.top), 
       child: widget.urlStr.length > 0 ? LoadingOverlay(isLoading: _loading, child: _getWebWidget()) : Container())
     );
  }

  }

  Widget _getWebWidget(){
    return  WebView(
        onWebViewCreated: (contronller){
          _controller = contronller;
        },
        initialUrl : widget.urlStr,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
        _controller.evaluateJavascript('document.title').then((result){
          String title = result;
          if (result.contains('\"')){
            title = title.replaceAll(RegExp(r'"'), '');
          }
          setState(() {
            _title = title;
          });
        }
      );
      },
      javascriptChannels: <JavascriptChannel>[
              _getPayJSChannel(),_getWithdrawJSChannel(),_cloes3rdPartWebChannel(),_getLoginUserTokenChannel()
            ].toSet(),); 
  }

  JavascriptChannel _getPayJSChannel(){
    return JavascriptChannel(
                name: "tldTransferAccount",
                onMessageReceived: (JavascriptMessage message) {
                  String mapStr = message.message;
                  Map pramater = jsonDecode(mapStr);
                  String amount = pramater['amount'].toString();
                  String orderInfo = pramater['orderInfo'].toString();
                  showModalBottomSheet(context: context, isDismissible: false , builder: (context){
                    return TP3rdPartWebPayPage(
                      amount: amount,
                      orderInfo: orderInfo,
                      didClickCancelBtn: (){
                        String status = _getPayStatus(501, '用户取消支付', {});
                        _payCallBackToWeb(status);
                      },
                      didClickPayBtnCallBack: (TPTranferAmountPramaterModel pramaterModel){
                        _signPramater(pramater, pramaterModel.fromWalletAddress);
                      },
                    );
                  });
                }
              );
  }


  JavascriptChannel _getLoginUserTokenChannel(){
    return JavascriptChannel(
      name: 'tldLogin', 
      onMessageReceived: (JavascriptMessage message){
        String userToken = TPDataManager.instance.userToken;
        _controller?.evaluateJavascript("getUserToken('$userToken')")
                            ?.then((result) {
                      });
      });
  }

  JavascriptChannel _getWithdrawJSChannel(){
    return JavascriptChannel(
                name: "tldWithdraw",
                onMessageReceived: (JavascriptMessage message) {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(
                   didChooseWalletCallBack: (TPWalletInfoModel infModel){
                     _controller?.evaluateJavascript("getWithDrawWalletAddress('${infModel.walletAddress}')")
                            ?.then((result) {
                      });
                   },
                 )));
                }
              );
  }

  JavascriptChannel _cloes3rdPartWebChannel(){
    return JavascriptChannel(
                name: "cloesApp",
                onMessageReceived: (JavascriptMessage message) {
                  Navigator.of(context).pop();
                }
              );
  }

}