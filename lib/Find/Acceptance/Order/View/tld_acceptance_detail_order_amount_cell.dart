import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceDetailOrderAmountCell extends StatefulWidget {
  TPAcceptanceDetailOrderAmountCell({Key key,this.orderInfoModel}) : super(key: key);

  final TPAcceptanceDetailOrderInfoModel orderInfoModel;

  @override
  _TPAcceptanceDetailOrderAmountCellState createState() => _TPAcceptanceDetailOrderAmountCellState();
}

class _TPAcceptanceDetailOrderAmountCellState extends State<TPAcceptanceDetailOrderAmountCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration : BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
          ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _getSingleAmountView(),
            Padding(
              padding: EdgeInsets.only(top :ScreenUtil().setHeight(12)),
              child: _getTotalAmountView(), 
              )
          ],
        ),
      ),
      );
  }

  Widget _getTotalAmountView(){
    return  RichText(
              text: TextSpan(text: I18n.of(context).totalPrices,style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(28)),
                children: <InlineSpan>[
            TextSpan(
                text: '${widget.orderInfoModel.totalPrice}TP',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: ScreenUtil().setSp(36)))
          ]));
  }

  Widget _getSingleAmountView(){
    return Row(
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
                text: '  ${widget.orderInfoModel.billLevel}'+ I18n.of(context).levelBill + ' X${widget.orderInfoModel.billCount}',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(28)))
          ])),
          Text(I18n.of(context).univalence  +'${widget.orderInfoModel.billPrice}TP',
              style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: ScreenUtil().setSp(28)))
        ],
      );
  }

}