import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_button.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_mission_progress_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPMyMissionHeaderCell extends StatefulWidget {
  TPMyMissionHeaderCell({Key key,this.didClickItemCallBack,this.isOpen,this.progressModel,this.didClickOpenBtnCallBack,this.didClickCanccelBtnCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  final Function didClickCanccelBtnCallBack;

  final bool isOpen;

  final TPMissionProgressModel progressModel;

  final Function didClickOpenBtnCallBack;

  @override
  _TPMyMissionHeaderCellState createState() => _TPMyMissionHeaderCellState();
}

class _TPMyMissionHeaderCellState extends State<TPMyMissionHeaderCell> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child:  Container(
        padding: EdgeInsets.only(top :ScreenUtil().setWidth(20),left: ScreenUtil().setWidth(20),bottom: ScreenUtil().setWidth(20)),
        decoration :BoxDecoration(
          color : Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getHeaderRowView(),
             Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: Divider(height: ScreenUtil().setHeight(2),color: Color.fromARGB(255, 198, 198, 198),),
            ),
            _getMissionInfoView(),
            _getPaymentRowWidget(),
            _getWalletAddressView(),
            _getTimeAndLevelWidget(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: Divider(height: ScreenUtil().setHeight(2),color: Color.fromARGB(255, 198, 198, 198),),
            ),
            GestureDetector(
              onTap: widget.didClickOpenBtnCallBack,
              child: Padding(
              padding: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
              child: Center(
                child: Icon(widget.isOpen ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color:Theme.of(context).primaryColor),
              ),
            ),
            )
          ],
        ),
    ),
    );
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          Text('任务单号：' + widget.progressModel.taskBuyNo,style: TextStyle(fontSize:ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
          picAndTextButton('取消', (){
            widget.didClickCanccelBtnCallBack();
          })
        ]
      ),
    );
  }

   Widget _getMissionInfoView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getMissionInfoColumWidget('单笔额度', widget.progressModel.quote + 'TP', null),
          _getMissionInfoColumWidget('总量',  widget.progressModel.totalCount+'TP', null),
          _getMissionInfoColumWidget('剩余', widget.progressModel.currentCount+'TP', null),
          _getMissionInfoColumWidget('状态', '进行中', null)
        ]
      ),
      ),
    );
  }

  Widget _getPaymentRowWidget(){
    int iconInt;
  if (widget.progressModel.payMethodVO.type == 1){
    iconInt = 0xe679;
  }else if(widget.progressModel.payMethodVO.type == 2){
    iconInt = 0xe61d;
  }else if (widget.progressModel.payMethodVO.type == 3){
    iconInt = 0xe630;
  }else{
    iconInt = 0xe65e;
  }
  return Padding(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
    child: Container(
    width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('收款方式',style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        Icon(IconData(iconInt,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
      ],
    ),
  ),
  );
}

Widget _getWalletAddressView(){
  return Padding(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
    child: Container(
    width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('挂售钱包',style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(250),
          child: Text(widget.progressModel.releaseWalletAddress,style:TextStyle(fontSize :ScreenUtil().setSp(24),color:Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.end,),
        ),
      ],
    ),
  ),);
}

Widget _getTimeAndLevelWidget(){
   return Padding(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
    child: Container(
    width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(_getTimeStr(),style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
       RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: widget.progressModel.levelIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),),
          ])),
      ],
    ),
  ),);
}

  Widget _getMissionInfoColumWidget(String title,String content,Color color){
    return Column(
      children: <Widget>[
        Text(title,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:color != null ? color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold)),
        )
      ],
    );
  }






   String _getTimeStr(){
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.progressModel.createTime);
    String startTimeStr = formatDate(startTime, [yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]);
    return startTimeStr;
  }


}