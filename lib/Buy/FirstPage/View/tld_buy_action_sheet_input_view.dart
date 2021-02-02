import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class TPBuyActionSheetInputView extends StatefulWidget {
  TPBuyActionSheetInputView({Key key,this.max,this.inputStringCallBack,this.currentAmount,this.focusNode,this.maxAmount}) : super(key: key);

  final String max;

  final String maxAmount;

  final String currentAmount;

  final Function(String) inputStringCallBack;

  final FocusNode focusNode;

  @override
  _TPBuyActionSheetInputViewState createState() =>
      _TPBuyActionSheetInputViewState();
}

class _TPBuyActionSheetInputViewState
    extends State<TPBuyActionSheetInputView> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    _controller.addListener(() {
       String text = _controller.text;
        String result;
        setState(() {
          if(text.length == 0){
            result = '0';
          }else{
             if(double.parse(text) > double.parse(widget.maxAmount)){
                widget.focusNode.unfocus();
                _controller.text = widget.maxAmount;
                result = widget.maxAmount;
              }else {
                result = text;
              }
          }
      });
      widget.inputStringCallBack(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color.fromARGB(255, 242, 242, 242),
      ),
      child: _getBodyContent(context),
    );
  }

  Widget _getBodyContent(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Container(
          width: screenSize.width - ScreenUtil().setWidth(300),
          alignment: Alignment.topCenter,
          child: _getTextField(),
        ),
        Container(
          padding : EdgeInsets.only(left : 5),
          child: Text('TP',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor, decoration: TextDecoration.none,fontWeight: FontWeight.w400,)),
        ),
        Container(
            height: ScreenUtil().setHeight(40),
            child: VerticalDivider(color: Color.fromARGB(255, 187, 187, 187))),
        Container(
          padding: EdgeInsets.only(left: 5),
          width: ScreenUtil().setWidth(130),
          height: ScreenUtil().setHeight(60),
          child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Text(
                I18n.of(context).buyAllBtnTitle,
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor,),
              ),
              onPressed: () {
                widget.focusNode.unfocus();
                String allAmount = '0';
                if (double.parse(widget.currentAmount) > double.parse(widget.maxAmount)) {
                  allAmount = widget.maxAmount;
                }else{
                  allAmount = widget.currentAmount;
                }
                _controller.text = allAmount;
                widget.inputStringCallBack(allAmount);
              }),
        ),
      ],
    );
  }

  Widget _getTextField() {
    return CupertinoTextField(
      style: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Color.fromARGB(255, 51, 51, 51)),
      decoration:
          BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(20)),
      placeholder: I18n.of(context).inputBuyAmountFieldPlaceholder,
      focusNode:widget.focusNode,
      placeholderStyle: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Color.fromARGB(255, 153, 153, 153),height: 1.1),
      inputFormatters: [
          TPAmountTextInputFormatter()
      ],
      controller: _controller,
    );
  }
  
}
