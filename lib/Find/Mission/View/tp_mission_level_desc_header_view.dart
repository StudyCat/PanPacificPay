import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionLevelDescHeaderView extends StatefulWidget {
  TPMissionLevelDescHeaderView({Key key}) : super(key: key);

  @override
  _TPMissionLevelDescHeaderViewState createState() => _TPMissionLevelDescHeaderViewState();
}

class _TPMissionLevelDescHeaderViewState extends State<TPMissionLevelDescHeaderView> {
@override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
           Container(
            width : ScreenUtil().setWidth(120), 
            child: Text('级别',style: textStyle,textAlign: TextAlign.center),
          ),
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2, 
            child: Text('区间',style: textStyle,textAlign: TextAlign.center),
          ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2, 
            child: Text('奖励比例',style: textStyle,textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}