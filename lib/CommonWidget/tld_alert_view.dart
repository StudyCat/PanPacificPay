import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TPAlertViewType{
  normal,
  input,
}


class TPAlertView extends StatefulWidget {
  TPAlertView({Key key,this.title,this.type,this.alertString,this.didClickSureBtn,this.textEditingCallBack,this.isNeedSecretShow = false,this.placeHolder = '限20字以内',this.sureTitle}) : super(key: key);
  final String alertString;
  final String title;
  final TPAlertViewType type;
  final Function didClickSureBtn;
  final ValueChanged<String> textEditingCallBack;
  final bool isNeedSecretShow;
  final String placeHolder;
  final String sureTitle;
  @override
  _TPAlertViewState createState() => _TPAlertViewState();
}

class _TPAlertViewState extends State<TPAlertView> {

  TextEditingController _controller;

  String _sureTitle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.sureTitle == null){
      _sureTitle = I18n.of(navigatorKey.currentContext).sureBtnTitle;
    }else{
      _sureTitle = widget.sureTitle;
    }

    _controller = TextEditingController();
    _controller.addListener((){
      widget.textEditingCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28))),
      content: getContetnView(context),
      actions: <Widget>[
        CupertinoDialogAction(child: Text(I18n.of(context).cancel,style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 102, 102, 102))), onPressed: (){
          Navigator.of(context).pop();
        }),
        CupertinoDialogAction(child: Text(_sureTitle,style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Theme.of(context).primaryColor)), onPressed: (){
          Navigator.of(context).pop();
          widget.didClickSureBtn();
        }),
      ],
    );
  }

  Widget getContetnView(BuildContext context){
    if (widget.type == TPAlertViewType.input){
      return Container(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
          borderRadius : BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20) , right: ScreenUtil().setWidth((20))),
        child: CupertinoTextField(
          controller: _controller,
          obscureText: widget.isNeedSecretShow,
          placeholder: widget.placeHolder,
          decoration: BoxDecoration(
            color : Color.fromARGB(255, 242, 242, 242),
          ),
          placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 153, 153, 153)),
        ),
      );
    }else{
      return Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
        child: Text(widget.alertString),
      );
    }
  }
}