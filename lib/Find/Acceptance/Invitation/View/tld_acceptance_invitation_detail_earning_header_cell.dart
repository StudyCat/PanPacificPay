import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_invitation_detail_earning_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceInvitationDetailHeaderCell extends StatefulWidget {
  TPAcceptanceInvitationDetailHeaderCell({Key key, this.detailEarningModel})
      : super(key: key);

  final TPInviteDetailEarningModel detailEarningModel;

  @override
  _TPAcceptanceInvitationDetailHeaderCellState createState() =>
      _TPAcceptanceInvitationDetailHeaderCellState();
}

class _TPAcceptanceInvitationDetailHeaderCellState
    extends State<TPAcceptanceInvitationDetailHeaderCell> {
  List _tapCountList;

  bool _isShowRealTel = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(20),
            ScreenUtil().setHeight(20),
            ScreenUtil().setWidth(20),
            ScreenUtil().setHeight(20)),
        child: Column(
          children: <Widget>[
            _getRowView(I18n.of(context).userID, widget.detailEarningModel.userName),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: GestureDetector(
                onTap: () {
                  _tapCountFunction();
                },
                child: _getRowView(
                    I18n.of(context).userCellphoneNumber,
                    _isShowRealTel
                        ? widget.detailEarningModel.realTel
                        : widget.detailEarningModel.tel),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _tapCountFunction() {
    if (_tapCountList == null) {
      _tapCountList = [];
    }
    int nowTime = DateTime.now().millisecondsSinceEpoch;
    if (_tapCountList.length > 0) {
      int firstTime;
      firstTime = _tapCountList.first;
      if ((nowTime - firstTime) < 3000) {
        _tapCountList.add(nowTime);
        if (_tapCountList.length > 4) {
          setState(() {
            _isShowRealTel = !_isShowRealTel;
          });
          _tapCountList = [];
        }
      } else {
        _tapCountList = [];
        _tapCountList.add(nowTime);
      }
    } else {
      _tapCountList.add(nowTime);
    }
  }

  Widget _getRowView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 153, 153, 153)),
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}
