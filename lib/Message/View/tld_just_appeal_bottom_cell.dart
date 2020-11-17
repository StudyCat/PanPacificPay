import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPJustAppealBottomCell extends StatefulWidget {
  TPJustAppealBottomCell({Key key,this.appealStatus,this.finishTime,this.didClickItemCallBack}) : super(key: key);

  final int appealStatus;

  final int finishTime;

  final Function(String) didClickItemCallBack;

  @override
  _TPJustAppealBottomCellState createState() => _TPJustAppealBottomCellState();
}

class _TPJustAppealBottomCellState extends State<TPJustAppealBottomCell> {
  @override
  Widget build(BuildContext context) {
    if (widget.appealStatus == null) {
      return Container();
    }else{
      if (widget.appealStatus == 0) {
        return _getAppealIsDealingStatusWidget();
      }else if(widget.appealStatus == 1 ){
        return _getAppealResultWidget(I18n.of(context).theAppealHasBeenProcessedAgree);
      }else if(widget.appealStatus == 2 ){
        return _getFailureAppealStatusWidget();
      } else{
        return Container();
      }
    }
  }

  Widget _getAppealIsDealingStatusWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 0,top : ScreenUtil().setHeight(22)),
          child: Text(I18n.of(context).waitingProcess,style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),),
        ),
        _getButtonWidget(I18n.of(context).repeal)
      ],
    );
  }

  Widget _getFailureAppealStatusWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       _getAppealResultWidget(I18n.of(context).theAppealHasBeenProcessedDisAgree),
       _getButtonWidget(I18n.of(context).reapply)
      ],
    );
  }


  Widget _getButtonWidget(String title){
    Size size = MediaQuery.of(context).size;
    return Center(
      child :  Padding(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(120),),
            child: Container(
              height : ScreenUtil().setHeight(80),
              width : size.width - ScreenUtil().setWidth(160),
              child: OutlineButton(
                padding: EdgeInsets.all(0),
          onPressed: () => widget.didClickItemCallBack(title),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          child: Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Theme.of(context).primaryColor),
          ),
        )),
        )
    );
  }

  Widget _getAppealResultWidget(String content){
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(22)),
          width : size.width,
          child : Text(content,style : TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize:ScreenUtil().setSp(28)))
        ),
        Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.finishTime),[yyyy,'/',mm,'/',dd,' ',HH,':',nn,':',ss]),style : TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize:ScreenUtil().setSp(28)))
      ],
    );
  }

}