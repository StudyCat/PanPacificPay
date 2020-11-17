import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_input_slider_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_choose_mission_level_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_publish_mission_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_choose_mission_level_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPPublishMissionPage extends StatefulWidget {
  TPPublishMissionPage({Key key,this.walletAddress}) : super(key: key);

  final String walletAddress;

  @override
  _TPPublishMissionPageState createState() => _TPPublishMissionPageState();
}

class _TPPublishMissionPageState extends State<TPPublishMissionPage> {
  List titleList = ['钱包', '钱包余额', '发布总量', '任务等级', '其他费用扣除比例（任务奖励金）', '其他费用预计扣除（任务奖励金）', '预计到账', '收款方式'];

  TPPublishMissionFormModel _formModel;

  TPPublishMissionModelManager _modelManager;

  TPWalletInfoModel _walletInfoModel;

  bool _isLoading = true;

  FocusNode _saleAmountFocusNode;

  FocusNode _minAmountFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formModel = TPPublishMissionFormModel();
    _formModel.walletAddress = widget.walletAddress;
    _formModel.totalCount = '0.0';

    _modelManager = TPPublishMissionModelManager();

    _saleAmountFocusNode = FocusNode();
    _minAmountFocusNode = FocusNode();

    _getWalletInfo();
  }

  void _getWalletInfo(){
    _modelManager.getWalletInfo(widget.walletAddress, (TPWalletInfoModel infoModel){
      setState(() {
        _isLoading = false;
        _walletInfoModel = infoModel;
      });
    }, (TPError error){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: error.msg);
    });
  }

   void _publishMissionForm() {
    if(_formModel.levelModel == null){
        Fluttertoast.showToast(
          msg: '请选择任务等级', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(_formModel.paymentModel == null){
        Fluttertoast.showToast(
          msg: '请选择收款方式', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(double.parse(_formModel.totalCount) == 0.0){
        Fluttertoast.showToast(
          msg: '请填写任务总量', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    jugeHavePassword(context, (){
      _publishMission();
    }, TPCreatePursePageType.back, (){
      _publishMission();
    });
    
  }

  void _publishMission(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.publishMission(_formModel, () {
      if (mounted){
      setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(
          msg: '发布任务成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child:_walletInfoModel != null ? _getBody(context) : Container()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'publish_mission_page',
        transitionBetweenRoutes: false,
        middle: Text('发布任务'),
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
            type: TPExchangeNormalCellType.normal,
            title: titleList[index],
            content: _walletInfoModel.wallet.name,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 15,
          );
        } else if (index == 2) {
          return TPExchangeInputSliderCell(
            title: titleList[index],
            infoModel: _walletInfoModel,
            focusNode: _saleAmountFocusNode,
            inputCallBack: (String text) {
             _formModel.totalCount = text;
            },
          );
        }else if (index == 3){
          String content = _formModel.levelModel != null ? _formModel.levelModel.levelName : '请选择任务等级';
          return TPExchangeNormalCell(
            type: TPExchangeNormalCellType.normalArrow,
            title: titleList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 15,
            didClickCallBack: (){
              _saleAmountFocusNode.unfocus();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPNewMissionChooseMissionLevelPage(didChooseLevelCallBack: (TPMissionLevelModel levelModel){
                setState(() {
                  _formModel.levelModel = levelModel;
                });
              },)));
            },
          );
        }else if (index == titleList.length -1){
          return TPExchangePaymentCell(paymentModel: _formModel.paymentModel,didClickItemCallBack: (){
            _minAmountFocusNode.unfocus();
            _saleAmountFocusNode.unfocus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => TPChoosePaymentPage(walletAddress:widget.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TPPaymentModel paymentModel){
                setState(() {
                  _formModel.paymentModel = paymentModel;
                });
              },)));
          },);
        }else if (index == titleList.length) {
          return Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40), left: 15, right: 15),
            height: ScreenUtil().setHeight(135),
            child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  '出售',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                ),
                onPressed: () => _publishMissionForm()),
          );
        } else {
          String content = '';
          if (index == 1) {
            content = _walletInfoModel == null
                ? '0.0'
                : _walletInfoModel.value;
          }else if(index == 4){
            double profitRate = _formModel.levelModel != null ? double.parse(_formModel.levelModel.profitRate) : 0.0;
            double rate = _formModel.levelModel != null ? profitRate * 100 : 0;
            content = '$rate%';
          }else if (index == 5){
            double profitRate = _formModel.levelModel != null ? double.parse(_formModel.levelModel.profitRate) : 0.0;
            double profit = double.parse(_formModel.totalCount) * profitRate;
            String profitString = (NumUtil.getNumByValueDouble(profit, 3)).toStringAsFixed(3);
            content = profitString + 'TP';
          }else if (index == 6){
            double profitRate = _formModel.levelModel != null ? double.parse(_formModel.levelModel.profitRate) : 0.0;
            double profit = double.parse(_formModel.totalCount) * profitRate;
            double amount = double.parse(_formModel.totalCount) - profit;
            String amountString = (NumUtil.getNumByValueDouble(amount, 3)).toStringAsFixed(3);
            content = '¥' + amountString;
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
}