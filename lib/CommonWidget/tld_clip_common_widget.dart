import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getClipRectCommon(BuildContext context,Widget child,double top){
  Size screenSize = MediaQuery.of(context).size;
  return Container(
       padding: EdgeInsets.only(left : 15 , top : 15 ,right: 15),
       width: screenSize.width - 30,
       height: 60,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           width: screenSize.width - 30,
           padding: EdgeInsets.only(top : 10,bottom : 17),
           child: child,
         ),
       ),
    );
}