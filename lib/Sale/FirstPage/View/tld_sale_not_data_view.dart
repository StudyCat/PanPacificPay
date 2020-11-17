import 'dart:ui';

import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_sale_suspend_button.dart';

class TPSaleNotDataView extends StatefulWidget {
  TPSaleNotDataView({Key key,this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TPSaleNotDataViewState createState() => _TPSaleNotDataViewState();
}

class _TPSaleNotDataViewState extends State<TPSaleNotDataView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: FractionalOffset(0.9, 0.95),
      children: <Widget>[
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
              child: Center(
                  child: Image.asset('assetss/images/no_data.png'),
              )),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
              child: Text(I18n.of(context).noOrderLabel,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51))),
            ),
          ],
        )),
        TPSaleSuspendButton(
          didClickCallBack: ()=>widget.didClickCallBack(),
        )
      ],
    );
  }
}
