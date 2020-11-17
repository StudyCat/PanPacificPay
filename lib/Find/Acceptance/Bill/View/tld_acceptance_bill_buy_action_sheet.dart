import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_choose_type_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_choose_type_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPAcceptanceBillBuyActionSheet extends StatefulWidget {
  TPAcceptanceBillBuyActionSheet({Key key,this.infoListModel,this.didClickChooseWallet,this.didChooseCountCallBack,this.didClickBuyButtonCallBack,this.didChooseYLBType,this.didChoosePaymentType}) : super(key: key);

  final TPBillInfoListModel infoListModel;

  final Function(String) didClickChooseWallet;

  final Function didClickBuyButtonCallBack;

  final Function(int) didChooseCountCallBack;

  final Function didChoosePaymentType;

  final Function didChooseYLBType; 

  @override
  _TPAcceptanceBillBuyActionSheetState createState() =>
      _TPAcceptanceBillBuyActionSheetState();
}

class _TPAcceptanceBillBuyActionSheetState
    extends State<TPAcceptanceBillBuyActionSheet> {
  int _vote = 0;

  int _paymentType = 1;

  TPWalletInfoModel _infoModel;

  TPYLBTypeModel _ylbTypeModel;

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(40),
                          left: ScreenUtil().setWidth(30),
                          right: ScreenUtil().setWidth(30),
                          bottom: ScreenUtil().setHeight(30)),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(I18n.of(context).buyBill,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  decoration: TextDecoration.none)),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40)),
                              child: _getBillInfoView()),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40)),
                            child: _getChooseWidgetView(),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(32)),
                              child: _getRealAmount()),
                          _getChoicePayMethodWidget(),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(32)),
                            child: _getChooseWalletRowWidget(),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(28)),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: ScreenUtil().setHeight(80),
                                child: CupertinoButton(
                                  child: Text(
                                    I18n.of(context).submitOrder,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(28)),
                                  ),
                                  onPressed: () {
                                    if (_vote == 0) {
                                      Fluttertoast.showToast(msg: '请先选择份数');
                                      return;
                                    }
                                    if (_paymentType == 1 &&
                                        _infoModel == null) {
                                      Fluttertoast.showToast(msg: '请先选择钱包');
                                      return;
                                    }
                                    if (_paymentType == 2 &&
                                        _ylbTypeModel == null) {
                                      Fluttertoast.showToast(msg: '请先选择余利宝类型');
                                      return;
                                    }
                                    widget.didClickBuyButtonCallBack();
                                    Navigator.of(context).pop();
                                  },
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(0),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ])));
  }

  Widget _getBillInfoView() {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Icon(
                IconData(0xe670, fontFamily: 'appIconFonts'),
                size: ScreenUtil().setWidth(40),
                color: Theme.of(context).hintColor,
              )),
              TextSpan(
                  text: '  ${widget.infoListModel.billLevel}' + I18n.of(context).levelBill,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102),
                      fontSize: ScreenUtil().setSp(28)))
            ])),
            Text(
              I18n.of(context).univalence  +'：${widget.infoListModel.billPrice}TP',
              style: TextStyle(
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontSize: ScreenUtil().setSp(28),
                  decoration: TextDecoration.none),
            )
          ]),
    );
  }

  Widget _getChoicePayMethodWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
          child : Text('选择支付方式',style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(32),decoration: TextDecoration.none))
        ),
        Padding(padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
          child: Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getPaymentChoiceList(),
        )),
        )
      ],
    );
  }

  List<Widget> _getPaymentChoiceList(){
    List<Widget> result = [];
    for(int i = 1 ; i < 3; i++){
      result.add(_getPaymentSingleChoiceWidget(i));
    }
    return result;
  }

  Widget _getPaymentSingleChoiceWidget(int type){
     String text;
    if (type == 1) {
      text = '钱包支付';
    } else if (type == 2) {
      text = '余利宝支付';
    }
    return Row(children: <Widget>[
      Radio(
        value: type,
        groupValue: _paymentType,
        onChanged: (value) {
          setState(() {
            _paymentType = value;
          });
          widget.didChoosePaymentType(_paymentType);
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(0)),
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(28)),
          ))
    ]);
  }

  Widget _getChooseWidgetView() {
    return Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getChoiceList(),
        ));
  }

  List<Widget> _getChoiceList(){
    int count = widget.infoListModel.totalBuyCount - widget.infoListModel.alreadyBuyCount;
    int realCount = count;
    if (count > 4){
      realCount = 4;
    }

    List<Widget> result = [];
    for(int i = 1 ; i < realCount + 1; i++){
      result.add(_getSingleChoiceWidget(i));
    }
    return result;
  }



  Widget _getSingleChoiceWidget(int type) {
    String text;
    if (type == 1) {
      text = '1' + I18n.of(context).part;
    } else if (type == 2) {
      text = '2'+ I18n.of(context).part;
    } else if (type == 3) {
      text = '3' + I18n.of(context).part;
    } else {
      text = '4' + I18n.of(context).part;
    }
    return Row(children: <Widget>[
      Radio(
        value: type,
        groupValue: _vote,
        onChanged: (value) {
          setState(() {
            _vote = value;
          });
          widget.didChooseCountCallBack(value);
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(0)),
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(28)),
          ))
    ]);
  }

  Widget _getRealAmount() {
    double realAmount = _vote * double.parse(widget.infoListModel.billPrice);
    return RichText(
        text: TextSpan(
            text: I18n.of(context).actuallyPaid + '：',
            style: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: ScreenUtil().setSp(28),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: '${realAmount}TP',
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: ScreenUtil().setSp(48),
            ),
          )
        ]));
  }

  Widget _getChooseWalletRowWidget(){
    String title = '';
    if (_paymentType == 1){
      title = _infoModel != null ? _infoModel.wallet.name : I18n.of(context).chooseWalletLabel;
    }else {
      title = _ylbTypeModel != null ? _ylbTypeModel.typeName : '选择余利宝类型';
    }
    return GestureDetector(
      onTap: (){
        if (_paymentType == 1){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>TPEchangeChooseWalletPage(
                                      didChooseWalletCallBack:(TPWalletInfoModel infoModel) {
                                        setState(() {
                                          _infoModel = infoModel;
                                        });
                                        widget.didClickChooseWallet(infoModel.walletAddress);
                                      },
                                    )));
        }else{
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>TPYLBChooseTypePage(
                                      didChooseTypeCallBack:(TPYLBTypeModel typeModel) {
                                        setState(() {
                                          _ylbTypeModel = typeModel;
                                        });
                                        widget.didChooseYLBType(_ylbTypeModel.type);
                                      },
                                    )));
        }
      },
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(150),
          child :Text(title,
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: ScreenUtil().setSp(28),
                  decoration: TextDecoration.none),)
        ),
        Icon(Icons.keyboard_arrow_right)
      ],
    ),
    );
  }
}
