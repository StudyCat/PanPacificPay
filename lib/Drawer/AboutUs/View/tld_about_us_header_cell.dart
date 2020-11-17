import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAboutUsHeaderCell extends StatefulWidget {
  TPAboutUsHeaderCell({Key key}) : super(key: key);

  @override
  _TPAboutUsHeaderCellState createState() => _TPAboutUsHeaderCellState();
}

class _TPAboutUsHeaderCellState extends State<TPAboutUsHeaderCell> {
  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children : <Widget>[
          Padding(
            padding : EdgeInsets.only(top : size.height / 5),
            child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(472),height : ScreenUtil().setWidth(108)),),
          Padding(padding: EdgeInsets.only(top : ScreenUtil().setHeight(40),bottom: ScreenUtil().setHeight(100)),
          child: Text('v2.4.0',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
          )
        ],
      ),
    );
  }
}