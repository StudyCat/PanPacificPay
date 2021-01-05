import 'dart:ui';

import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_sale_suspend_button.dart';

class TPSaleNotDataView extends StatefulWidget {
  TPSaleNotDataView({Key key, this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TPSaleNotDataViewState createState() => _TPSaleNotDataViewState();
}

class _TPSaleNotDataViewState extends State<TPSaleNotDataView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: Center(
              child: Image.asset('assetss/images/no_data.png'),
            )),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text('暂无挂售',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
            child: GestureDetector(
              onTap: () => widget.didClickCallBack(),
              child: Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(250),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: ScreenUtil().setHeight(2)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setHeight(40)))),
                child: Center(
                    child: Text('出售',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(28)))),
              ),
            ))
      ],
    ));
  }
}
