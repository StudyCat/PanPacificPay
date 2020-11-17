import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_list_do_mission_header_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';

class PPMissionListDoMissionCell extends StatefulWidget {
  PPMissionListDoMissionCell({Key key,this.didClickBuyBtnCallBack,this.missionModel}) : super(key: key);

    final Function didClickBuyBtnCallBack;

    final TPMissionBuyModel missionModel;

  @override
  _PPMissionListDoMissionCellState createState() => _PPMissionListDoMissionCellState();
}

class _PPMissionListDoMissionCellState extends State<PPMissionListDoMissionCell> {
 @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           width: screenSize.width - 30,
           padding: EdgeInsets.only(top : 10,bottom : 17),
           child: Column(
             children : <Widget>[
               
               PPMissionListDoMissionHeaderView(missionModel: widget.missionModel,didClickBuyBtnCallBack: widget.didClickBuyBtnCallBack,),
               _leftRightItem(context,34, 0, I18n.of(context).paymentTermLabel, '', false,widget.missionModel.payMethodVO.type),
               _leftRightItem(context,22, 0, '最低购买额度', widget.missionModel.max + 'TP', true,0),
               _leftRightItem(context,22, 0, '最高购买额度', widget.missionModel.maxAmount + 'TP', true,0),
             ]
           ),
         ),
       ),
    );
  }

  Widget _leftRightItem(BuildContext context, num top , num bottom,String title , String content,bool isTextType,int paymentType) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: bottom == 0 ? EdgeInsets.only(top : ScreenUtil().setHeight(top)) :EdgeInsets.only(top : ScreenUtil().setHeight(top),bottom: ScreenUtil().setHeight(bottom)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          alignment: Alignment.centerRight,
          child: isTextType ? Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,) : Icon(IconData(_getIconInt(paymentType),fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),)
        ),
      ],
    ),
  );
}}

int _getIconInt(int paymentType){
  if (paymentType == 1){
    return 0xe679;
  }else if (paymentType == 2){
    return 0xe61d;
  }else if (paymentType == 3){
    return 0xe630;
  }else{
    return 0xe65e;
  }
}