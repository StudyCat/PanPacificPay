import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_person_center_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPAcceptancePersonCenterInvitePersonProfitCell extends StatefulWidget {
  TPAcceptancePersonCenterInvitePersonProfitCell({Key key,this.profitModel}) : super(key: key);

  final TPAcceptancePersonCenterProfitModel profitModel;

  @override
  _TPAcceptancePersonCenterInvitePersonProfitCellState createState() => _TPAcceptancePersonCenterInvitePersonProfitCellState();
}

class _TPAcceptancePersonCenterInvitePersonProfitCellState extends State<TPAcceptancePersonCenterInvitePersonProfitCell> {
 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left :ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
      child: Container(
        height: ScreenUtil().setHeight(88) * widget.profitModel.data.length  + ScreenUtil().setHeight(88),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        padding: EdgeInsets.only(left :ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius : BorderRadius.all(Radius.circular(4))
        ),
        child: _getListView()
      ),
    );
  }

  Widget _getListView(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.profitModel.data.length + 1 ,
      itemBuilder: (BuildContext context, int index) {
      if(index == 0){
        return Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Text(widget.profitModel.title,style:TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(36),fontWeight: FontWeight.bold)),
            );
      }
      TPAcceptancePersonCenterProfitSonModel sonModel = widget.profitModel.data[index - 1];
      return  Container(
          height: ScreenUtil().setHeight(88),
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(sonModel.content,style:TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize:ScreenUtil().setSp(28))),
             Text(sonModel.value,style:TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)),textAlign: TextAlign.right,),
          ],
        ),
      );
     },
    );
  }
}