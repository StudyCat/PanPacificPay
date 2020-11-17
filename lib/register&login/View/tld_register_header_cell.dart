import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRegisterHeaderCell extends StatefulWidget {
  TPRegisterHeaderCell({Key key}) : super(key: key);

  @override
  _TPRegisterHeaderCellState createState() => _TPRegisterHeaderCellState();
}

class _TPRegisterHeaderCellState extends State<TPRegisterHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),top :ScreenUtil().setHeight(40),bottom: ScreenUtil().setHeight(120)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(I18n.of(context).mobileQuickRegistration,style: TextStyle(fontSize : ScreenUtil().setHeight(40),color: Color.fromARGB(255, 51, 51, 51)),),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
            child: Text(I18n.of(context).registeredMobilePhoneNumbersAutomaticallyLogIn,style: TextStyle(fontSize : ScreenUtil().setHeight(24),color: Color.fromARGB(255, 153, 153, 153)),),
          )
        ],
      ),
    );
  }
}