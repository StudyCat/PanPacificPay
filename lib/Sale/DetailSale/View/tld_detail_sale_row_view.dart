import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPDetailSaleRowView extends StatefulWidget {
  TPDetailSaleRowView({Key key,this.isShowIcon,this.title,this.content,this.payIcon}) : super(key: key);
  
  final bool isShowIcon;
  final String title;
  final String content;
  final String payIcon;
  @override
  _TPDetailSaleRowViewState createState() => _TPDetailSaleRowViewState();
}

class _TPDetailSaleRowViewState extends State<TPDetailSaleRowView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : <Widget>[
          Text(widget.title,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
          widget.isShowIcon ?  _getIcon() : Text(widget.content,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)))
        ],
      ), 
      );
  }

  Widget _getIcon(){
    if (widget.payIcon.length > 0){
      return CachedNetworkImage(imageUrl: widget.payIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),);
    }else{
      return Container();
    }
  }

}