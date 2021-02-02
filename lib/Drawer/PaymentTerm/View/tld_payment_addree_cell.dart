
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TPPaymentAddressCell extends StatefulWidget {
  TPPaymentAddressCell({Key key,this.title,this.textChangedCallBack,this.placeholder,this.content}) : super(key: key);
  final String title;
  final String content;
  final Function textChangedCallBack;
  final String placeholder;
  @override
  _TPPaymentAddressCellState createState() => _TPPaymentAddressCellState();
}

class _TPPaymentAddressCellState extends State<TPPaymentAddressCell> {

  TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _editingController = TextEditingController();
    _editingController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(300),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), top: ScreenUtil().setHeight(24)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              _getColumnBottomWidget()
            ]),
      ),
    );
  }

  Widget _getColumnBottomWidget(){
    // if (widget.image == null) {
      return Container(
                padding: EdgeInsets.only(left : 0 ,top: ScreenUtil().setHeight(40)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                height: ScreenUtil().setHeight(200),
                child: CupertinoTextField(
                  padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right:  ScreenUtil().setWidth(20)),
                  textAlign: TextAlign.left,
                  onChanged: (text) => widget.textChangedCallBack(text),
                  placeholder: widget.placeholder,
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
                  placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 153, 153, 153),),
                  maxLines: null,
                  controller: _editingController,
                )
              );
  }


}