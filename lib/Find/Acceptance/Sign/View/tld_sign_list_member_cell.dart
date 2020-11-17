import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_sign_list_member_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPSignListMemberCell extends StatefulWidget {
  TPSignListMemberCell({Key key,this.model}) : super(key: key);

  final TPSignMemberModel model;

  @override
  _TPSignListMemberCellState createState() => _TPSignListMemberCellState();
}

class _TPSignListMemberCellState extends State<TPSignListMemberCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Padding(
         padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
         child: Container(
           padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setHeight(20) ,ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
           decoration: BoxDecoration(
             borderRadius : BorderRadius.all(Radius.circular(4)),
             color: Colors.white
           ),
           child: Column(
             children: [
                _getCotentLabel(),
                _getDateLabel()
             ],
           ),
         ),
       ),
    );
  }


  Widget _getDateLabel(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
      child: Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child : Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.model.createTime), [yyyy,'-',mm,'-',dd,' ',HH,':',nn,':',ss]),textAlign: TextAlign.end,style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),)
    ),);
  }

  Widget _getCotentLabel(){
    return  Container(
                 width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                 child : RichText(
                   textAlign: TextAlign.start,
                   text: TextSpan(
                     text: '您的团队成员',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
                     children: <InlineSpan>[
                     TextSpan(
                     text: '(${widget.model.nickName})',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),),
                     TextSpan(
                     text: '签到成功，本次成员签到获得',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),),
                     TextSpan(
                     text: '(${widget.model.signProfitCount}TP)',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),),
                     ]
                   ),
                 )
               );
  }

}