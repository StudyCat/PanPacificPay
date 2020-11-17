import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewMissionMyMissionNoWalletView extends StatefulWidget {
  TPNewMissionMyMissionNoWalletView({Key key,this.didClickChooseBtnCallBack}) : super(key: key);

  final Function didClickChooseBtnCallBack;

  @override
  _TPNewMissionMyMissionNoWalletViewState createState() => _TPNewMissionMyMissionNoWalletViewState();
}

class _TPNewMissionMyMissionNoWalletViewState extends State<TPNewMissionMyMissionNoWalletView> {
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
            child: Text('还未选择钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
          ),
        ),
         Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                '选择钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                widget.didClickChooseBtnCallBack();
              }),
        )
      ],
    );
  }
}