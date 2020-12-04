import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_buy_action_sheet_input_view.dart';
import '../../../Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';

class TPBuyActionSheet extends StatefulWidget {
  TPBuyActionSheet({Key key,this.model,this.missionModel,this.didClickBuyBtnCallBack,this.rate}) : super(key: key);

  final TPBuyListInfoModel model;

  final TPMissionBuyModel missionModel;

  final Function(TPBuyPramaterModel) didClickBuyBtnCallBack;

  final double rate;

  @override
  _TPBuyActionSheetState createState() => _TPBuyActionSheetState();
}

class _TPBuyActionSheetState extends State<TPBuyActionSheet> {
  
  TPBuyPramaterModel _pramaterModel;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramaterModel = TPBuyPramaterModel();
    _pramaterModel.buyCount = '0';
    _pramaterModel.sellNo = widget.model != null ? widget.model.sellNo : widget.missionModel.sellNo;

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cnyAmountNum = double.parse(_pramaterModel.buyCount) * widget.rate;
    String cnyAmountStr = (NumUtil.getNumByValueDouble(cnyAmountNum, 2)).toStringAsFixed(2);
    String amount = _pramaterModel.buyCount + 'USD' + '≈' + cnyAmountStr + 'CNY';
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90.w, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Container(
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(40)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(I18n.of(context).buyBtnTitle,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TPBuyActionSheetInputView(focusNode: _focusNode,maxAmount: widget.model != null ? widget.model.maxAmount : widget.missionModel.maxAmount, max: widget.model != null ? widget.model.max : widget.missionModel.max,currentAmount: widget.model != null ? widget.model.currentCount : widget.missionModel.currentCount,inputStringCallBack: (String text){
              setState(() {
                _pramaterModel.buyCount = text;
              });
            },),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView(I18n.of(context).minimumPurchaseAmountLabel, widget.model != null ? widget.model.max : widget.missionModel.max + 'TP'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView(I18n.of(context).maximumPurchaseAmountLabel, widget.model != null ? widget.model.maxAmount : widget.missionModel.maxAmount + 'TP'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView(I18n.of(context).realPaymentLabel, amount),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: GestureDetector(
              onTap:(){
                _focusNode.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                  setState(() {
                    _pramaterModel.buyerAddress = infoModel.walletAddress;
                  });
                },)));
              },
              child : getArrowView(I18n.of(context).receiveAddressLabel, _pramaterModel.buyerAddress == null ? I18n.of(context).chooseWalletLabel: _pramaterModel.buyerAddress)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text(I18n.of(context).placeOrderBtnTitle,style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (double.parse(_pramaterModel.buyCount) == 0.0){
                Fluttertoast.showToast(msg: I18n.of(context).inputBuyAmountFieldPlaceholder,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              if (_pramaterModel.buyerAddress == null){
                Fluttertoast.showToast(msg: I18n.of(context).chooseWalletLabel,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              // if (double.parse(_pramaterModel.buyCount) < double.parse(widget.model.max) && double.parse(widget.model.max) < double.parse(widget.model.totalCount)){
              //   Fluttertoast.showToast(msg: '输入的购买数量低于最低购买额度',toastLength: Toast.LENGTH_SHORT,
              //           timeInSecForIosWeb: 1);
              //   return;
              // }
              widget.didClickBuyBtnCallBack(_pramaterModel);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    )])),
    );
  }

  Widget getNormalView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
      ],
    );
  }

  Widget getArrowView(String title, String content) {
    return Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60), 
      child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Container(
            width : ScreenUtil().setWidth(280),
            child : Text(
            content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          )),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    )
    );
  }
}
