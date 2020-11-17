import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../CommonWidget/dash_rect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPVerifyWordInputCell extends StatefulWidget {
  TPVerifyWordInputCell({Key key,this.words}) : super(key: key);

  final List  words;

  @override
  _TPVerifyWordInputCellState createState() => _TPVerifyWordInputCellState();
}

class _TPVerifyWordInputCellState extends State<TPVerifyWordInputCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top : ScreenUtil().setWidth(40)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
          child: Column(
            children: <Widget>[
              getColumnChildrenWidget(context, 0),
              Container(width : size.width - ScreenUtil().setWidth(100),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
              getColumnChildrenWidget(context, 1),
              Container(width : size.width - ScreenUtil().setWidth(100),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
               getColumnChildrenWidget(context, 2),
            ],
          )
        ), 
      ),
    );
  }

  Widget getColumnChildrenWidget(BuildContext context,int columnIndex){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        getRowChildrenWidget(context, 0, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 1, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 2, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 3, columnIndex),
      ],
    );
  }

  Widget getRowChildrenWidget(BuildContext context,int rowIndex,int columnIndex){
    String word;
    if (widget.words != null){
      int length = widget.words.length;
    int index = columnIndex * 4 + rowIndex;
    if (index < length){
      word = widget.words[index];
    }else{
      word = '';
    }
    }else{
      word = '';
    }
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(0),
      width: (size.width - ScreenUtil().setWidth(110)) / 4.0,
      height: ScreenUtil().setHeight(70),
      child: Center(
        child : Text(word,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),)
      ),
    );
  }

}