import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_with_draw_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPAcceptanceWithdrawChooseTypeCell extends StatefulWidget {
  TPAcceptanceWithdrawChooseTypeCell({Key key,this.didVoteCallBack,this.title,@required this.usefulInfoModel}) : super(key: key);

  final Function(int) didVoteCallBack;

  final TPAceeptanceWithdrawUsefulInfoModel usefulInfoModel;

  final String title;

  @override
  _TPAcceptanceWithdrawChooseTypeCellState createState() => _TPAcceptanceWithdrawChooseTypeCellState();
}

class _TPAcceptanceWithdrawChooseTypeCellState extends State<TPAcceptanceWithdrawChooseTypeCell> {
  int _vote = 1;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
        left:ScreenUtil().setWidth(30),
        right:ScreenUtil().setWidth(30),
        top:ScreenUtil().setWidth(2),
      ),
      child:  ClipRRect(
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
    ),
    );
  }

  Widget _getVoteRowView(){
    if (widget.usefulInfoModel.showPlatform == true){
      return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(value: 1,groupValue: _vote,
          onChanged: (value) {
            setState(() {
              _vote = value;
            });
            widget.didVoteCallBack(value);              
          },
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          child: Text(I18n.of(context).referrer,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(100)),
          child: Radio(value: 2,groupValue: _vote,
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
          child: Text(I18n.of(context).platform,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ),
      ],
    );
    }else {
       return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(value: 1,groupValue: _vote,
          onChanged: (value) {
            setState(() {
              _vote = value;
            });
            widget.didVoteCallBack(value);              
          },
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          child: Text(I18n.of(context).referrer,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        )
      ],
    );
    }
  }
}