import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_bill_dash_line.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_dash_line.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceDetailBillView extends StatefulWidget {
  TPAcceptanceDetailBillView({Key key,this.detailOrderInfoModel}) : super(key: key);

  final TPAcceptanceDetailOrderInfoModel detailOrderInfoModel;

  @override
  _TPAcceptanceDetailBillViewState createState() =>
      _TPAcceptanceDetailBillViewState();
}

class _TPAcceptanceDetailBillViewState
    extends State<TPAcceptanceDetailBillView> {
  @override
  Widget build(BuildContext context) {
    TPOrderStatusInfoModel orderStatusInfoModel = TPDataManager.accptanceOrderListStatusMap[widget.detailOrderInfoModel.acptOrderStatus];
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),child: Text(I18n.of(context).orderNumLabel +'：${widget.detailOrderInfoModel.acptOrderNo}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51))),),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
              child: Text(orderStatusInfoModel.orderStatusName,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color: orderStatusInfoModel.orderStatusColor)),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
              child: _getBillSingleAmount(),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: TPBillDashLine(),
            ),
            _getBillInfoRowView(I18n.of(context).remainingValidityOfBill,'${widget.detailOrderInfoModel.billExpireDayCount}'+I18n.of(context).days),
            _getBillInfoRowView(I18n.of(context).dailyStaticProfitAdd,'${widget.detailOrderInfoModel.staticProfit}TP'),
            // _getBillInfoRowView('收益倍率','${widget.detailOrderInfoModel.billProfitRate}倍'),
            // _getBillInfoRowView('预计承兑累计收益','${widget.detailOrderInfoModel.expectProfit}TP'),
            _getBillInfoRowView(I18n.of(context).payWallet,widget.detailOrderInfoModel.walletAddress),
            _getBillInfoRowView(I18n.of(context).boughtTime,formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.detailOrderInfoModel.createTime)), [yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss])),
            // _getBillInfoRowView('承兑结束时间','2020.07.15 08:24:32'),
          ],
        ),
      ),
    );
  }

  Widget _getBillSingleAmount() {
    return Container(
      width: MediaQuery.of(context).size.width -
          ScreenUtil().setWidth(100),
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
                text: '  ${widget.detailOrderInfoModel.billLevel}'+ I18n.of(context).levelBill + '  X${widget.detailOrderInfoModel.billCount}',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(28)))
          ])),
          Column(
            children : <Widget>[
              Text( I18n.of(context).univalence + ' ${widget.detailOrderInfoModel.billPrice}TP',
              style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: ScreenUtil().setSp(28))),
              Padding(
                padding : EdgeInsets.only(top: ScreenUtil().setHeight(14)),
                child : Text( I18n.of(context).totalPrices + ' ${widget.detailOrderInfoModel.totalPrice}TP',
              style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: ScreenUtil().setSp(28)))
              )
            ]
          )
        ],
      ),
    );
  }


  Widget _getBillInfoRowView(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
      child: Container(
        width: MediaQuery.of(context).size.width -
            ScreenUtil().setWidth(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
            Container(
              width: (MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(60) -
                      ScreenUtil().setHeight(40)) /
                  2,
              child: Text(content,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 153, 153, 153))),
            )
          ],
        ),
      ),
    );
  }
}
