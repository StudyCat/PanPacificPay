
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TPWechatAlipayChoiceQRCodeView extends StatefulWidget {
  TPWechatAlipayChoiceQRCodeView({Key key,this.title,this.didClickBtnCallBack,this.imageUrl}) : super(key: key);
  final String title;
  final Function didClickBtnCallBack;
  final String imageUrl;
  @override
  _TPWechatAlipayChoiceQRCodeViewState createState() => _TPWechatAlipayChoiceQRCodeViewState();
}

class _TPWechatAlipayChoiceQRCodeViewState extends State<TPWechatAlipayChoiceQRCodeView> {
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
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(200),
                child: CupertinoButton(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.all(Radius.circular(4)),
                      color : Color.fromARGB(255, 242, 242, 242),
                    ),
                    child: Center(
                      child : _getImage()
                    ),
                  ), 
                  onPressed: (){
                    widget.didClickBtnCallBack();
                  }),
              );
    // }else{
    //   return Container(
    //             padding: EdgeInsets.only(left : 0 ,top: ScreenUtil().setHeight(40)),
    //             width: ScreenUtil().setWidth(200),
    //             height: ScreenUtil().setHeight(200),
    //             child: CupertinoButton(
    //               padding: EdgeInsets.all(0),
    //               child: Container(
    //                 child: Center(
    //                   child : Image.file(widget.image,width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,),
    //                 ),
    //               ), 
    //               onPressed: (){
    //                 widget.didClickBtnCallBack();
    //               }),
    //           );
    // }
  }

  Widget _getImage(){
    if ( widget.imageUrl.length == 0){
      return Icon(IconData(0xe623,fontFamily :'appIconFonts'),size: ScreenUtil().setWidth(60),color: Color.fromARGB(255, 153, 153, 153),);
    }else{
      return QrImage(
        data: widget.imageUrl,
      );
    }
  }

}