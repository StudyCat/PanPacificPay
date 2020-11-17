import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPImportPurseInputWordTextField extends StatefulWidget {
  TPImportPurseInputWordTextField({Key key,this.textFieldEditingCallBack}) : super(key: key);
  final ValueChanged<String> textFieldEditingCallBack;

  @override
  _TPImportPurseInputWordTextFieldState createState() => _TPImportPurseInputWordTextFieldState();
}

class _TPImportPurseInputWordTextFieldState extends State<TPImportPurseInputWordTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.addListener((){
      widget.textFieldEditingCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          controller: _controller,
          style: TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28)),
          decoration: BoxDecoration(
            border : Border.all(
              color : Color.fromARGB(0, 0, 0, 0)
            )
          ),
          textAlign: TextAlign.center,
      );
  }
}