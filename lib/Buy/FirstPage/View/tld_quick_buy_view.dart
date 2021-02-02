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
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(bottomLeft : Radius.circular(8),bottomRight: Radius.circular(8))),
          width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(50),
              right: ScreenUtil().setWidth(50),
              top: ScreenUtil().setHeight(34),
              bottom: ScreenUtil().setHeight(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(context).quickToBuy,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
                child: _getInputView(),
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
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
        child: Container(
            color: Color.fromARGB(255, 242, 242, 242),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _getTextField(),
                 Container(
            width : ScreenUtil().setWidth(180),
            height : ScreenUtil().setHeight(80),
            child: CupertinoButton(
                                color: Color.fromARGB(255, 146, 207, 243),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                                padding: EdgeInsets.zero,
                                child: Text('购买',style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
                                onPressed: (){
                                  widget.didClickDonehBtnCallBack();
                                },
                              ),
          )
              ],
            )
            ),
      ),
    );
  }

  Widget _getTextField(){
    return  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(440),
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
                          fontSize: 18),
                    ),
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51), fontSize: 18),
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
            );
  }
}
