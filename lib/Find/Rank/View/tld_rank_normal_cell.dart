import 'package:dragon_sword_purse/Find/Rank/Model/tld_normal_rank_model_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPRankNormalCell extends StatefulWidget {
  TPRankNormalCell({Key key,this.rank,this.rankModel}) : super(key: key);

  final TPNormalRankModel rankModel;

  final int rank;

  @override
  _TPRankNormalCellState createState() => _TPRankNormalCellState();
}

class _TPRankNormalCellState extends State<TPRankNormalCell> {
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
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3,
            child:  _getRankWidget(), 
         ),
            Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3,
            child:  Text(widget.rankModel.walletAddress,style: textStyle,textAlign: TextAlign.center,), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3,
            child:   Text('${widget.rankModel.totalTxCount}TP',style: textStyle,textAlign: TextAlign.center,),
         ),
        ],
      ),
    );
  }

  Widget _getRankWidget(){
    if (widget.rank < 4){
      Color color;
      if (widget.rank == 1){
        color = Theme.of(context).hintColor;
      }else if(widget.rank == 2){
        color = Color.fromARGB(255, 192, 192, 192);
      }else{
        color = Color.fromARGB(255, 198, 145, 69);
      }
      return Center(
        child: Icon(IconData(0xe60f,fontFamily: 'appIconFonts'),color: color,size: ScreenUtil().setSp(48),),
      );
    }else{
      return Text('${widget.rank}',style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),textAlign: TextAlign.center,);
    }
  }

}