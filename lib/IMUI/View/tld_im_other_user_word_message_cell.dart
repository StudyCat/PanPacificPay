import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_left_bubble.dart';

class TPIMOtherUserWordMessageCell extends StatefulWidget {
  TPIMOtherUserWordMessageCell({Key key,this.content}) : super(key: key);
  final String content;
  @override
  _TPIMOtherUserWordMessageCellState createState() => _TPIMOtherUserWordMessageCellState();
}

class _TPIMOtherUserWordMessageCellState extends State<TPIMOtherUserWordMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(15)),
      child:  Row(
        children: <Widget>[
          Container(
            child: TPLeftBubbleView(text: widget.content),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}