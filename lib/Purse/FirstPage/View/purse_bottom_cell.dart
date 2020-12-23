import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPPurseFirstPageBottomCell extends StatefulWidget {
  TPPurseFirstPageBottomCell({Key key}) : super(key: key);

  @override
  _TPPurseFirstPageBottomCellState createState() => _TPPurseFirstPageBottomCellState();
}

class _TPPurseFirstPageBottomCellState extends State<TPPurseFirstPageBottomCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30) , top : ScreenUtil().setHeight(10) ,right: ScreenUtil().setWidth(30)),
      child :  Container(
       decoration : BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(100, 198, 198, 198),
                  offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  )
            ]),  
       child: Padding(
           padding: EdgeInsets.only(top : ScreenUtil().setHeight(26) ,left :ScreenUtil().setWidth(24) ,right :ScreenUtil().setWidth(24) , bottom :ScreenUtil().setHeight(40)),
           child: Container(
             width: screenSize.width - ScreenUtil().setWidth(108),
             child: Text(I18n.of(context).homePageNotice,style :TextStyle(fontSize : 12 ,color: Color.fromARGB(255, 153, 153, 153))),
           ),
         ),
    ));
  }
}