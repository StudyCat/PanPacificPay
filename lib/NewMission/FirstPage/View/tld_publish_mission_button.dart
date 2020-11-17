import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPPublishMissionButton extends StatefulWidget {
  TPPublishMissionButton({Key key,this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TPPublishMissionButtonState createState() => _TPPublishMissionButtonState();
}

class _TPPublishMissionButtonState extends State<TPPublishMissionButton> {
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
            'assetss/images/mission_publish_icon.png',
            width: ScreenUtil().setHeight(80),
            height: ScreenUtil().setHeight(80),
            fit: BoxFit.cover,
          ),
        ));
  }
}