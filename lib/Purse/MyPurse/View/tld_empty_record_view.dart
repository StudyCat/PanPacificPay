import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPEmptyRecordView extends StatefulWidget {
  TPEmptyRecordView({Key key}) : super(key: key);

  @override
  _TPEmptyRecordViewState createState() => _TPEmptyRecordViewState();
}

class _TPEmptyRecordViewState extends State<TPEmptyRecordView> {
  @override
  Widget build(BuildContext context) {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(214),
          ),
          child: Center(
              child: Image.asset('assetss/images/no_data.png',width:ScreenUtil().setWidth(260),height: ScreenUtil().setWidth(260),) 
              ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(68),
          ),
          child: Center(
            child: Text('暂无记录',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
      ],
    );
  }
}