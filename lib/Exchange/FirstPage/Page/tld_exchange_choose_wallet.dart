import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_wallet_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Page/tld_transfer_accounts_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../Purse/FirstPage/View/purse_cell.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import '../Model/tld_exchange_choose_wallet_model_manager.dart';

enum TPEchangeChooseWalletPageType{
  normal,
  transfer,
  binding
}

class TPEchangeChooseWalletPage extends StatefulWidget {
  TPEchangeChooseWalletPage({Key key,this.didChooseWalletCallBack,this.type = TPEchangeChooseWalletPageType.normal,this.transferWalletAddress,this.transferAmount}) : super(key: key);

  final Function(TPWalletInfoModel) didChooseWalletCallBack;

  final TPEchangeChooseWalletPageType type;

  final String transferWalletAddress;

  final String transferAmount;

  @override
  _TPEchangeChooseWalletPageState createState() => _TPEchangeChooseWalletPageState();
}

class _TPEchangeChooseWalletPageState extends State<TPEchangeChooseWalletPage> {

  List _dataSource = [];

  StreamController _streamController;

  TPExchangeChooseWalletModelManager _modelManager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPExchangeChooseWalletModelManager();
    
    getWalletList();

    _streamController = StreamController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_choose_purse_page',
        transitionBetweenRoutes: false,
        middle: widget.type == TPEchangeChooseWalletPageType.binding ? Text('绑定钱包') : Text(I18n.of(context).chooseWallet),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

    Widget _getBodyWidget(BuildContext context) {
    return TPEmptyListView(
      streamController: _streamController,
      getEmptyViewCallBack: (){
        return TPEmptyWalletView();
      },
      getListViewCellCallBack: (int index){
        return _getListViewItem(context,index);
      },
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
      TPWalletInfoModel model = _dataSource[index];
      return TPPurseFirstPageCell(
        walletInfo: model,
        didClickCallBack: () {
          if (widget.type == TPEchangeChooseWalletPageType.normal){
            widget.didChooseWalletCallBack(model);
            Navigator.of(context).pop();
          }else if(widget.type == TPEchangeChooseWalletPageType.binding){
            _bindingWalletAddress(model.walletAddress);
          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TPTransferAccountsPage(type: TPTransferAccountsPageType.fromOtherPage,thirdAppFromWalletAddress: model.walletAddress,thirdAppToWalletAddress: widget.transferWalletAddress,)));
          }
        },);
  }

  void getWalletList(){
    _modelManager.getWalletListData(false,(List infoList) {
        _dataSource = List.from(infoList);
        if (mounted){
          _streamController.sink.add(_dataSource);
        }
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  void _bindingWalletAddress(String walletAddress){
    setState(() {
      _isLoading = true;
    });
    _modelManager.bindingWalletAddress(walletAddress, (){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(
        builder : (context) => TPAcceptanceTabbarPage()
      ));
    }, (TPError error){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }
}