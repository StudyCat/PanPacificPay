import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_right_bubble.dart';

class TPIMUserWordMessageCell extends StatefulWidget {
  TPIMUserWordMessageCell({Key key,this.content}) : super(key: key);

  final String content;

  @override
  _TPIMUserWordMessageCellState createState() => _TPIMUserWordMessageCellState();
}

class _TPIMUserWordMessageCellState extends State<TPIMUserWordMessageCell> {
  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(15)),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: TPRightBubbleView(text: widget.content),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}