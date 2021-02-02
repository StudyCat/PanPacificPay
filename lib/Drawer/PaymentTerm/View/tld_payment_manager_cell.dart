import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tld_payment_manager_model_manager.dart';

class TPPaymentManagerCell extends StatefulWidget {
  TPPaymentManagerCell({Key key,this.paymentModel,this.didClickItemCallBack}) : super(key: key);

  final TPPaymentModel paymentModel;

  final Function didClickItemCallBack;

  @override 

  _TPPaymentManagerCellState createState() => _TPPaymentManagerCellState();
}


class _TPPaymentManagerCellState extends State<TPPaymentManagerCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child:  Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
       child: Container(
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
          height : ScreenUtil().setHeight(88),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(4)),
           color: Colors.white
         ),
         child : _getMainRowWidget()
       ),
    ),
    );
  }

  Widget _getMainRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _getLeftSubRowWidget(),
        Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 51, 51, 51),)
      ],
    );
  }

  Widget _getLeftSubRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CachedNetworkImage(imageUrl: widget.paymentModel.payIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),
        Padding(
          padding: EdgeInsets.only(left :ScreenUtil().setWidth(20)),
          child: Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(250),
            child: Text(_getPaymentInfoString(),style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,),
          )
        )
      ],
    );
  }



  String _getPaymentInfoString(){
    if(widget.paymentModel.type == 1){
      int length = widget.paymentModel.account.length;
      return  widget.paymentModel.subBranch + '（' + (widget.paymentModel.account.length > 4 ? widget.paymentModel.account.substring(length - 5,length -1) : widget.paymentModel.account) + '）'; 
    }else if(widget.paymentModel.type == 2){
      return widget.paymentModel.account;
    }else if(widget.paymentModel.type == 3){
      return widget.paymentModel.account;
    }else if (widget.paymentModel.type == 4){
      return widget.paymentModel.myPayName;
    }else {
      return widget.paymentModel.account;
    }
  }

}