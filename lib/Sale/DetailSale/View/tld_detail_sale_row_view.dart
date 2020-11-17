import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPDetailSaleRowView extends StatefulWidget {
  TPDetailSaleRowView({Key key,this.isShowIcon,this.title,this.content,this.payStatus}) : super(key: key);
  
  final bool isShowIcon;
  final String title;
  final String content;
  final int payStatus;
  @override
  _TPDetailSaleRowViewState createState() => _TPDetailSaleRowViewState();
}

class _TPDetailSaleRowViewState extends State<TPDetailSaleRowView> {
  List icons = [0xe679, 0xe61d, 0xe630];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          Text(widget.title,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
          widget.isShowIcon ? Icon(IconData(getIconInt(),fontFamily : 'appIconFonts'), size: ScreenUtil().setWidth(28),) : Text(widget.content,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)))
        ],
      ), 
      );
  }

  int getIconInt(){
    if (widget.payStatus == 1){
      return 0xe679;
  }else if(widget.payStatus == 2){
      return 0xe61d;
  }else if (widget.payStatus == 3){
      return 0xe630;
  }else {
    return 0xe65e;
  }
  }

}