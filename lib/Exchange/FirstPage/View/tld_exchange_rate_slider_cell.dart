import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/flutter_xlider.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TPExchangeRateSliderCell extends StatefulWidget {
  TPExchangeRateSliderCell({Key key,this.title,this.didChangeRateCallBack,this.infoModel,this.borderRadius}) : super(key: key);

  final String title;

  final TPWalletInfoModel infoModel;

  final Function(String) didChangeRateCallBack;

  final double borderRadius;

  @override
  _TPExchangeRateSliderCellState createState() => _TPExchangeRateSliderCellState();
}

class _TPExchangeRateSliderCellState extends State<TPExchangeRateSliderCell> {
  String _value = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.infoModel != null){

    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15, top: 1, right: 15),
      width: screenSize.width - 30,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius == null ? 4 : widget.borderRadius)),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                getCellTopView(),
                getSliderView()
              ],
            ),
          )),
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
                getText()
              ],
            )
    );
  }

  Widget getText(){
    double value;
    if (widget.infoModel != null) {
      double min = double.parse(widget.infoModel.minRate) * 100;
      value = (double.parse(_value) / 10 + min);
    }else{
      value = 0;
    }
    String rate =  (NumUtil.getNumByValueDouble(value, 1)).toStringAsFixed(1);
    return Padding(
      padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
      child: Text(rate+'%',style:TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))),
    );
  }

  Widget getSliderView(){
    double min = widget.infoModel != null ? double.parse(widget.infoModel.minRate) * 1000 : 0;
    double max = widget.infoModel != null ? double.parse(widget.infoModel.maxRate) * 1000 : 100;
    bool disabled = widget.infoModel == null;
    return Container(
      padding : EdgeInsets.only(right : ScreenUtil().setWidth(20),left : ScreenUtil().setWidth(20),top : ScreenUtil().setWidth(8)),
      child :FlutterSlider(
              values: [double.parse(_value)],
              min: 0,
              disabled: disabled,
              max: max - min,
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
                  if (widget.infoModel != null) {
                     setState(() {
                      _value = lowerValue.toString();
                    }); 
                  widget.didChangeRateCallBack(((lowerValue + min) / 1000).toString());
                  }
              },
            ),
    );
  }
}