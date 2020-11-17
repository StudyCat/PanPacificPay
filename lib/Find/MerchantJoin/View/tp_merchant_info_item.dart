import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPMerchantInfoItem extends StatefulWidget {
  TPMerchantInfoItem({Key key, this.content}) : super(key: key);

  final String content;

  @override
  _TPMerchantInfoItemState createState() => _TPMerchantInfoItemState();
}

class _TPMerchantInfoItemState extends State<TPMerchantInfoItem> {
  @override
  Widget build(BuildContext context) {
    return getCopyAdressView(context);
  }

  Widget getCopyAdressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(20)),
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            top: ScreenUtil().setHeight(20),
            bottom: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(255, 243, 243, 243)),
        child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.content));
              Fluttertoast.showToast(
                  msg: '已复制到剪切板',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: size.width - ScreenUtil().setWidth(200),
                  child: Text(
                    widget.content,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: Color.fromARGB(255, 153, 153, 153)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(20)),
                  child: Container(
                    height: ScreenUtil().setWidth(32),
                    width: ScreenUtil().setWidth(32),
                    child: IconButton(
                        icon: Icon(
                          IconData(0xe601, fontFamily: 'appIconFonts'),
                          size: ScreenUtil().setWidth(32),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.content));
                          Fluttertoast.showToast(
                              msg: '已复制到剪切板',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1);
                        }),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
