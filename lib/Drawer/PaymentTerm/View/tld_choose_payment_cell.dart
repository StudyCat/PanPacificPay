import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPChoosePaymentCell extends StatefulWidget {
  TPChoosePaymentCell({Key key,this.title,this.didClickCallBack,this.iconUrl}) : super(key: key);

  final Function didClickCallBack;

  final String title;

  final String iconUrl;

  @override
  _TPChoosePaymentCellState createState() => _TPChoosePaymentCellState();
}

class _TPChoosePaymentCellState extends State<TPChoosePaymentCell> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap : () => widget.didClickCallBack(),
      child : Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(2),left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child : ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          margin : EdgeInsets.all(0),
          height: ScreenUtil().setHeight(88),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : <Widget>[
              Row(
                children : <Widget>[
                   Padding(
                padding: EdgeInsets.only(left:ScreenUtil().setWidth(20)),
                child: CachedNetworkImage(imageUrl: widget.iconUrl,height : ScreenUtil().setWidth(32),width : ScreenUtil().setWidth(32))
              ),
              Padding(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
                child:  Text(widget.title,style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
              ),
                ]
              ),
              Padding(
                padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
                child:  Icon(Icons.keyboard_arrow_right),
              )
            ],
          ),
        ), 
      )
      )
    );
  }
}