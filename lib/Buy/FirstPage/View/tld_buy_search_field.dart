import 'dart:async';

import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPBuySearchField extends StatefulWidget {
  TPBuySearchField(
      {Key key,
      this.textFieldDidChangeCallBack,
      this.didClickSearchBtnCallBack,this.focusNode})
      : super(key: key);

  final Function(String) textFieldDidChangeCallBack;

  final Function didClickSearchBtnCallBack;

  final FocusNode focusNode;
  @override
  _TPBuySearchFieldState createState() => _TPBuySearchFieldState();
}

class _TPBuySearchFieldState extends State<TPBuySearchField> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      widget.textFieldDidChangeCallBack(_textEditingController.text);
    });

  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width - 30,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width - ScreenUtil().setWidth(240),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: widget.focusNode,
                    inputFormatters: [TPAmountTextInputFormatter()],
                    textInputAction: TextInputAction.search,
                    onSubmitted:(str)=> widget.didClickSearchBtnCallBack(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: I18n.of(context).buySearchFieldPlaceholder,
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 153, 153, 153),
                          fontSize: 12),
                    ),
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51), fontSize: 12),
                  ),
                ),
                Container(
                    height: ScreenUtil().setHeight(40),
                    child: VerticalDivider(
                        color: Color.fromARGB(255, 187, 187, 187))),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(60),
                  child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        I18n.of(context).searchBtnTitle,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: widget.didClickSearchBtnCallBack),
                ),
              ],
            )),
      ),
    );
  }
}
