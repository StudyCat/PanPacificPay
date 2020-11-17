import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_right_bubble.dart';
import 'package:date_format/date_format.dart';

class TPIMUserTimeWordMessageCell extends StatefulWidget {
  TPIMUserTimeWordMessageCell({Key key,this.createTime,this.content}) : super(key: key);

  final String content;

  final int  createTime;

  @override
  _TPIMUserTimeWordMessageCellState createState() =>
      _TPIMUserTimeWordMessageCellState();
}

class _TPIMUserTimeWordMessageCellState
    extends State<TPIMUserTimeWordMessageCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Column(children: <Widget>[
        _getTimeView(context),
        _getMessageBubble(context)
        ]),
    );
  }

  Widget _getTimeView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(170),
        height: ScreenUtil().setHeight(48),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(255, 216, 216, 216)),
        child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.createTime),[HH,'.',nn,':',ss]),
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51))),
      ),
    );
  }

  Widget _getMessageBubble(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20), right: ScreenUtil().setWidth(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: TPRightBubbleView(
                text: widget.content),
            constraints: BoxConstraints(maxWidth: size.width / 2),
          )
        ],
      ),
    );
  }
}
