import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_my_mission_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionFirstMyMissionCell extends StatefulWidget {
  TPMissionFirstMyMissionCell({Key key,this.didClickItemCallBack,this.model}) : super(key: key);
  
  final Function didClickItemCallBack;

  final TPMissionInfoModel model;

  @override
  _TPMissionFirstMyMissionCellState createState() =>
      _TPMissionFirstMyMissionCellState();
}

class _TPMissionFirstMyMissionCellState
    extends State<TPMissionFirstMyMissionCell> {
  
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

    if (_timer != null){
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(5)),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration :BoxDecoration(
          color : Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getHeaderRowView(),
            _getTimeRowView(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
              child: _getAddressTextWidget('钱包地址：'+widget.model.receiveWalletAddress),
            ),
          ],
        ),
    ),
    ),
    );
  }

Widget _getAddressTextWidget(String content){
    return Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),);
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          _getHeaderColumnView(),
        ]
      ),
    );
  }

  Widget _getHeaderColumnView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('任务编号：'+widget.model.taskNo,style: TextStyle(fontSize:ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
        RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: widget.model.levelIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),),
            TextSpan(text :' ('+widget.model.progressCount+')',style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
          ]))
      ],
    );
  }

  Widget _getTimeRowView(){
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
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getTimeColumnView('任务时间段', _getTimeStr()),
          _getTimeColumnView('任务剩余时间', _subStr)
        ]
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

   String _getTimeStr(){
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.model.startTime);
    String startTimeStr = formatDate(startTime, [HH,':',nn]);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(widget.model.endTime);
    String endTimeStr = formatDate(endTime, [HH,':',nn]);
    return startTimeStr + '-' + endTimeStr;
  }




  Widget _getTimeColumnView(String title,String timeStr){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children : <Widget>[
        Text(title,style:TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))),
        Text(timeStr,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.bold))
      ]
    );
  }

}
