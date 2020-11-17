import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceBillListUnOpenCell extends StatefulWidget {
  TPAcceptanceBillListUnOpenCell({Key key,this.infoListModel}) : super(key: key);

  final TPBillInfoListModel infoListModel;

  @override
  _TPAcceptanceBillListUnOpenCellState createState() => _TPAcceptanceBillListUnOpenCellState();
}

class _TPAcceptanceBillListUnOpenCellState extends State<TPAcceptanceBillListUnOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        height: ScreenUtil().setHeight(96),
        decoration : BoxDecoration(
          borderRadius : BorderRadius.all(Radius.circular(4)),
          color : Colors.white
        ),
        // alignment: Alignment.center,
        // width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        child: Stack(
          children : <Widget>[
           Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('${widget.infoListModel.billLevel}'+ I18n.of(context).levelTPBill +'：${widget.infoListModel.billPrice}' + I18n.of(context).eachPart +'（${widget.infoListModel.alreadyBuyCount}/${widget.infoListModel.totalBuyCount}）',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(32),),textAlign: TextAlign.center),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 153, 153, 153),))
          ]
        ),
      ),
      );
  }
}