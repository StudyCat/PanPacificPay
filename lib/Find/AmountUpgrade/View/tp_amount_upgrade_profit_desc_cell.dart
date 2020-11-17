import 'package:dragon_sword_purse/Find/AmountUpgrade/Model/tp_account_upgrade_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAccountUpgradeProfitDescCell extends StatefulWidget {
  TPAccountUpgradeProfitDescCell({Key key,this.levelDescModel}) : super(key: key);

  final TPUpgradeLevelDescModel levelDescModel;

  @override
  _TPAccountUpgradeProfitDescCellState createState() => _TPAccountUpgradeProfitDescCellState();
}

class _TPAccountUpgradeProfitDescCellState extends State<TPAccountUpgradeProfitDescCell> {
   @override
  Widget build(BuildContext context) {
   TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width : ScreenUtil().setWidth(120),
            child:  Text('LV' +  '${widget.levelDescModel.taskUserLevel}',style: textStyle,textAlign: TextAlign.center,), 
         ),
            Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2,
            child:  Text('${widget.levelDescModel.taskQuota}TP',style: textStyle,textAlign: TextAlign.center,), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(180)) / 2,
            child:   Text(widget.levelDescModel.remark,style: textStyle,textAlign: TextAlign.center,),
         ),
        ],
      ),
    );
  }
}