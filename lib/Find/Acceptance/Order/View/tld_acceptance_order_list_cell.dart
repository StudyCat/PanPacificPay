import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_order_list_cell_header_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPAcceptanceOrderListCell extends StatefulWidget {
  TPAcceptanceOrderListCell({Key key,this.didClickItemCallBack,this.orderListModel}) : super(key: key);

  final TPApptanceOrderListModel orderListModel;

  final Function didClickItemCallBack;

  @override
  _TPAcceptanceOrderListCellState createState() => _TPAcceptanceOrderListCellState();
}

class _TPAcceptanceOrderListCellState extends State<TPAcceptanceOrderListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap :widget.didClickItemCallBack,
    child : Padding(
    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(10), right: ScreenUtil().setWidth(30)),
    child: Container(
      padding: EdgeInsets.only(bottom : ScreenUtil().setHeight(20)),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color : Colors.white
      ),
      child: Column(children: <Widget>[
          TPAcceptanceOrderListCellHeaderView(orderListModel: widget.orderListModel,),
          _leftRightItem( I18n.of(context).remainingValidityOfBill, '${widget.orderListModel.billExpireDayCount}' + I18n.of(context).days),
          // _leftRightItem( '预计承兑收益', '${widget.orderListModel.expectProfit}TP'),
          _leftRightItem( I18n.of(context).billBoughtTime, formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.orderListModel.createTime)), [yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss])),
          _leftRightItem(I18n.of(context).payWallet, widget.orderListModel.walletAddress)
        ]),
      ),
    ),
   );
  }

  Widget _leftRightItem(String title , String content) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width:  ScreenUtil().setWidth(400),
          alignment: Alignment.centerRight,
          child: Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,)
        ),
      ],
    ),
  );
}
}