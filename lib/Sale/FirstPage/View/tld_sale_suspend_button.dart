import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPSaleSuspendButton extends StatefulWidget {
  TPSaleSuspendButton({Key key, this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TPSaleSuspendButtonState createState() => _TPSaleSuspendButtonState();
}

class _TPSaleSuspendButtonState extends State<TPSaleSuspendButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.didClickCallBack();
        },
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 152, 152, 152),
                  offset: Offset(0.0, 12.0),
                  blurRadius: 15),
            ],
          ),
          child: Image.asset(
            'assetss/images/sale_button.png',
            width: ScreenUtil().setHeight(80),
            height: ScreenUtil().setHeight(80),
            fit: BoxFit.cover,
          ),
        ));
  }
}
