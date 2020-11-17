import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPRankNormalHeaderCell extends StatefulWidget {
  TPRankNormalHeaderCell({Key key}) : super(key: key);

  @override
  _TPRankNormalHeaderCellState createState() =>
      _TPRankNormalHeaderCellState();
}

class _TPRankNormalHeaderCellState extends State<TPRankNormalHeaderCell> {
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
            child: Text('名次',style: textStyle,textAlign: TextAlign.center),
          ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3,
            child: Text('钱包地址',style: textStyle,textAlign: TextAlign.center), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3,
            child: Text('累计交易额',style: textStyle,textAlign: TextAlign.center,), 
         )
        ],
      ),
    );
  }
}
