import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

class TPSystemMessageCell extends StatefulWidget {
  TPSystemMessageCell({Key key,this.textMessage}) : super(key: key);

  final JMTextMessage textMessage;
  @override
  _TPSystemMessageCellState createState() => _TPSystemMessageCellState();
}

class _TPSystemMessageCellState extends State<TPSystemMessageCell> {
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(28),right: ScreenUtil().setWidth(28),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getTopRowView(),
              Text(widget.textMessage.text,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 102, 102, 102)))
            ],
          ),
        ),
      ),
      );
  }

  Widget _getTopRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         Text('TP官方',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.w700),),
         Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.textMessage.createTime),[yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
      ],
    );
  }

  // Widget _getLeftColumnView(){
  //   return Padding(
  //     padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),bottom : ScreenUtil().setHeight(10)),
  //     child: Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text('TP官方',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.w700),),
  //       Text(widget.messageModel.content,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 102, 102, 102)))
  //     ],
  //   ),
  //     );
  // }

  // Widget _getRightColumnView(){
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: <Widget>[
  //       Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.messageModel.createTime),[yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
  //       Text('已读',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)))
  //     ],
  //   );
  // }
}