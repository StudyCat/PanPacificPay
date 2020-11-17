import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPClipTitleInputCell extends StatefulWidget {
  TPClipTitleInputCell(
      {Key key, this.title, this.textFieldEditingCallBack, this.placeholder,this.titleFontSize,this.content})
      : super(key: key);

  final num titleFontSize;
  final String title;
  final ValueChanged<String> textFieldEditingCallBack;
  final String placeholder;
  final String content;
  @override
  _TPClipTitleInputCellState createState() => _TPClipTitleInputCellState();
}

class _TPClipTitleInputCellState extends State<TPClipTitleInputCell> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.content != null && widget.content.length > 0){
      _controller = TextEditingController(text: widget.content);
    }else{
      _controller = TextEditingController();
    }
    _controller.addListener(() {
      widget.textFieldEditingCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.content;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: widget.titleFontSize == null ? ScreenUtil().setSp(24) : widget.titleFontSize,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: CupertinoTextField(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20)),
                controller: _controller,
                placeholder: widget.placeholder,
                textAlign: TextAlign.right,
                placeholderStyle: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24)),
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
              ),
              )
            ]),
      ),
    );
  }
}
