
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class TPDetailOrderHeaderView extends StatefulWidget {
  TPDetailOrderHeaderView({Key key,this.detailOrderModel,this.isBuyer,this.timeIsOverRefreshUICallBack,this.didClickAppealBtnCallBack,this.didClickChatBtnCallBack}) : super(key: key);

  final TPDetailOrderModel detailOrderModel;

  final bool isBuyer;

  final Function timeIsOverRefreshUICallBack;

  final Function didClickAppealBtnCallBack;

  final Function didClickChatBtnCallBack;

  @override
  _TPDetailOrderHeaderViewState createState() => _TPDetailOrderHeaderViewState();
}

class _TPDetailOrderHeaderViewState extends State<TPDetailOrderHeaderView> {

  Timer timer;

  static const duration = const Duration(seconds: 1);

  int _countdownTime;

  String _subStr = ''; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.detailOrderModel.expireTime != null){
      _countdownTime = widget.detailOrderModel.expireTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 242, 242, 242),
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: _getColumnView(context),
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
          _subStr = minute > 0 ? I18n.of(context).pleasePayUntilLabel +minute.toString()+I18n.of(context).payOrderMinuteLabel +second.toString()+ I18n.of(context).payOrderSecondLabel :   I18n.of(context).pleasePayUntilLabel+second.toString()+I18n.of(context).payOrderSecondLabel;
          if (_countdownTime < 0){
            timer.cancel();
            timer = null;
            widget.timeIsOverRefreshUICallBack();
          }
      });
      _countdownTime --;
    }
  }

  Widget _getSubContentRowView(){
    bool isNeedAppeal = false;
    if (widget.detailOrderModel != null){
      switch (widget.detailOrderModel.status) {
        case 0 : {
          if (widget.isBuyer == true){
             if (timer == null){
              timer = Timer.periodic(duration, (timer) { 
                timerFunction();
              });
            }
          }else{
            _subStr = I18n.of(context).waitBuyerPaymentLabel;
          }
          }
          break;
        case 1 :{
          _subStr = I18n.of(context).waitSellerSureLabel;
          isNeedAppeal = true;
        }
        break;
        case -1 :{
          _subStr = I18n.of(context).orderHaveCanceledLabel;
        }
        break;
        default :{
          
        }
        break;
        }
      }
    if (widget.detailOrderModel.appealStatus > -1){
      isNeedAppeal = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(_subStr,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor),),
        Offstage(
          offstage: !isNeedAppeal,
          child: GestureDetector(
            onTap: () => widget.didClickAppealBtnCallBack(),
            child : Text(_getAppealStatusString(),style: TextStyle(fontSize : ScreenUtil().setSp(32),color : Theme.of(context).primaryColor),),
          ),
        ),
      ],
    );
  }

  String _getAppealStatusString(){
    if (widget.detailOrderModel.appealStatus == -1){
      return I18n.of(context).appealOrderLabel;
    }else if (widget.detailOrderModel.appealStatus == 0){
      return I18n.of(context).appealingLabel;
    }else if (widget.detailOrderModel.appealStatus == 1){
      return I18n.of(context).appealOrderSuccessLabel;
    }else{
      return I18n.of(context).appealOrderFailureLabel;
    }
  }

  Widget _getStatusRowView(BuildContext context){
    String statusStr;
    if (widget.detailOrderModel == null){
      statusStr = '';
    }else{
      TPOrderStatusInfoModel infoModel = TPDataManager.orderListStatusMap[widget.detailOrderModel.status];
      statusStr = infoModel.orderStatusName;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(statusStr,style :TextStyle(fontSize : ScreenUtil().setSp(44),color:Theme.of(context).primaryColor)),
        IconButton(icon: Icon(IconData(0xe6a2,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(46),color:Theme.of(context).primaryColor),onPressed:widget.didClickChatBtnCallBack,)
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