import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPAcceptanceBillListLockCell extends StatefulWidget {
  TPAcceptanceBillListLockCell({Key key,this.infoListModel}) : super(key: key);

  final TPBillInfoListModel infoListModel;

  @override
  _TPAcceptanceBillListLockCellState createState() => _TPAcceptanceBillListLockCellState();
}

class _TPAcceptanceBillListLockCellState extends State<TPAcceptanceBillListLockCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        height: ScreenUtil().setHeight(96),
        decoration : BoxDecoration(
          borderRadius : BorderRadius.all(Radius.circular(4)),
          color : Colors.white
        ),
        child: Stack(
          children : <Widget>[
            Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('${widget.infoListModel.billLevel}'+ I18n.of(context).levelTPBill +'：${widget.infoListModel.billPrice}' + I18n.of(context).eachPart +'（${widget.infoListModel.alreadyBuyCount}/${widget.infoListModel.totalBuyCount}）',style : TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(28),),textAlign: TextAlign.center,),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(IconData(0xe60b,fontFamily : 'appIconFonts'),color: Color.fromARGB(255, 153, 153, 153),size: ScreenUtil().setSp(28),))
          ]
        ),
      ),
      );
  }
}