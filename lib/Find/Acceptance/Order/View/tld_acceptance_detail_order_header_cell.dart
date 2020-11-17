import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceDetailOrderHeaderCell extends StatefulWidget {
  TPAcceptanceDetailOrderHeaderCell({Key key,this.detailOrderInfoModel}) : super(key: key);

  final TPAcceptanceDetailOrderInfoModel detailOrderInfoModel;

  @override
  _TPAcceptanceDetailOrderHeaderCellState createState() => _TPAcceptanceDetailOrderHeaderCellState();
}

class _TPAcceptanceDetailOrderHeaderCellState extends State<TPAcceptanceDetailOrderHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: _getColumnView(context),
        ),
    );
  }

  Widget _getColumnView(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getStatusRowView(context),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: _getSubContentRowView(),
          )
      ],
    );
  }

  Widget _getSubContentRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(widget.detailOrderInfoModel != null ? I18n.of(context).remainingValidityOfBill + '${widget.detailOrderInfoModel.billExpireDayCount}' + I18n.of(context).days : '',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).hintColor),),
      ],
    );
  }

  Widget _getStatusRowView(BuildContext context){
    TPOrderStatusInfoModel orderStatusInfoModel = widget.detailOrderInfoModel != null ? TPDataManager.accptanceOrderListStatusMap[widget.detailOrderInfoModel.acptOrderStatus] : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(orderStatusInfoModel != null ? orderStatusInfoModel.orderStatusName : '',style :TextStyle(fontSize : ScreenUtil().setSp(44),color: Theme.of(context).hintColor)),
      ],
    );
  }

   

}