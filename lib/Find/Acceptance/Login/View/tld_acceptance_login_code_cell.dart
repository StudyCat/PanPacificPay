import 'dart:async';

import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPAcceptanceLoginCodeCell extends StatefulWidget {
  TPAcceptanceLoginCodeCell(
      {Key key,
      this.title,
      this.placeholder,
      this.didClickSendCodeBtnCallBack,
      this.cellPhone,
      this.telCodeDidChangeCallBack,
      this.walletAddress})
      : super(key: key);

  final String title;

  final String placeholder;

  final Function didClickSendCodeBtnCallBack;

  final ValueNotifier<String> cellPhone;

  final Function(String) telCodeDidChangeCallBack;

  final String walletAddress;

  @override
  _TPAcceptanceLoginCodeCellState createState() =>
      _TPAcceptanceLoginCodeCellState();
}

class _TPAcceptanceLoginCodeCellState
    extends State<TPAcceptanceLoginCodeCell> {
  TextEditingController _controller;

  Timer _timer;

  int _countdownTime = 0;

  bool _enabel = true;

  String _cellPhoneNum = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();

    widget.cellPhone.addListener(() {
      _cellPhoneNum = widget.cellPhone.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: CupertinoTextField(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(20),
                      bottom: ScreenUtil().setHeight(20)),
                  controller: _controller,
                  placeholder: widget.placeholder,
                  textAlign: TextAlign.right,
                  onChanged: (String text) {
                    widget.telCodeDidChangeCallBack(text);
                  },
                  placeholderStyle: TextStyle(
                      color: Color.fromARGB(255, 153, 153, 153),
                      fontSize: ScreenUtil().setSp(24)),
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: ScreenUtil().setSp(24)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: 0,
                    top: 0,
                    bottom: 0),
                child: Container(
                    width: ScreenUtil().setWidth(176),
                    child: CupertinoButton(
                        child: Text(
                            _countdownTime > 0 ? '${_countdownTime}s'  : I18n.of(context).sentVerifyCode,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.white)),
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        onPressed: () {
                          if (_enabel) {
                            if (widget.walletAddress.length == 0) {
                              Fluttertoast.showToast(msg: '请先选择钱包');
                            }else{
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
                          }
                        })),
              )
            ]),
      ),
    );
  }

  bool _isCellPhoneNum() {
    if (_cellPhoneNum == null) {
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
  }
}
