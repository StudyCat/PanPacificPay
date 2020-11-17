import 'package:dragon_sword_purse/Find/Acceptance/RollOut/Model/tld_roll_out_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPRollOutBottomCell extends StatefulWidget {
  TPRollOutBottomCell({Key key,this.awardModel,this.didClickRollOutButton}) : super(key: key);

  final TPRollOutAwardModel awardModel;

  final Function didClickRollOutButton;

  @override
  _TPRollOutBottomCellState createState() => _TPRollOutBottomCellState();
}

class _TPRollOutBottomCellState extends State<TPRollOutBottomCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
            children :<Widget>[
              Padding(padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
              child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text(I18n.of(context).rollOutLimitAmountIs10000TP + '${widget.awardModel.min}TP ~ ${widget.awardModel.max}TP',style: TextStyle(
                  fontSize : ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)
                ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(136)),
              child: Container(
                width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(80),
                decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40)))
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(I18n.of(context).rollOut,style: TextStyle(fontSize : ScreenUtil().setSp(30),color : Colors.white),),
                  onPressed: (){
                    widget.didClickRollOutButton();
                  },
                ),
              ),
            )
            ]
          );
  }
}