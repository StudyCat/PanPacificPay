import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceWithDrawBottomCell extends StatefulWidget {
  TPAcceptanceWithDrawBottomCell({Key key,this.didClickButtonCallBack}) : super(key: key);

  final Function didClickButtonCallBack;

  @override
  _TPAcceptanceWithDrawBottomCellState createState() => _TPAcceptanceWithDrawBottomCellState();
}

class _TPAcceptanceWithDrawBottomCellState extends State<TPAcceptanceWithDrawBottomCell> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(10)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20),top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Text(I18n.of(context).IfYouChooseTheBuyerAsYourReferrer,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(24)),),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(100)),
            child: Container(
              height : ScreenUtil().setHeight(80),
              width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
              child: CupertinoButton(
                onPressed: widget.didClickButtonCallBack,
                padding: EdgeInsets.zero,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: Text(I18n.of(context).exchange,style: TextStyle(color : Colors.white,fontSize:ScreenUtil().setSp(28)),),
              ),
            ),
          )
        ],
      ),
    );
  }
}