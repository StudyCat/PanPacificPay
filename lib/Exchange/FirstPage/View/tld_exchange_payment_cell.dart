import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPExchangePaymentCell extends StatefulWidget {
  TPExchangePaymentCell({Key key,this.paymentModel,this.didClickItemCallBack}) : super(key: key);

  final TPPaymentModel paymentModel;

  final Function didClickItemCallBack;

  @override
  _TPExchangePaymentCellState createState() => _TPExchangePaymentCellState();
}

class _TPExchangePaymentCellState extends State<TPExchangePaymentCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Padding(
       padding: EdgeInsets.only(top :ScreenUtil().setHeight(2),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Container(
         height : ScreenUtil().setHeight(88),
         decoration: BoxDecoration(
           borderRadius : BorderRadius.all(Radius.circular(4)),
           color : Colors.white
         ),
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Text(I18n.of(context).collectionMethod,style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
             _getRowRightChildWidget()
           ],
         ),
       ),
    ),
    );
  }

  Widget _getRowRightChildWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Offstage(
          offstage: widget.paymentModel != null ? false : true,
          child: _getPaymentIcon(),
        ),
        Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 51, 51, 51),)
      ],
    );
  }

  Widget _getPaymentIcon(){
    if (widget.paymentModel != null){
      return CachedNetworkImage(imageUrl: widget.paymentModel.payIcon,width: ScreenUtil().setWidth(36),height: ScreenUtil().setWidth(36),);
    }
    return Container();
  }

}