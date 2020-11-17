import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAmountUpgradeProfitHeaderCell extends StatefulWidget {
  TPAmountUpgradeProfitHeaderCell({Key key}) : super(key: key);

  @override
  _TPAmountUpgradeProfitHeaderCellState createState() => _TPAmountUpgradeProfitHeaderCellState();
}

class _TPAmountUpgradeProfitHeaderCellState extends State<TPAmountUpgradeProfitHeaderCell> {
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
            width : ScreenUtil().setWidth(120), 
            child: Text('等级',style: textStyle,textAlign: TextAlign.center),
          ),
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2, 
            child: Text('任务可用额度（每日）',style: textStyle,textAlign: TextAlign.center),
          ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2, 
            child: Text('达成条件',style: textStyle,textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}