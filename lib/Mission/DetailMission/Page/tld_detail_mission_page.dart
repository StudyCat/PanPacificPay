import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Mission/DetailMission/Model/tld_detail_mission_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPDetailMissionPage extends StatefulWidget {
  TPDetailMissionPage({Key key,this.taskWalletId}) : super(key: key);

  final int taskWalletId;

  @override
  _TPDetailMissionPageState createState() => _TPDetailMissionPageState();
}

class _TPDetailMissionPageState extends State<TPDetailMissionPage> {
  TPDetailMissionInfoModel _infoModel;

  TPDetailMissionModelManager _modelManager;

  Timer _timer;

  int _countdownTime;

  String _subStr = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPDetailMissionModelManager();
    _getDetailMissionInfo();
  }

  void _getDetailMissionInfo(){
    _modelManager.getDetailMissionInfo(widget.taskWalletId, (TPDetailMissionInfoModel model){
      setState(() {
        _infoModel = model;
        _countdownTime = model.expireTime;
      });
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer != null){
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_sale_page',
        transitionBetweenRoutes: false,
        middle: Text('任务详情'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _infoModel != null ? _getBodyWidget() : Container(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(30),
        right: ScreenUtil().setWidth(30),
        bottom: ScreenUtil().setHeight(30)
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getHeaderView(),
            _getAmountView(),
            _getInfoView(),
            _getFinishMissionTextWidget(),
            _getTimeRowWidget(),
            _getAddressText('我的-钱包地址  ', _infoModel.receiveWalletAddress),
            _getAddressText('任务-钱包地址  ', _infoModel.releaseWalletAddress)
          ],
        ),
      ),
    );
  }

  Widget _getHeaderView() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '任务编号：' + _infoModel.taskNo,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153)),
            ),
            RichText(
                text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                child: CachedNetworkImage(
                  imageUrl:
                      _infoModel.levelIcon,
                  width: ScreenUtil().setWidth(32),
                  height: ScreenUtil().setWidth(32),
                ),
              ),
              TextSpan(
                  text:' ('+ _infoModel.progressCount+')',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51)))
            ]))
          ]),
    );
  }

  Widget _getAmountView() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getAmountColumnView(
                '实际收益', _infoModel.realProfit + 'TP', Theme.of(context).primaryColor),
            _getAmountColumnView(
                '累计收益', _infoModel.totalProfit + 'TP', Color.fromARGB(255, 51, 51, 51))
          ]),
    );
  }

  Widget _getAmountColumnView(String title, String content, Color color) {
    return Column(
      children: <Widget>[
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(48),
              color: color,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 153, 153, 153))),
        )
      ],
    );
  }

  Widget _getInfoView() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getInfoColumnView('最小购买量',  _infoModel.quote+'TP'),
            _getInfoColumnView('奖励金比例',  '${double.parse(_infoModel.profitRate) * 100}' + '%'),
            _getInfoColumnView('奖励金', _infoModel.profit + 'TP'),
            _getInfoColumnView('手续费比例', '${double.parse(_infoModel.chargeRate) * 100}'+ '%')
          ]),
    );
  }

  Widget _getInfoColumnView(String title, String content) {
    return Column(
      children: <Widget>[
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51),
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153))),
        )
      ],
    );
  }

  Widget _getFinishMissionTextWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        padding:
            EdgeInsets.only(left: 5, right: 5, top: ScreenUtil().setHeight(14)),
        height: ScreenUtil().setHeight(56),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text('当前任务钱包累计完成：'+ _infoModel.totalQuote +'TP',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51))),
      ),
    );
  }

  Widget _getTimeRowWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Row(children: <Widget>[
        _getTimeTitleColumView(),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
          child: _getTimeContentColumView(),
        )
      ]),
    );
  }

  Widget _getTimeTitleColumView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('任务时间段',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153))),
        Text('任务剩余时间',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153))),
      ],
    );
  }

  Widget _getTimeContentColumView() {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_getTimeStr(),
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromARGB(255, 51, 51, 51),
                fontWeight: FontWeight.bold)),
        Text(_subStr,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromARGB(255, 51, 51, 51),
                fontWeight: FontWeight.bold)),
      ],
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
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(_infoModel.startTime);
    String startTimeStr = formatDate(startTime, [HH,':',nn]);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(_infoModel.endTime);
    String endTimeStr = formatDate(endTime, [HH,':',nn]);
    return startTimeStr + '-' + endTimeStr;
  }

  Widget _getAddressText(String title, String content) {
    return RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153)),children: <InlineSpan>[
                  TextSpan(
            text: content,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51)))
                ]));
  }
}
