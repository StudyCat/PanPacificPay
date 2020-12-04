import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPQuickBuyActionSheet extends StatefulWidget {
  TPQuickBuyActionSheet({Key key,this.count,this.didClickBuyCallBack,this.rate}) : super(key: key);

  final String count;

  final Function didClickBuyCallBack;

  final double rate;

  @override
  _TPQuickBuyActionSheetState createState() => _TPQuickBuyActionSheetState();
}

class _TPQuickBuyActionSheetState extends State<TPQuickBuyActionSheet> {

  String _wallsetAdress;

  @override
  Widget build(BuildContext context) {
    double cnyAmountNum = double.parse(widget.count) * widget.rate;
    String cnyAmountStr = (NumUtil.getNumByValueDouble(cnyAmountNum, 2)).toStringAsFixed(2);
    String amount = widget.count + 'USD' + '≈' + cnyAmountStr + 'CNY';
    Size size = MediaQuery.of(context).size;
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
                children: <Widget>[Container(
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(40)
          ),
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
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView(I18n.of(context).countLabel, widget.count + 'TP'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView(I18n.of(context).shouldPayAmountLabel, amount),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                  setState(() {
                    _wallsetAdress = infoModel.walletAddress;
                  });
                },)));
              },
              child : getArrowView(I18n.of(context).receiveAddressLabel, _wallsetAdress == null ? I18n.of(context).chooseWalletLabel:_wallsetAdress)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text(I18n.of(context).placeOrderBtnTitle,style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (_wallsetAdress == null){
                Fluttertoast.showToast(msg: I18n.of(context).chooseWalletLabel,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              if (double.parse(widget.count) > 0){
                widget.didClickBuyCallBack(widget.count,_wallsetAdress);
              }else{
                Fluttertoast.showToast(msg: '请输入正确数量');
              }
              Navigator.of(context).pop();
            }
            ,color:Color.fromARGB(255, 126, 211, 33),padding: EdgeInsets.all(0),),
          )
          )],
      ),
    )])));
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