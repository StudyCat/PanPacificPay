import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPExportKeyAddressView extends StatefulWidget {
  TPExportKeyAddressView({Key key,this.address,this.privateKey}) : super(key: key);

  final String address;

  final String privateKey;

  @override
  _TPExportKeyAddressViewState createState() => _TPExportKeyAddressViewState();
}

class _TPExportKeyAddressViewState extends State<TPExportKeyAddressView> {
  @override
  Widget build(BuildContext context) {
    return getCopyAdressView(context);
  }

   Widget getCopyAdressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white
      ),
      child: GestureDetector(
        onTap:(){
           Clipboard.setData(ClipboardData(text : widget.address == null ? widget.privateKey : widget.address));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
        },
        child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(190),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: Text(
              widget.address == null ? widget.privateKey : widget.address,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(50),
                bottom: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setWidth(32),
            width: ScreenUtil().setWidth(32),
            child: IconButton(
                icon: Icon(
                  IconData(0xe601, fontFamily: 'appIconFonts'),
                  size: ScreenUtil().setWidth(32),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text : widget.address == null ? widget.privateKey : widget.address));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                }),
          ),

        ],
      )
      ),
    );
  }
}