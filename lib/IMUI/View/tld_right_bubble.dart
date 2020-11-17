import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRightBubbleView extends StatefulWidget {
  TPRightBubbleView({Key key,this.text}) : super(key: key);

  final String text;

  @override
  _TPRightBubbleViewState createState() => _TPRightBubbleViewState();
}

class _TPRightBubbleViewState extends State<TPRightBubbleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color : Theme.of(context).hintColor,
        borderRadius : BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
       child: Text(widget.text,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Colors.white),maxLines: null,),
    );
  }
}