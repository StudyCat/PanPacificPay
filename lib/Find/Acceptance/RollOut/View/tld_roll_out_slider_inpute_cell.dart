import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/flutter_xlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPRollOutSliderInputeCell extends StatefulWidget {
  TPRollOutSliderInputeCell({Key key,this.title,this.maxValue,this.inputCallBack,this.focusNode,this.minValue}) : super(key: key);

  final String title;
  final String maxValue;
  final String minValue;
  final Function(String) inputCallBack;
  final FocusNode focusNode;

  @override
  _TPRollOutSliderInputeCellState createState() => _TPRollOutSliderInputeCellState();
}

class _TPRollOutSliderInputeCellState extends State<TPRollOutSliderInputeCell> {
  String _value;

  TextEditingController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.minValue;

    _controller = TextEditingController(text: _value);
    _controller.addListener(() {
      String text = _controller.text;
      setState(() {
          if(text.length == 0){
            _value = widget.minValue;
          }else{
             if(double.parse(text) > double.parse(widget.maxValue)){
               widget.focusNode.unfocus();
              _controller.text = widget.maxValue;
              _value = widget.maxValue;
            }else if (double.parse(text) < double.parse(widget.minValue)){
              widget.focusNode.unfocus();
              _controller.text = widget.minValue;
              _value = widget.minValue;
            }else{
              _value = text;
            }
          }
      });
      widget.inputCallBack(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
 Size screenSize = MediaQuery.of(context).size;
    return Padding(padding:EdgeInsets.only(left: 15, top: 1, right: 15),
    child:Container(
      width: screenSize.width - 30,
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius : BorderRadius.all(Radius.circular(4))
      ),
      padding: EdgeInsets.only(left: 10, top: 1, right: 10),
      child: Column(
              children: <Widget>[
                getCellTopView(),
                getSliderView()
              ],
            ),
          ),
    );
  }

  Widget getCellTopView(){
    return  Container(
      padding : EdgeInsets.only(top : ScreenUtil().setWidth(20)),
      child : Row(
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
                getTextField()
              ],
            )
    );
  }

  Widget getTextField(){
    return Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
        border : Border.all(color : Color.fromARGB(255, 153, 153, 153),width : ScreenUtil().setWidth(2)),
        borderRadius : BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(400),
      height: ScreenUtil().setWidth(48),
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(15)),
      child: CupertinoTextField(
      enabled:!(widget.maxValue == null || double.parse(widget.maxValue) == 0.0),
      decoration: BoxDecoration(
        border : Border.all(width : 1,color: Color.fromARGB(0, 255, 255, 255)),
      ),
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24),textBaseline: TextBaseline.alphabetic),
      controller: _controller,
      focusNode: widget.focusNode,
      inputFormatters: [
        TPAmountTextInputFormatter()
      ],
    )),
    Padding(padding: EdgeInsets.only(right : ScreenUtil().setWidth(10),)
    ,child: Text('TP',style:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24))),),
      ],
    )
      );
  }

  Widget getSliderView(){
    bool disabled = (widget.maxValue == null || double.parse(widget.maxValue) == 0.0);

    return Container(
      padding : EdgeInsets.only(right : ScreenUtil().setWidth(20),left : ScreenUtil().setWidth(20),top : ScreenUtil().setWidth(8)),
      child :FlutterSlider(
              values: [double.parse(_value)],
              min: widget.minValue == null ? 0 : double.parse(widget.minValue),
              disabled: disabled,
              max: (widget.maxValue == null || double.parse(widget.maxValue) == 0.0)? 100 : double.parse(widget.maxValue),
              handlerHeight: ScreenUtil().setHeight(40),
              handlerWidth: ScreenUtil().setHeight(40),
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: ScreenUtil().setHeight(40),
                activeTrackBarHeight: ScreenUtil().setHeight(40),
                inactiveTrackBar: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor
                ),
                activeTrackBar: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Theme.of(context).hintColor
                ),
                ),
              handler: FlutterSliderHandler(
                child : Container(
                  decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Theme.of(context).hintColor
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                if(widget.maxValue != null){
                  setState(() {
                  widget.focusNode.unfocus();
                  _value = lowerValue.toString();
                  _controller.text = _value;
                });
                }else{
                  widget.focusNode.unfocus();
                  setState(() {
                    _value = '0';
                  });
                }
                widget.inputCallBack(_value);    
              },
            ),
    );
  }
}