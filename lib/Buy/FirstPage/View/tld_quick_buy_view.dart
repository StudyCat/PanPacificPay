import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPQuickBuyView extends StatefulWidget {
  TPQuickBuyView(
      {Key key,
      this.focusNode,
      this.textDidChange,
      this.didClickDonehBtnCallBack})
      : super(key: key);

  final FocusNode focusNode;

  final Function(String) textDidChange;

  final Function didClickDonehBtnCallBack;

  @override
  _TPQuickBuyViewState createState() => _TPQuickBuyViewState();
}

class _TPQuickBuyViewState extends State<TPQuickBuyView> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(context).quickToBuy,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
                child: _getInputView(),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                child: Container(
                    height: ScreenUtil().setHeight(80),
                    width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4)),
                      color: Color.fromARGB(255, 126, 211, 33),
                      child: Text(
                        I18n.of(context).buyBtnTitle,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: Colors.white),
                      ),
                      onPressed: () {
                        widget.didClickDonehBtnCallBack();
                      },
                    )),
              )
            ],
          ),
        ),
      );
  }

  Widget _getInputView() {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(80),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            color: Color.fromARGB(255, 242, 242, 242),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(280),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    focusNode: widget.focusNode,
                    inputFormatters: [TPAmountTextInputFormatter()],
                    textInputAction: TextInputAction.done,
                    onChanged: (text) => widget.textDidChange(text),
                    onSubmitted: (str) => widget.didClickDonehBtnCallBack(),
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
                  child: Text(
                    'TP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
