import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_mission_progress_model_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewMissionMyMissionCell extends StatefulWidget {
  TPNewMissionMyMissionCell({Key key,this.model,this.didClickItemCallBack,this.didClickIMBtnCallBack}) : super(key: key);

  
  final Function didClickItemCallBack;

  final TPOrderListModel model;

  final Function didClickIMBtnCallBack;


  @override
  _TPNewMissionMyMissionCellState createState() => _TPNewMissionMyMissionCellState();
}

class _TPNewMissionMyMissionCellState extends State<TPNewMissionMyMissionCell> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.didClickItemCallBack,
      child:  Container(
        child : Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
          child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20),right: 0),
            decoration: BoxDecoration(
              color : Colors.white,
              borderRadius:BorderRadius.all(Radius.circular(4))
            ),
            child: _getContentColumnView(),
          ),
        )
    ),
    );
  }

  Widget _getContentColumnView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children : <Widget>[
        _getHeaderRowView(),
        _getMissionInfoView(),
        _getTimeTextWidget()
      ]
    );
  }

  Widget _getTimeTextWidget(){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.model.createTime);
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Text(formatDate(time, [yyyy,'-',mm,'-',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
    );
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(80),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[
          Text('任务编号：' + widget.model.taskBuyNo,style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
        GestureDetector(
          onTap: widget.didClickIMBtnCallBack,
          child: Container(
          width: ScreenUtil().setWidth(74),
          height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            borderRadius : BorderRadius.only(topLeft:Radius.circular(ScreenUtil().setHeight(30)),bottomLeft:Radius.circular(ScreenUtil().setHeight(30))),
            color: Theme.of(context).primaryColor
          ),
          child: Icon(IconData(0xe609,fontFamily : 'appIconFonts'),color: Colors.white,),
        ),
        )
      ]
    ),
    );
  }

  Widget _getMissionInfoView(){
    Map statusMap = TPDataManager.orderListStatusMap;
    TPOrderStatusInfoModel statusInfoModel = statusMap[widget.model.status];
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getMissionInfoColumWidget('等级', 'L' +'${widget.model.taskLevel}', null),
          _getMissionInfoColumWidget('额度',  widget.model.quote+'TP', null),
          _getMissionInfoColumWidget('奖励金', widget.model.profit+'TP', null),
          _getMissionInfoColumWidget('状态', statusInfoModel.orderStatusName, statusInfoModel.orderStatusColor)
        ]
      ),
    );
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
}