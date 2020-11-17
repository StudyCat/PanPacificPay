import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_earnings_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPAcceptanceInvitationEarningsUnopenCell extends StatefulWidget {
  TPAcceptanceInvitationEarningsUnopenCell({Key key,this.inviteTeamModel,this.didClickOpenItem}) : super(key: key);

  final TPInviteTeamModel inviteTeamModel;

  final Function didClickOpenItem;

  @override
  _TPAcceptanceInvitationEarningsUnopenCellState createState() => _TPAcceptanceInvitationEarningsUnopenCellState();
}

class _TPAcceptanceInvitationEarningsUnopenCellState extends State<TPAcceptanceInvitationEarningsUnopenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
      child: Container(
        padding: EdgeInsets.only(bottom:ScreenUtil().setHeight(20)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
        ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
            child: _getHeaderRowView(),
            ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: Divider(height: ScreenUtil().setHeight(2),color: Color.fromARGB(255, 219, 218, 216),),
            ),
          GestureDetector(
             onTap:widget.didClickOpenItem,
             child : Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            )
           )
        ],
      ),
      ),
      );
  }

  Widget _getHeaderRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('${widget.inviteTeamModel.level}' + I18n.of(context).levelMarketingTeam +'(${widget.inviteTeamModel.totalUserCount}' + I18n.of(context).peoples + "）" ,style: TextStyle(fontSize:ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)),),
        Column(
          children: <Widget>[
            Text('${widget.inviteTeamModel.totalProfit}TP',style: TextStyle(fontSize:ScreenUtil().setSp(36),color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
            Text(I18n.of(context).totalProfit,style: TextStyle(fontSize:ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,), 
          ],
        )
      ],
    );
  }

}