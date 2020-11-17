import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/Rank/Model/tld_rank_mine_model_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPRankMineCell extends StatefulWidget {
  TPRankMineCell({Key key,this.rankModel}) : super(key: key);

  final TPMineRankModel rankModel;

  @override
  _TPRankMineCellState createState() => _TPRankMineCellState();
}

class _TPRankMineCellState extends State<TPRankMineCell> {
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
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text(widget.rankModel.walletAddress,style: textStyle,textAlign: TextAlign.center,maxLines: 1,), 
         ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text(widget.rankModel.rankSort.toString(),style: textStyle,textAlign: TextAlign.center,), 
         ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text('${widget.rankModel.rankProfit}TP',style: textStyle,textAlign: TextAlign.center,), 
         ),
            Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text(widget.rankModel.rankType == 1 ? '周榜' : '月榜',style: textStyle,textAlign: TextAlign.center,), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:   Text(formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.rankModel.createTime)), [yyyy,'/',mm,'/',dd]),style: textStyle,textAlign: TextAlign.center,),
         ),
        ],
      ),
    );
  }
}