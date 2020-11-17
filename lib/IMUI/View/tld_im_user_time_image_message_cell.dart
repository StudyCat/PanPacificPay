import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_right_image_bubble.dart';
import 'package:date_format/date_format.dart';
 

class TPIMUserTimeImageMessageCell extends StatefulWidget {
  TPIMUserTimeImageMessageCell({Key key,this.imageUrl,this.createTime}) : super(key: key);

  final String imageUrl;

  final int createTime;

  @override
  _TPIMUserTimeImageMessageCellState createState() => _TPIMUserTimeImageMessageCellState();
}

class _TPIMUserTimeImageMessageCellState extends State<TPIMUserTimeImageMessageCell> {
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
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(15)),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(360),
            // height: ScreenUtil().setWidth(360),
            child: TPRightImageBubbleView(imageUrl: widget.imageUrl),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}


