import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Model/tld_transfer_accounts_model_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TP3rdPartWebPayPage extends StatefulWidget {
  TP3rdPartWebPayPage({Key key,this.amount,this.walletAddress,this.orderInfo,this.didClickPayBtnCallBack,this.didClickCancelBtn}) : super(key: key);

  final String walletAddress;

  final String amount;

  final String orderInfo;

  final Function(TPTranferAmountPramaterModel) didClickPayBtnCallBack;

  final Function() didClickCancelBtn;

  @override
  _TP3rdPartWebPayPageState createState() => _TP3rdPartWebPayPageState();
}

class _TP3rdPartWebPayPageState extends State<TP3rdPartWebPayPage> {

  TPTranferAmountPramaterModel _pramaterModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramaterModel = TPTranferAmountPramaterModel();
    _pramaterModel.isRecharge = true;
    _pramaterModel.value = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      height: ScreenUtil().setHeight(500),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getHeaderWidget(),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: RichText(
            text: TextSpan(text: widget.amount,style: TextStyle(fontSize : ScreenUtil().setSp(56),color : Color.fromARGB(255, 51, 51, 51)),
            children: <InlineSpan>[TextSpan(text: 'TP',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)))]),
          ),
          ),
           Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: _getNormalView('订单信息', widget.orderInfo),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                  setState(() {
                    _pramaterModel.fromWalletAddress = infoModel.walletAddress;
                    _pramaterModel.chargeWalletAddress = infoModel.chargeWalletAddress;
                    _pramaterModel.chargeValue = (double.parse(widget.amount) *
                                  double.parse(infoModel.rate))
                              .toStringAsFixed(2);
                  });
                },)));
              },
              child :  _getArrowView('充值钱包', _pramaterModel.fromWalletAddress == null ? '请选择充值钱包' : _pramaterModel.fromWalletAddress)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('确认支付',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (_pramaterModel.fromWalletAddress == null){
                Fluttertoast.showToast(msg: '请选择充值钱包',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              widget.didClickPayBtnCallBack(_pramaterModel);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    ),
    );
  }

   Widget _getArrowView(String title, String content) {
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
        Row(children: <Widget>[
          Container(width : ScreenUtil().setWidth(400),child : Text(
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
    );
  }

  Widget _getHeaderWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         Text('支付',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
        GestureDetector(
          onTap:(){
            widget.didClickCancelBtn();
            Navigator.pop(context);
          },
          child : Text(
          '取消',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        )
        ),
      ],
    );
  }

    Widget _getNormalView(String title, String content) {
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

}