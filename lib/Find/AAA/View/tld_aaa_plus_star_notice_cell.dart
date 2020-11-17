import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAAAPlusStarNoticeCell extends StatefulWidget {
  TPAAAPlusStarNoticeCell({Key key,@required this.noticeCotent}) : super(key: key);

  final String noticeCotent;

  @override
  _TPAAAPlusStarNoticeCellState createState() => _TPAAAPlusStarNoticeCellState();
}

class _TPAAAPlusStarNoticeCellState extends State<TPAAAPlusStarNoticeCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(40),
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
       color: Color.fromARGB(255, 236, 213, 174),
       child: Row(
         children: [
           Icon(IconData(0xe62b,fontFamily: 'appIconFonts'),size: ScreenUtil().setHeight(32),),
           Padding(
             padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),),
             child : Text(widget.noticeCotent,style : TextStyle(fontSize :ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)))
          )
         ],
       ),
    );
  }
}