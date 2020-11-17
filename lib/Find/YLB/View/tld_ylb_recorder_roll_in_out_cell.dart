import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_profit_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_roll_in_out_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPYLBRecorderRollInOutCell extends StatefulWidget {
  TPYLBRecorderRollInOutCell({Key key,this.type,this.profitListModel}) : super(key: key);

  final int type; //1为转入，2为转出

  final TPYLBProfitListModel profitListModel;

  @override
  _TPYLBRecorderRollInOutCellState createState() => _TPYLBRecorderRollInOutCellState();
}

class _TPYLBRecorderRollInOutCellState extends State<TPYLBRecorderRollInOutCell> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
        decoration : BoxDecoration(
          color : Colors.white,
          borderRadius : BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children : <Widget>[
            _getContentWidget(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(14),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
              child: Divider(
                height : ScreenUtil().setHeight(2),
                color : Color.fromARGB(255, 200, 200, 200)
              ),
            ),
          ]
        ),
      ),
      );
  }

  Widget _getContentWidget(){
    String symbol = widget.type == 1 ? '+' : '-';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getTimeWalletAddressColumn(),
        Text( symbol + '${widget.profitListModel.tldCount}TP',textAlign: TextAlign.center,style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32)))
      ],
    );
  }

  Widget _getTimeWalletAddressColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children : <Widget>[
        Text(widget.profitListModel.typeName,textAlign: TextAlign.center,style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.profitListModel.createTime), [yyyy,'-',mm,'-',dd,' ',HH,':',ss]),style : TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))),
        ),
      ]
    );
  }

}