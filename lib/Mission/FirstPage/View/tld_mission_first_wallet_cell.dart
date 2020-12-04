import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionFirstWalletCell extends StatefulWidget {
  TPMissionFirstWalletCell({Key key,this.didClickItemCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  @override
  _TPMissionFirstWalletCellState createState() => _TPMissionFirstWalletCellState();
}

class _TPMissionFirstWalletCellState extends State<TPMissionFirstWalletCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : widget.didClickItemCallBack,
      child : Padding(
       padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(10)),
       child: Container(
         decoration : BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
         child : Row(
             mainAxisAlignment : MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding : EdgeInsets.only(top : ScreenUtil().setHeight(30),left: ScreenUtil().setWidth(20)),
                 child: Image.asset('assetss/images/home_purse_icon.png',width: ScreenUtil().setWidth(72),
                 height: ScreenUtil().setWidth(72),),
               ), 
               Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _getWalletNameRowView(),
                      Padding(
                        padding: EdgeInsets.only(top : ScreenUtil().setWidth(16),right: ScreenUtil().setWidth(20),left: ScreenUtil().setWidth(20)),
                        child: Text('423.324 344 34TP',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(36)),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top : ScreenUtil().setWidth(8),right: ScreenUtil().setWidth(20),left: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                        child: Text('= 423.32USD',style: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: 12),),
                      )
                    ],
                  ),
             ],
           ),
       ),
    )
    );
  }

  Widget _getWalletNameRowView(){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top:ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(20)),
      child: Container(
        width : size.width - ScreenUtil().setWidth(220),
        child : Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('我的钱包01',style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
          Padding(
            padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
            child: RichText(text: TextSpan(children:<InlineSpan>[
            WidgetSpan(child: CachedNetworkImage(imageUrl: 'http://oss.thyc.com/2020/06/29/f4aacae548004e68b373e1e4b7d01ebe.png',width: ScreenUtil().setWidth(24),height: ScreenUtil().setWidth(24),),),
            TextSpan(text :'(20/200)',style:TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51)))
          ])),
          )
        ],
      )
      ),
    );
  }

}