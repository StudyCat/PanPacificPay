import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRankMineHeaderCell extends StatefulWidget {
  TPRankMineHeaderCell({Key key}) : super(key: key);

  @override
  _TPRankMineHeaderCellState createState() => _TPRankMineHeaderCellState();
}

class _TPRankMineHeaderCellState extends State<TPRankMineHeaderCell> {
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
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5, 
            child: Text('钱包地址',style: textStyle,textAlign: TextAlign.center),
          ),
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5, 
            child: Text('排名',style: textStyle,textAlign: TextAlign.center),
          ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5, 
            child: Text('奖励',style: textStyle,textAlign: TextAlign.center),
          ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child: Text('榜单类型',style: textStyle,textAlign: TextAlign.center), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child: Text('时间',style: textStyle,textAlign: TextAlign.center,), 
         )
        ],
      ),
    );
  }
}