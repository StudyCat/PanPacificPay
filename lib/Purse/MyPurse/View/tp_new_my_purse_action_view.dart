import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewMyPurseActionView extends StatefulWidget {
  TPNewMyPurseActionView({Key key,this.imageAssest,this.title}) : super(key: key);

  final String imageAssest;

  final String title;

  @override
  _TPNewMyPurseActionViewState createState() => _TPNewMyPurseActionViewState();
}

class _TPNewMyPurseActionViewState extends State<TPNewMyPurseActionView> {
 @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children : <Widget>[
        _getImageWidget(),
         Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(5)),
            child: Text(widget.title,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.bold),textAlign: TextAlign.center,maxLines: 2,),
        ),
      ]
    );
  }

  Widget _getImageWidget(){
      return Image.asset(widget.imageAssest,width:ScreenUtil().setHeight(96),height:ScreenUtil().setHeight(96),fit: BoxFit.fill,);
  }
}