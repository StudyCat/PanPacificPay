import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPPurseNoPurseCell extends StatefulWidget {
  TPPurseNoPurseCell({Key key,this.didClickAddPurseCallBack}) : super(key: key);

  final Function didClickAddPurseCallBack;

  @override
  _TPPurseNoPurseCellState createState() => _TPPurseNoPurseCellState();
}

class _TPPurseNoPurseCellState extends State<TPPurseNoPurseCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
        child: GestureDetector(
            onTap: () {
              widget.didClickAddPurseCallBack();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  height: ScreenUtil().setHeight(60),
                  width: ScreenUtil().setWidth(250),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: ScreenUtil().setHeight(2)),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setHeight(40))),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                    '添加钱包',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                  ),
                ),
              ],
            )));
  }
}
