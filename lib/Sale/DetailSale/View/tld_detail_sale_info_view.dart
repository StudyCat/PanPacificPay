import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPDetailSaleInfoView extends StatefulWidget {
  TPDetailSaleInfoView({Key key,this.saleModel}) : super(key: key);

  final TPDetailSaleModel saleModel;

  @override
  _TPDetailSaleInfoViewState createState() => _TPDetailSaleInfoViewState();
}

class _TPDetailSaleInfoViewState extends State<TPDetailSaleInfoView> {
  @override
  Widget build(BuildContext context) {
    String currentAmountStr = widget.saleModel != null ? widget.saleModel.currentCount : '0';
    String totalAmountStr = widget.saleModel != null ? widget.saleModel.totalCount : '0';
    String status = '';
    if (widget.saleModel != null){
      if (widget.saleModel.status == 0){
      status = I18n.of(context).onSaleStatusLabel;
    }else if(widget.saleModel.status == 1){
      status = I18n.of(context).finishedStatusLabel;
    }else{
      status = I18n.of(context).cancelSaleBtnTitle;
    }
    }
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getSaleInfoLabel(I18n.of(context).totalAmountLabel, totalAmountStr + 'TP'),
          _getSaleInfoLabel(I18n.of(context).remainAmountLabel, currentAmountStr + 'TP'),
          _getSaleInfoLabel(I18n.of(context).statusLabel, status)
        ],
      ),
    );
  }

  Widget _getSaleInfoLabel(String title,String content){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(title,style: TextStyle(
        fontSize : ScreenUtil().setSp(28),
        color: Theme.of(context).primaryColor
      ),),
      Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
        child: Text(content,style : TextStyle(
          fontSize : ScreenUtil().setSp(28),
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700
        ),),
      ),
    ],
  );
}

}