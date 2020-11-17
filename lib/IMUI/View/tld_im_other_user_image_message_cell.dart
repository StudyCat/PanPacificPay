import 'package:dragon_sword_purse/IMUI/View/tld_left_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'tld_left_image_bubble.dart';

class TPIMOtherUserImageMessageCell extends StatefulWidget {
  TPIMOtherUserImageMessageCell({Key key,this.message}) : super(key: key);

  final JMImageMessage message;

  @override
  _TPIMOtherUserImageMessageCellState createState() => _TPIMOtherUserImageMessageCellState();
}

class _TPIMOtherUserImageMessageCellState extends State<TPIMOtherUserImageMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(15)),
      child:  Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(360),
            // height: ScreenUtil().setWidth(360),
            child: TPLeftImageBubbleView(messageId : widget.message.id, username: widget.message.from.username,),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}