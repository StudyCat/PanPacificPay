import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRankAcceptanceHeaderCell extends StatefulWidget {
  TPRankAcceptanceHeaderCell({Key key}) : super(key: key);

  @override
  _TPRankAcceptanceHeaderCellState createState() => _TPRankAcceptanceHeaderCellState();
}

class _TPRankAcceptanceHeaderCellState extends State<TPRankAcceptanceHeaderCell> {
   @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text(I18n.of(context).rank,style: textStyle,textAlign: TextAlign.center),
          ),
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text(I18n.of(context).userID,style: textStyle,textAlign: TextAlign.center),
          ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text(I18n.of(context).everydayProfit,style: textStyle,textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}