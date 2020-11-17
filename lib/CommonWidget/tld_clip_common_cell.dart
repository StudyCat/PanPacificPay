import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TPClipCommonCellType {
  normal, // 两侧文字式样
  normalArrow, //带箭头文字式样
}

class TPClipCommonCell extends StatefulWidget {
  TPClipCommonCell(
      {Key key,
      this.type,
      this.title,
      this.titleStyle,
      this.content,
      this.contentStyle})
      : super(key: key);
  final TPClipCommonCellType type;
  final String title;
  final TextStyle titleStyle;
  final String content;
  final TextStyle contentStyle;

  @override
  _TPClipCommonCellState createState() => _TPClipCommonCellState();
}

class _TPClipCommonCellState extends State<TPClipCommonCell> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: _getContentView(),
    );
  }

  Widget _getContentView() {
    if (widget.type == TPClipCommonCellType.normal) {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: ListTile(
            leading: Text(
              widget.title,
              style: widget.titleStyle,
            ),
            trailing:Container(
                width: ScreenUtil().setWidth(400),
                child: Text(
                widget.content,
                textAlign: TextAlign.end,
                style: widget.contentStyle,
              ),
              )),
      );
    } else {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: ListTile(
          leading: Text(
            widget.title,
            style: widget.titleStyle,
          ),
          trailing: Container(
            width : ScreenUtil().setWidth(440),
            child :Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(400),
                child: Text(
                widget.content,
                textAlign: TextAlign.end,
                style: widget.contentStyle,
              ),
              ),
              Expanded(child:Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 51, 51, 51)))
            ],
          )
          ),
          ),
      );
    }
  }
}
