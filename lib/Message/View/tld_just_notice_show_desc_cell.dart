import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPJustNoticeShowDescCell extends StatefulWidget {
  TPJustNoticeShowDescCell({Key key,this.title,this.description}) : super(key: key);

  final String title;

  final String description;

  @override
  _TPJustNoticeShowDescCellState createState() => _TPJustNoticeShowDescCellState();
}

class _TPJustNoticeShowDescCellState extends State<TPJustNoticeShowDescCell> {
  @override
  Widget build(BuildContext context) {
   return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
                child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
                child: Text(widget.description,style:TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
              )
            ]),
      ),
    );
  }
}