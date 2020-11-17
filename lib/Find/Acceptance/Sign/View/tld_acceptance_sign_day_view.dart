import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TPAcceptanceSignDayViewType{
  signFail,
  signComplete,
  signToday,
  signWait
}

class TPAcceptanceSignDayView extends StatefulWidget {
  TPAcceptanceSignDayView({Key key,this.type,this.day}) : super(key: key);

  final TPAcceptanceSignDayViewType type;

  final int day;

  @override
  _TPAcceptanceSignDayViewState createState() => _TPAcceptanceSignDayViewState();
}

class _TPAcceptanceSignDayViewState extends State<TPAcceptanceSignDayView> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == TPAcceptanceSignDayViewType.signFail){
      return _getFailSignWidget();
    }else if(widget.type == TPAcceptanceSignDayViewType.signComplete){
      return _getCompleteSignWidget();
    }else if(widget.type == TPAcceptanceSignDayViewType.signToday){
      return _getTodaySignWidget();
    }else{
      return _getWaitSignWidget();
    }
  }

  Widget _getFailSignWidget(){
    return Padding(
      padding:EdgeInsets.zero,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${widget.day}',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(32)),)
      ],
    ), 
    );
  }

  Widget _getCompleteSignWidget(){
    return Padding(
      padding:EdgeInsets.zero,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${widget.day}',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(32)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(4)),
          child: Container(
            height: ScreenUtil().setHeight(32),
            width: ScreenUtil().setWidth(80),
            decoration : BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 217, 176, 123), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(16))),
              color: Color.fromARGB(255, 236, 213, 174)
            ),
            child: Center(
              child: Text(I18n.of(context).signed,style : TextStyle(fontSize:ScreenUtil().setSp(20),color:Color.fromARGB(255, 57, 57, 57))),
            ),
          ),
          )
      ],
    ), 
    );
  }  

  Widget _getWaitSignWidget(){
    return Padding(
      padding:EdgeInsets.zero,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${widget.day}',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(32)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(4)),
          child: Container(
            height: ScreenUtil().setHeight(32),
            width: ScreenUtil().setWidth(80),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(16))),
              color: Color.fromARGB(255, 57, 57, 57)
            ),
            child: Center(
              child: Text(I18n.of(context).signIn,style : TextStyle(fontSize:ScreenUtil().setSp(20),color:Theme.of(context).hintColor)),
            ),
          ),
          )
      ],
    ), 
    );
  }

  Widget _getTodaySignWidget(){
    return Padding(
      padding:EdgeInsets.zero,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${widget.day}',style: TextStyle(color:Theme.of(context).hintColor,fontSize:ScreenUtil().setSp(32)),),
        Padding(
          padding:EdgeInsets.only(top: ScreenUtil().setHeight(4)),
          child: Icon(Icons.check,size : ScreenUtil().setWidth(32)), 
          )
      ],
    ), 
    );
  }
}

