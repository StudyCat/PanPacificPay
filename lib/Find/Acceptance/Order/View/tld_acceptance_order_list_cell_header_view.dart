import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceOrderListCellHeaderView extends StatefulWidget {
  TPAcceptanceOrderListCellHeaderView({Key key,this.orderListModel}) : super(key: key);

  final TPApptanceOrderListModel orderListModel;

  @override
  _TPAcceptanceOrderListCellHeaderViewState createState() => _TPAcceptanceOrderListCellHeaderViewState();
}

class _TPAcceptanceOrderListCellHeaderViewState extends State<TPAcceptanceOrderListCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    TPOrderStatusInfoModel orderStatusInfoModel = TPDataManager.accptanceOrderListStatusMap[widget.orderListModel.acptOrderStatus];
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children : <Widget>[
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     _getInfoLabel(I18n.of(context).billLevel,'${widget.orderListModel.billLevel}' + I18n.of(context).level,null),
                     _getInfoLabel(I18n.of(context).univalence, '${widget.orderListModel.billPrice}TP',null),
                     _getInfoLabel(I18n.of(context).copies, '${widget.orderListModel.billCount}' + I18n.of(context).part,null),
                     _getInfoLabel(I18n.of(context).totalPrices, '${widget.orderListModel.totalPrice}TP',null),
                     _getInfoLabel(I18n.of(context).orderProfit, orderStatusInfoModel.orderStatusName, orderStatusInfoModel.orderStatusColor)
                   ],
                 ),)]
             );
  }
  
  Widget _getInfoLabel(String title,String content,Color contentColor){
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(title,style: TextStyle(
        fontSize : ScreenUtil().setSp(28),
        color: Color.fromARGB(255, 51, 51, 51)
      ),),
      Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
        child: Text(content,style : TextStyle(
          fontSize : ScreenUtil().setSp(28),
          color: contentColor != null ? contentColor : Color.fromARGB(255, 57, 57, 57),
          fontWeight: FontWeight.bold
        ),),
      ),
    ],
  );
  }
  
}