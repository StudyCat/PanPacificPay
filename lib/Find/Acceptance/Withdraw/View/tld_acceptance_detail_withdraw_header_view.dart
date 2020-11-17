import 'dart:async';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceDetailWithdrawHeaderView extends StatefulWidget {
  TPAcceptanceDetailWithdrawHeaderView({Key key,this.timeIsOverRefreshUICallBack,this.didClickAppealBtnCallBack,this.didClickChatBtnCallBack,this.detailModel}) : super(key: key);

  final Function timeIsOverRefreshUICallBack;

  final Function didClickAppealBtnCallBack;

  final Function didClickChatBtnCallBack;

  final TPAcceptanceWithdrawOrderListModel detailModel;

  @override
  _TPAcceptanceDetailWithdrawHeaderViewState createState() => _TPAcceptanceDetailWithdrawHeaderViewState();
}

class _TPAcceptanceDetailWithdrawHeaderViewState extends State<TPAcceptanceDetailWithdrawHeaderView> {
  Timer timer;

  static const duration = const Duration(seconds: 1);

  int _countdownTime;

  String _subStr = ''; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.detailModel != null){
      _countdownTime = widget.detailModel.expireTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: widget.detailModel != null ? _getColumnView(context) : Container(),
        ),
    );
  }

  Widget _getColumnView(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getStatusRowView(context),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: _getSubContentRowView(),
          )
      ],
    );
  }

  void timerFunction(){
    if(_countdownTime > 0){
      int minute = _countdownTime ~/ 60;
      int second = _countdownTime % 60;
        setState(() {
          _subStr = minute > 0 ? I18n.of(context).pleasePayUntilLabel + minute.toString()+I18n.of(context).payOrderMinuteLabel + second.toString()+I18n.of(context).payOrderSecondLabel :   I18n.of(context).pleasePayUntilLabel+second.toString() + I18n.of(context).payOrderSecondLabel;
          if (_countdownTime < 0){
            timer.cancel();
            timer = null;
            widget.timeIsOverRefreshUICallBack();
          }
      });
      _countdownTime --;
    }else{
      timer.cancel();
      timer = null;
    }
  }

  Widget _getSubContentRowView(){
    bool isNeedAppeal = true;
    if (widget.detailModel != null){
      switch (widget.detailModel.cashStatus) {
        case 0 : {
          // if (widget.detailModel.amApply == false){
          //    if (timer == null){
          //     timer = Timer.periodic(duration, (timer) { 
          //       timerFunction();
          //     });
          //   }
          // }else{
            _subStr = '';
          // }
          }
          break;
        case 1 :{
          _subStr = I18n.of(context).waitWithdrawerSure;
          isNeedAppeal = true;
        }
        break;
        case -1 :{
          _subStr = I18n.of(context).withdrawIsCanceled;
        }
        break;
        default :{
          
        }
        break;
        }
      }
    if (widget.detailModel.appealStatus > -1){
      isNeedAppeal = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(_subStr,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).hintColor),),
        Offstage(
          offstage: !isNeedAppeal,
          child: GestureDetector(
            onTap: () => widget.didClickAppealBtnCallBack(),
            child : Text(_getAppealStatusString(),style: TextStyle(fontSize : ScreenUtil().setSp(32),color : Theme.of(context).hintColor),),
          ),
        ),
      ],
    );
  }

  String _getAppealStatusString(){
    if (widget.detailModel.appealStatus == -1){
      return I18n.of(context).appealOrderLabel;
    }else if (widget.detailModel.appealStatus == 0){
      return I18n.of(context).appealingLabel;
    }else if (widget.detailModel.appealStatus == 1){
      return I18n.of(context).appealOrderSuccessLabel;
    }else{
      return I18n.of(context).appealOrderFailureLabel;
    }
  }

  Widget _getStatusRowView(BuildContext context){
    String statusStr = '';
    if (widget.detailModel == null){
      statusStr = '';
    }else{
      TPOrderStatusInfoModel infoModel = TPDataManager.orderListStatusMap[widget.detailModel.cashStatus];
      statusStr = infoModel.orderStatusName;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(statusStr,style :TextStyle(fontSize : ScreenUtil().setSp(44),color: Theme.of(context).hintColor)),
        IconButton(icon: Icon(IconData(0xe6a2,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(46),color:Theme.of(context).hintColor),onPressed:widget.didClickChatBtnCallBack,)
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null){
      timer.cancel();
      timer = null;
    }
  }
}