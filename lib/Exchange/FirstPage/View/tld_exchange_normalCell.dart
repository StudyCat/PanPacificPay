import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TPExchangeNormalCellType {
  normal, // 两侧文字式样
  normalArrow, //带箭头文字式样
}

class TPExchangeNormalCell extends StatefulWidget {
  final String title;
  final double top;
  final TPExchangeNormalCellType type;
  final String content;
  final TextStyle contentStyle;
  final Function didClickCallBack;
  TPExchangeNormalCell({Key key,this.type,this.title,this.top,this.contentStyle,this.content,this.didClickCallBack}) : super(key: key);

  @override
  _TPExchangeNormalCellState createState() => _TPExchangeNormalCellState();
}

class _TPExchangeNormalCellState extends State<TPExchangeNormalCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap : widget.didClickCallBack,
      child : Container(
      padding: EdgeInsets.only(left: 15, top: widget.top, right: 15),
      width: screenSize.width - 30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color: Colors.white,
          height: ScreenUtil().setHeight(88),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),),
                child: Text(widget.title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51))),
              ),
              getRightWidget()
            ],
          ),
          )
         ),
    )
    );
  }

  Widget getRightWidget(){
    if (widget.type == TPExchangeNormalCellType.normal){
      return Container(
        padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
        child: Text(widget.content,style : widget.contentStyle),
      );
    }else{
      return Container(
        padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children : <Widget>[
            Text(widget.content,style : widget.contentStyle),
            Icon(Icons.keyboard_arrow_right)
          ]
        ),
      );
    }
  }
}
