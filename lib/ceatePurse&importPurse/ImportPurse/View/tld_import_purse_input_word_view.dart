import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_import_purse_input_word_textfield.dart';
import '../../../CommonWidget/dash_rect.dart';

class TPImportPurseInputWordView extends StatefulWidget {
  TPImportPurseInputWordView({Key key,this.textFieldEditingWithIndexCallBack}) : super(key: key);

  final Function(String value,int index) textFieldEditingWithIndexCallBack;

  @override
  _TPImportPurseInputWordViewState createState() => _TPImportPurseInputWordViewState();
}

class _TPImportPurseInputWordViewState extends State<TPImportPurseInputWordView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top : ScreenUtil().setWidth(40)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
          child: Column(
            children: <Widget>[
              getColumnChildrenWidget(context, 0),
              Container(width : size.width - ScreenUtil().setWidth(100),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
              getColumnChildrenWidget(context, 1),
              Container(width : size.width - ScreenUtil().setWidth(100),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
               getColumnChildrenWidget(context, 2),
            ],
          )
        ), 
      ),
    );
  }

    Widget getColumnChildrenWidget(BuildContext context,int columnIndex){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        getRowChildrenWidget(context, 0, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 1, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 2, columnIndex),
        Container(height : ScreenUtil().setHeight(70),child : DashedRect(color: Color.fromARGB(255, 151, 151, 151),)),
        getRowChildrenWidget(context, 3, columnIndex),
      ],
    );
  }

  Widget getRowChildrenWidget(BuildContext context,int rowIndex,int columnIndex){
    Size size = MediaQuery.of(context).size;
    int index = columnIndex * 4 + rowIndex;
    return Container(
      padding: EdgeInsets.all(0),
      width: (size.width - ScreenUtil().setWidth(110)) / 4.0,
      height: ScreenUtil().setHeight(70),
      child: Center(
        child : TPImportPurseInputWordTextField(textFieldEditingCallBack: (String text){
          widget.textFieldEditingWithIndexCallBack(text,index);
        },)
        )
      );
  }
}