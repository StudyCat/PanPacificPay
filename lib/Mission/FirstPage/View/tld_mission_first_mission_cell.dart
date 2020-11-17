import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionFirstMissionCell extends StatefulWidget {
  TPMissionFirstMissionCell({Key key,this.didClickGetBtnCallBack,this.model,this.timeIsOverRefreshUICallBack}) : super(key: key);

  final Function didClickGetBtnCallBack;

  final TPMissionListModel model;

  final Function timeIsOverRefreshUICallBack;

  @override
  _TPMissionFirstMissionCellState createState() =>
      _TPMissionFirstMissionCellState();
}

class _TPMissionFirstMissionCellState
    extends State<TPMissionFirstMissionCell> {
  
  Timer _timer;

  int _countdownTime;

  String _subStr = '';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countdownTime = widget.model.expireTime;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getLeftColumnView(),
            Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(144),
              child: CupertinoButton(
                  child: Text(
                    '领取',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  ),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setHeight(30))),
                  onPressed: widget.didClickGetBtnCallBack),
            )
          ],
        ),
      ),
    );
  }

  void _timerFunction(){
    if(_countdownTime > 0){
      int minute = _countdownTime % 60;
      int hour = minute ~/ 60;
      if (mounted) {
     setState(() {
        if (_countdownTime < 5) {
          _subStr = '任务即将结束';
        }else{
          _subStr = hour > 0 ? hour.toString()+'时'+minute.toString()+'分' :   minute.toString()+'分';
        }
      });
      }
       if (_countdownTime < 0){            
          _timer.cancel();
          _timer = null;
          // widget.timeIsOverRefreshUICallBack();
        }
      _countdownTime = _countdownTime - 1;
    }
  }

  
  Widget _getLeftColumnView() {
    if (_timer == null){
              _timer = Timer.periodic(Duration(minutes : 1), (timer) { 
                _timerFunction();
              });
    }
    int minute = _countdownTime % 60;
    int hour = _countdownTime ~/ 60;
    if (_countdownTime < 5) {
        _subStr = '任务即将结束';
    }else{
        _subStr = hour > 0 ? hour.toString()+'时'+minute.toString()+'分' :   minute.toString()+'分';        
    }
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: widget.model.levelIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),),
            TextSpan(text :' ' + widget.model.taskDesc,style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
              ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('任务时间段 ', _getTimeStr()),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('结束剩余时间 ', _subStr),
          ),
        ],
      ),
    );
  }



  String _getTimeStr(){
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.model.startTime);
    String startTimeStr = formatDate(startTime, [HH,':',nn]);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(widget.model.endTime);
    String endTimeStr = formatDate(endTime, [HH,':',nn]);
    return startTimeStr + '-' + endTimeStr;
  }

  Widget _getRichText(String title, String content) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(24),
            color: Color.fromARGB(255, 153, 153, 153)),
        children: <InlineSpan>[
          TextSpan(
              text: content,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)))
        ],
      ),
    );
  }
}
