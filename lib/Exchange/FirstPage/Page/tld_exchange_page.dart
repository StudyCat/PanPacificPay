import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Model/tld_exchange_model_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_rate_slider_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_exchange_normalCell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_exchange_input_cell.dart';
import '../View/tld_exchange_input_slider_cell.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'tld_exchange_choose_wallet.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPExchangePage extends StatefulWidget {
  TPExchangePage({Key key,this.infoModel}) : super(key: key);

  final TPWalletInfoModel infoModel;


  @override
  _TPExchangePageState createState() => _TPExchangePageState();
}

class _TPExchangePageState extends State<TPExchangePage> {
  List titleList = [I18n.of(navigatorKey.currentContext).wallet,I18n.of(navigatorKey.currentContext).walletBalance ,I18n.of(navigatorKey.currentContext).saleAmount , I18n.of(navigatorKey.currentContext).minimumPurchaseAmountLabel,I18n.of(navigatorKey.currentContext).maximumPurchaseAmountLabel, I18n.of(navigatorKey.currentContext).serviceChargeRateLabel, I18n.of(navigatorKey.currentContext).serviceChargeLabel, I18n.of(navigatorKey.currentContext).realToTheAccount, I18n.of(navigatorKey.currentContext).collectionMethod];

  TPSaleFormModel _formModel;

  TPExchangeModelManager _manager;

  bool _isLoading;

  FocusNode _saleAmountFocusNode;

  FocusNode _minAmountFocusNode;

  FocusNode _maxAmountFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formModel = TPSaleFormModel();
    _formModel.maxBuyAmount = '0';
    _formModel.saleAmount = '0';
    _formModel.payMethodName = '微信支付';

    if (widget.infoModel != null){
      _formModel.infoModel = widget.infoModel;
      _formModel.rate = widget.infoModel.minRate;
    }

    _saleAmountFocusNode = FocusNode();
    _minAmountFocusNode = FocusNode();
    _maxAmountFocusNode = FocusNode();

    _isLoading = false;
    _manager = TPExchangeModelManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).sale),
        trailing: MessageButton(
          didClickCallBack: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => TPMessagePage())),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return ListView.builder(
      itemCount: titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return TPExchangeNormalCell(
            type: TPExchangeNormalCellType.normalArrow,
            title: titleList[index],
            content: _formModel.infoModel == null
                ? I18n.of(context).chooseWallet
                : _formModel.infoModel.wallet.name,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 15,
            didClickCallBack: () {
              _minAmountFocusNode.unfocus();
              _saleAmountFocusNode.unfocus();
              _maxAmountFocusNode.unfocus();
              if(widget.infoModel == null){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TPEchangeChooseWalletPage(
                            didChooseWalletCallBack:
                                (TPWalletInfoModel infoModel) {
                              setState(() {
                                _formModel.infoModel = infoModel;
                                _formModel.rate = infoModel.minRate;
                              });
                            },
                          )));
              }
            },
          );
        } else if (index == 2) {
          return TPExchangeInputSliderCell(
            title: titleList[index],
            infoModel: _formModel.infoModel,
            focusNode: _saleAmountFocusNode,
            inputCallBack: (String text) {
              setState(() {
                _formModel.saleAmount = text;
              });
            },
          );
        } else if (index == 3) {
          return TPExchangeInputCell(
              title: titleList[index],
              infoModel: _formModel.infoModel,
              focusNode: _minAmountFocusNode,
              inputCallBack: (String text) {
                _formModel.maxBuyAmount = text;
              });
        }else if (index == 4){
          return TPExchangeInputCell(
              title: titleList[index],
              top: 1,
              infoModel: _formModel.infoModel,
              focusNode: _maxAmountFocusNode,
              inputCallBack: (String text) {
                _formModel.maxAmount = text;
              });
        }else if (index == titleList.length -1){
          return TPExchangePaymentCell(paymentModel: _formModel.paymentModel,didClickItemCallBack: (){
            _minAmountFocusNode.unfocus();
            _saleAmountFocusNode.unfocus();
            _maxAmountFocusNode.unfocus();
            if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TPChoosePaymentPage(walletAddress:_formModel.infoModel.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TPPaymentModel paymentModel){
                setState(() {
                  _formModel.paymentModel = paymentModel;
                });
              },)));
            }
          },);
        }else if (index == titleList.length) {
          return Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40), left: 15, right: 15),
            height: ScreenUtil().setHeight(135),
            child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  I18n.of(context).sale,
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                ),
                onPressed: () => submitSaleForm()),
          );
        }else if(index == 5){
          return TPExchangeRateSliderCell(title: titleList[index],infoModel: _formModel.infoModel,didChangeRateCallBack: (String rate){
            setState(() {
              _formModel.rate = rate;
            });
          },);
        } else {
          String content = '';
          if (index == 1) {
            content = _formModel.infoModel == null
                ? '0.0'
                : _formModel.infoModel.value;
          } else if (index == 6) {
            if (_formModel.infoModel != null){
              double amount = double.parse(_formModel.saleAmount) * double.parse(_formModel.rate);
              String amountString = (NumUtil.getNumByValueDouble(amount, 3)).toStringAsFixed(3);
              content = amountString + 'TP';
            }else{
              content = '0TP';
            }
          } else if (index == 7) {
            if (_formModel.infoModel != null){
              double amount = double.parse(_formModel.saleAmount) * double.parse(_formModel.rate);
              double trueAmount = double.parse(_formModel.saleAmount) - amount;
              String trueAmountString = (NumUtil.getNumByValueDouble(trueAmount, 3)).toStringAsFixed(3);
              content = '¥' + trueAmountString;
            }else{
              content = '¥0';
            }
          }
          return TPExchangeNormalCell(
            type: TPExchangeNormalCellType.normal,
            title: titleList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 1,
          );
        }
      },
    );
  }

  void submitSaleForm() {
    if(double.parse(_formModel.saleAmount) == 0.0){
        Fluttertoast.showToast(
          msg: '请输入售卖量', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(double.parse(_formModel.maxBuyAmount) == 0.0){
        Fluttertoast.showToast(
          msg: '请输入最低购买额度', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(_formModel.infoModel == null){
        Fluttertoast.showToast(
          msg: '请选择钱包', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if (double.parse(_formModel.maxAmount) < double.parse(_formModel.maxBuyAmount)){
      Fluttertoast.showToast(
          msg: '最高额度不能小于最低额度', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(_formModel.paymentModel == null){
        Fluttertoast.showToast(
          msg: '请选择支付方式', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if (double.parse(_formModel.maxAmount) == 0.0) {
       Fluttertoast.showToast(
          msg: '请输入最高购买额度', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if (double.parse(_formModel.maxBuyAmount) > double.parse(_formModel.saleAmount)){
      Fluttertoast.showToast(msg: '最低购买额度不能大于售卖量',toastLength: Toast.LENGTH_SHORT,timeInSecForIosWeb: 1);
      return;
    }
   jugeHavePassword(context, (){
     _saleOrder();
   }, TPCreatePursePageType.back, (){
     _saleOrder();
   });
  }

  void _saleOrder(){
    setState(() {
      _isLoading = true;
    });
    _manager.submitSaleForm(_formModel, () {
      if (mounted){
      setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(
          msg: '兑换成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TPError error) {
      if (mounted){
      setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }
}
