import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPEmptyWalletView extends StatefulWidget {
  TPEmptyWalletView({Key key}) : super(key: key);

  @override
  _TPEmptyWalletViewState createState() => _TPEmptyWalletViewState();
}

class _TPEmptyWalletViewState extends State<TPEmptyWalletView> {
  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
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
            child: Text('暂无可用的钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
      ],
    );
  }
}