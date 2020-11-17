import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class TPExchangeInputCell extends StatefulWidget {
  final String title;

  final TPWalletInfoModel infoModel;

  final Function(String) inputCallBack;

  final FocusNode focusNode;

  final double top;

  TPExchangeInputCell({Key key, this.title,this.infoModel,this.inputCallBack,this.focusNode,this.top = 20}) : super(key: key);

  @override
  _TPExchangeInputCellState createState() => _TPExchangeInputCellState();
}

class _TPExchangeInputCellState extends State<TPExchangeInputCell> {

  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController(text: '0');
    _controller.addListener(() {
      String text = _controller.text;
      String result;
      setState(() {
          if(text.length == 0){
            result = '0';
          }else{
             if(double.parse(text) > double.parse(widget.infoModel.value)){
               widget.focusNode.unfocus();
              _controller.text = widget.infoModel.value;
              result = widget.infoModel.value;
            }else{
              result = text;
            }
          }
      });
      widget.inputCallBack(result);
    });
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15, top: widget.top, right: 15),
      width: screenSize.width - 30,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(88),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                  ),
                  child: Text(widget.title,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromARGB(255, 51, 51, 51))),
                ),
                getRightWidget()
              ],
            ),
          )),
    );
  }

  Widget getRightWidget() {
    return Stack(
      alignment : FractionalOffset(0.8,0.6),
      children: <Widget>[
        Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setWidth(48),
      padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
      child: CupertinoTextField(
      enabled: widget.infoModel == null ? false : true,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24),textBaseline: TextBaseline.alphabetic),
      controller: _controller,
      focusNode: widget.focusNode,
      inputFormatters: [
        TPAmountTextInputFormatter()
      ],
    )),
    Text('TP',style:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24)))
      ],
    );
  }
}
