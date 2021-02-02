import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_award_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionLevelDescCell extends StatefulWidget {
  TPMissionLevelDescCell({Key key,this.descModel}) : super(key: key);

  final TPMissionLevelDescModel descModel;

  @override
  _TPMissionLevelDescCellState createState() => _TPMissionLevelDescCellState();
}

class _TPMissionLevelDescCellState extends State<TPMissionLevelDescCell> {
  @override
  Widget build(BuildContext context) {
   TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width : ScreenUtil().setWidth(120),
            child:  Text('LV' +  '${widget.descModel.taskProfitLevel}',style: textStyle,textAlign: TextAlign.center,), 
         ),
            Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2,
            child:  Text(widget.descModel.nextQuota != null ? '${widget.descModel.curQuota}-${widget.descModel.nextQuota}' : '>${widget.descModel.curQuota}',style: textStyle,textAlign: TextAlign.center,), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2,
            child:   RichText(textAlign: TextAlign.center,text: TextSpan(text : '${widget.descModel.profitRate}%+',style : textStyle,children: [
              TextSpan(text : '${widget.descModel.addProfitRate}%',style : TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil().setSp(24)),)
            ])),
         ),
        ],
      ),
    );
  }
}