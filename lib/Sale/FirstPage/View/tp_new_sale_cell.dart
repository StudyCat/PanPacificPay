import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewSaleCell extends StatefulWidget {
  TPNewSaleCell({Key key,this.model,this.didClickCancelCallBack,this.didClickItemCallBack}) : super(key: key);

  final TPSaleListInfoModel model;

  final Function didClickItemCallBack;

  final Function didClickCancelCallBack;

  @override
  _TPNewSaleCellState createState() => _TPNewSaleCellState();
}

class _TPNewSaleCellState extends State<TPNewSaleCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: GestureDetector(
        onTap : () => widget.didClickItemCallBack(),
        child : Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(40),
                  top: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setHeight(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getInfoTextWidget('订单号', widget.model.sellNo),
                  _getPaymentTypeWidget(),
                  _getInfoTextWidget('数量', widget.model.currentCount),
                  _getBottomWidget()
                ],
              )))
      ),
    );
  }

  Widget _getPaymentTypeWidget(){
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('收款方式',style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),),
          Container(
            height : ScreenUtil().setSp(28),
            width :  ScreenUtil().setSp(28),
            child: CachedNetworkImage(imageUrl: widget.model.payMethodVO.payIcon,fit : BoxFit.fill),
          )
        ],
      ),
    );
  }

  Widget _getInfoTextWidget(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
      child: Text(title + '：' + content,style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),),
    );
  }

  Widget _getBottomWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Text('限额' + '：' + widget.model.max + '~' + widget.model.maxAmount + 'TP',style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),),
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(6)),
               child:  Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.model.createTime), [yyyy,'.',mm,'.',dd]),style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),),
             )
            ]
          ),
          Container(
            width : ScreenUtil().setWidth(160),
            height : ScreenUtil().setHeight(60),
            child: CupertinoButton(
                                color: Color.fromARGB(255, 1, 141, 248),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
                                padding: EdgeInsets.zero,
                                child: Text('取消挂售',style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
                                onPressed: (){
                                  widget.didClickCancelCallBack();
                                },
                              ),
          )
        ],
      ),
    );
  }
}
