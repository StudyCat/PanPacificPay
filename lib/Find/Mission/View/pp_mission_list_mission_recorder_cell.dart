import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PPMissionListMissionRecorderCell extends StatefulWidget {
  PPMissionListMissionRecorderCell({Key key,this.didClickItemCallBack,this.orderListModel}) : super(key: key);

  final TPMissionOrderListModel orderListModel;

  final Function didClickItemCallBack;

  @override
  _PPMissionListMissionRecorderCellState createState() => _PPMissionListMissionRecorderCellState();
}

class _PPMissionListMissionRecorderCellState extends State<PPMissionListMissionRecorderCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(36),
                bottom: ScreenUtil().setHeight(34)),
            child: _getContentColumn(context)),
      ),
    ),
    );
  }

  Widget _getContentColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _getAdressIMBtn(context),
        _getNumAmountStatusView(context),
        _getDateAndDetailBtn(context),
        _getAppealStatusWidget()
      ],
    );
  }

  Widget _getAdressIMBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          I18n.of(context).orderNumLabel + ':' + widget.orderListModel.orderNo,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)),
        ),
        GestureDetector(
          onTap : (){},
          child: Icon(
          IconData(0xe609, fontFamily: 'appIconFonts'),
          size: ScreenUtil().setWidth(32),
        ),
        )
      ],
    );
  }

  Widget _getNumAmountStatusView(BuildContext context) {
    TPOrderStatusInfoModel infoModel = TPDataManager.orderListStatusMap[widget.orderListModel.status];
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _getInfoView(I18n.of(context).countLabel,  widget.orderListModel.txCount + 'TP', null),
          _getInfoView(I18n.of(context).orderListAmountLabel, '¥' + widget.orderListModel.txCount, null),
          _getInfoView(I18n.of(context).statusLabel, infoModel.orderStatusName, infoModel.orderStatusColor),
        ],
      ),
    );
  }

  Widget _getInfoView(String title, String content,Color contentColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Theme.of(context).primaryColor),
        ),
        Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
          child: Text(
            content,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: contentColor == null ? Theme.of(context).primaryColor : contentColor,
          ),
        ),
        )],
    );
     }

  Widget _getDateAndDetailBtn(BuildContext context){
     return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.orderListModel.createTime),[yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
           Container(
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(48),
              child: OutlineButton(
                onPressed: () {
                  widget.didClickItemCallBack();
                },
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                child: Text(
                  '详情',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Theme.of(context).primaryColor),
                ),
              )),
        ],
      ),
    );
  }

  Widget _getAppealStatusWidget(){
    if (widget.orderListModel.appealStatus > -1){
      String appealStatus = '';
      switch (widget.orderListModel.appealStatus) {
        case 0:
          appealStatus = I18n.of(context).appealingLabel;
          break;
        case 1:
          appealStatus = I18n.of(context).appealOrderSuccessLabel;
          break;
        default:
          appealStatus = I18n.of(context).appealOrderSuccessLabel;
          break;
      }
      return Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left :ScreenUtil().setWidth(20),right :ScreenUtil().setWidth(20)),
        child : Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(60),
        child: CupertinoButton(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.zero,
          child: Text(appealStatus,textAlign: TextAlign.end,style: TextStyle(fontSize : ScreenUtil().setSp(28),color :Colors.white),), 
          onPressed: (){})
      ) 
        );
    }else{
      return Container();
    }
  }
}