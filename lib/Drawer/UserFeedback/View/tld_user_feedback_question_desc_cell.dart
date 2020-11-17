import 'package:dragon_sword_purse/Message/Model/tld_just_notice_vote_model_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPUserFeedbackQuestionDescCell extends StatefulWidget {
  TPUserFeedbackQuestionDescCell({Key key,this.title,this.placeholder,this.stringDidChangeCallBack,this.appealModel}) : super(key: key);

  final String title;

  final String placeholder;

  final Function(String) stringDidChangeCallBack;

  final TPOrderAppealModel appealModel;

  @override
  _TPUserFeedbackQuestionDescCellState createState() => _TPUserFeedbackQuestionDescCellState();
}

class _TPUserFeedbackQuestionDescCellState extends State<TPUserFeedbackQuestionDescCell> {
 TextEditingController _controller;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.appealModel != null) {
      _controller = TextEditingController(text: widget.appealModel.appealDesc);
    }else{
      _controller = TextEditingController();
    }
    _controller.addListener(() {
      widget.stringDidChangeCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(260),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
                child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
                height: ScreenUtil().setHeight(180),
                child: CupertinoTextField(
                  controller: _controller,
                  padding: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                  maxLines: null,
                  enabled: widget.appealModel == null,
                  placeholder: widget.placeholder,
                  placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(24),color :Color.fromARGB(255, 153, 153, 153)),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),
                ),
              )
            ]),
      ),
    );
  }
}