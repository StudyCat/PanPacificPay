import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPOrderAppealBottomCell extends StatefulWidget {
  TPOrderAppealBottomCell({Key key,this.didClickSureBtnCallBack}) : super(key: key);

  final Function didClickSureBtnCallBack;

  @override
  _TPOrderAppealBottomCellState createState() => _TPOrderAppealBottomCellState();
}

class _TPOrderAppealBottomCellState extends State<TPOrderAppealBottomCell> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(120),
            left: ScreenUtil().setWidth(100),
            right: ScreenUtil().setWidth(100)),
        child: Container(
        height: ScreenUtil().setHeight(80),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => widget.didClickSureBtnCallBack(),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Text(
            I18n.of(context).submit,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.white,
          ),
        ))));
  }
}