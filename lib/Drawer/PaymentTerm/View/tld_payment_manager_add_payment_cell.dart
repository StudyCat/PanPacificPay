import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Page/tld_payment_manager_page.dart';

class TPPaymentManagerAddPaymentCell extends StatefulWidget {
  TPPaymentManagerAddPaymentCell({Key key,this.type,this.didClickItemCallBack}) : super(key: key);

  final TPPaymentType type;

  final Function didClickItemCallBack;

  @override
  _TPPaymentManagerAddPaymentCellState createState() => _TPPaymentManagerAddPaymentCellState();
}

class _TPPaymentManagerAddPaymentCellState extends State<TPPaymentManagerAddPaymentCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Container(
         height : ScreenUtil().setHeight(88),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(4)),
           color: Colors.white
         ),
         child : Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Icon(IconData(0xe67e,fontFamily:'appIconFonts'),size: ScreenUtil().setWidth(32),),
             Text(getTitleString(),style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)),)
           ],
         )
         )
       ),
    );
  }

  String getTitleString(){
     if(widget.type == TPPaymentType.wechat){
      return I18n.of(context).addWeChat;
    }else if(widget.type == TPPaymentType.alipay){
      return I18n.of(context).addAlipay;
    }else if(widget.type == TPPaymentType.bank){
      return I18n.of(context).addBankCard;
    }else{
      return I18n.of(context).addCustomMethod;
    }
  }
}