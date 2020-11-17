import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPPurseFirstPageBottomCell extends StatefulWidget {
  TPPurseFirstPageBottomCell({Key key}) : super(key: key);

  @override
  _TPPurseFirstPageBottomCellState createState() => _TPPurseFirstPageBottomCellState();
}

class _TPPurseFirstPageBottomCellState extends State<TPPurseFirstPageBottomCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child :Container(
           color: Colors.white,
           padding: EdgeInsets.only(top : 13 ,left :12 ,right :12 , bottom :20),
           width: screenSize.width - 34,
           child: Text(I18n.of(context).homePageNotice,style :TextStyle(fontSize : 12 ,color: Color.fromARGB(255, 153, 153, 153))),
         ),
       ),
    );
  }
}