import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getBuyInfoLabel(String title,String content){
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
          color: Color.fromARGB(255, 57, 57, 57),
          fontWeight: FontWeight.bold
        ),),
      ),
    ],
  );
}