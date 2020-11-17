import 'dart:async';

import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPRegisterVerifyCodeCell extends StatefulWidget {
  TPRegisterVerifyCodeCell({Key key,this.didClickSendCodeBtnCallBack,this.codeDidChangeCallBack}) : super(key: key);

  final Function didClickSendCodeBtnCallBack;

  final Function codeDidChangeCallBack;

  @override
  _TPRegisterVerifyCodeCellState createState() => _TPRegisterVerifyCodeCellState();
}

class _TPRegisterVerifyCodeCellState extends State<TPRegisterVerifyCodeCell> {

  
  Timer _timer;

  int _countdownTime = 0;

  bool _enabel = true;

  String _cellPhoneNum = '';

  StreamSubscription _cellPhoneSusbscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cellPhoneSusbscription = eventBus.on<TPRegisterCellPhoneChangeEvent>().listen((event) {
        _cellPhoneNum = event.cellPhoneNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(110),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Column(
         children : <Widget>[
           _getInputTextFieldButtonRowWidget(),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child:  Divider(
              height: ScreenUtil().setHeight(2),
              color: Color.fromARGB(255, 221, 221, 221),
            ),
          )
         ]
       ),
    );
  }

  Widget _getInputTextFieldButtonRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children : <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(400),
          child:  CupertinoTextField(
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            padding: EdgeInsets.zero,
            style: TextStyle(fontSize : ScreenUtil().setSp(30),color : Color.fromARGB(255, 51, 51, 51)),
            placeholderStyle:  TextStyle(fontSize : ScreenUtil().setSp(30),color : Color.fromARGB(255, 153, 153, 153)),
            decoration : BoxDecoration(
              border: Border.all(color : Color.fromARGB(0, 0, 0, 0)),
            ),
            placeholder: I18n.of(context).pleaseEnterVerifyCode,
            onChanged: (str){
              widget.codeDidChangeCallBack(str);
            },
        ),
        ),
        Container(
          width : ScreenUtil().setWidth(300),
          child : CupertinoButton(
            child: Text(
              _countdownTime > 0 ? '${_countdownTime}s'  : I18n.of(context).getVerifyCode,
            style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Theme.of(context).hintColor),), 
            onPressed: (){
               if (_enabel) {
                            if (_cellPhoneNum.length == 11 &&
                                _isCellPhoneNum()) {
                              _enabel = false;
                              _countdownTime = 60;
                              widget.didClickSendCodeBtnCallBack();
                              if (_timer == null && _countdownTime > 0) {
                                _timer = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  timerFunction();
                                });
                              }
                            } else {
                              Fluttertoast.showToast(msg: '不是手机号码');
                            }
                        }
          })
        )
      ]
    );
  }

    bool _isCellPhoneNum() {
    if (_cellPhoneNum.length == 0) {
      return false;
    }
    return RegExp(
            r"^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$")
        .hasMatch(_cellPhoneNum);
  }

  void timerFunction() {
    if (_countdownTime == 0) {
      _timer.cancel();
      _timer = null;
      _enabel = true;
    }
    if (_countdownTime > 0) {
      if (mounted) {
        setState(() {
          _countdownTime--;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }

    _cellPhoneSusbscription.cancel();
    _cellPhoneSusbscription = null;
  }

}