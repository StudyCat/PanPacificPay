import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPJustNoticeVoteCell extends StatefulWidget {
  TPJustNoticeVoteCell({Key key,this.title,this.didVoteCallBack}) : super(key: key);

  final Function(int) didVoteCallBack;

  final String title;
  
  @override
  _TPJustNoticeVoteCellState createState() => _TPJustNoticeVoteCellState();
}

class _TPJustNoticeVoteCellState extends State<TPJustNoticeVoteCell> {
  int _vote = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
                child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
                child: _getVoteRowView(),
              )
            ]),
      ),
    );
  }

  Widget _getVoteRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(value: 2,groupValue: _vote,
          onChanged: (value) {
            setState(() {
              _vote = value;
            });
            widget.didVoteCallBack(value);              
          },
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          child: Text('赞同',style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(100)),
          child: Radio(value: 1,groupValue: _vote,
          onChanged: (value) {
            setState(() {
              _vote = value;
            });
            widget.didVoteCallBack(value);              
          },
        ),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          child: Text('反对',style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ),
      ],
    );
  }
}