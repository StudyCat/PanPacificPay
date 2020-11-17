import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPTransferAccountsNormalRowView extends StatefulWidget {
  TPTransferAccountsNormalRowView({Key key,this.title,this.content}) : super(key: key);

  final String title;

  final String content;

  @override
  _TPTransferAccountsNormalRowViewState createState() => _TPTransferAccountsNormalRowViewState();
}

class _TPTransferAccountsNormalRowViewState extends State<TPTransferAccountsNormalRowView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children : <Widget>[
        Text(widget.title,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
        Text(widget.content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),),
      ],
    );
  }
}