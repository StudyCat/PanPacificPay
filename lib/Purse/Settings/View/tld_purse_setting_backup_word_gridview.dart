import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class STDPurseSettingBackupWordGridView extends StatefulWidget {
  STDPurseSettingBackupWordGridView({Key key,this.words}) : super(key: key);

  final List words;

  @override
  _STDPurseSettingBackupWordGridViewState createState() => _STDPurseSettingBackupWordGridViewState();
}

class _STDPurseSettingBackupWordGridViewState extends State<STDPurseSettingBackupWordGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child : ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          padding : EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(30)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 3),
            itemCount: 12, 
            itemBuilder: (context,index) => getItem(widget.words[index])),
        ), 
      )
      );
  }

  Widget getItem(String word){
    return Center(
      child : Text(word,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),)
    );
  }
}