import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_choose_mission_level_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPChooseMissionLevelCell extends StatefulWidget {
  TPChooseMissionLevelCell({Key key,this.levelModel}) : super(key: key);

  final TPMissionLevelModel levelModel;

  @override
  _TPChooseMissionLevelCellState createState() => _TPChooseMissionLevelCellState();
}

class _TPChooseMissionLevelCellState extends State<TPChooseMissionLevelCell> {
  @override
  Widget build(BuildContext context) {
    double rate = double.parse(widget.levelModel.profitRate) * 100;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white
      ),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
          RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: widget.levelModel.levelIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),),
            TextSpan(text :' ${widget.levelModel.levelName}',style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
          ])),
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children : <Widget>[
            Text('奖励金比例：$rate%',style :TextStyle(color : Color.fromARGB(255, 153, 153, 153))),
            Icon(Icons.keyboard_arrow_right)
          ]
        )
         ],
       ),
    ),
    );
  }
}