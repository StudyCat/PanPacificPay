
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget picAndTextButton(String text,Function onPress) {
  return Container(
    height: ScreenUtil().setHeight(60),
    decoration: BoxDecoration(
      color: Theme.of(navigatorKey.currentContext).primaryColor,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(ScreenUtil().setHeight(30)),bottomLeft:Radius.circular(ScreenUtil().setHeight(30)))
    ),
    alignment: Alignment.center,
    child: FlatButton(
      onPressed: onPress,
      child: Text(text,style: TextStyle(color : Colors.white,fontSize: ScreenUtil().setSp(26)),maxLines: 1,),
      color: Colors.transparent,
      padding: EdgeInsets.all(0),
      ),
  );
}
