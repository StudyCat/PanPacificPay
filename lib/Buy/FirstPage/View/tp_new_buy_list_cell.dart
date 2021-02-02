import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewBuyListCell extends StatefulWidget {
  TPNewBuyListCell({Key key,this.model,this.didClickBuyBtnCallBack}) : super(key: key);

    final TPBuyListInfoModel model;

    final Function didClickBuyBtnCallBack;

  @override
  _TPNewBuyListCellState createState() => _TPNewBuyListCellState();
}

class _TPNewBuyListCellState extends State<TPNewBuyListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(30)),
       child: Container(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(4))),
           color: Colors.white
         ),
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            _getUserInfoWidget(),
            _getInfoTextWidget('数量', widget.model.currentCount + 'TP'),
            _getBottomWidget()
           ],
         ),
       ),
    );
  }

  Widget _getUserInfoWidget(){
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
          child: Container(
            height : ScreenUtil().setHeight(80),
            width: ScreenUtil().setHeight(80),
            child: CachedNetworkImage(imageUrl: widget.model.avatar,fit: BoxFit.fitWidth,),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : [
            Text(widget.model.nickName,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28),fontWeight: FontWeight.bold),),
            Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(240),
              child: Row(
                children: <Widget>[
                  Text('地址：',style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),),
                  Expanded(child: Text(widget.model.sellerWalletAddress,style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),maxLines: 1,overflow: TextOverflow.ellipsis,softWrap:true,),)
                ],
              )
            )
          ]
        ),
        )
      ],
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
               child:   Container(
            height : ScreenUtil().setHeight(40),
            width :  ScreenUtil().setHeight(40),
            child: CachedNetworkImage(imageUrl: widget.model.payMethodVO.payIcon,fit : BoxFit.cover,width: ScreenUtil().setHeight(40),height: ScreenUtil().setHeight(40),),
          )
             )
            ]
          ),
          Container(
            width : ScreenUtil().setWidth(132),
            height : ScreenUtil().setHeight(60),
            child: CupertinoButton(
                                color: Color.fromARGB(255, 1, 141, 248),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
                                padding: EdgeInsets.zero,
                                child: Text('购买',style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
                                onPressed: (){
                                  widget.didClickBuyBtnCallBack();
                                },
                              ),
          )
        ],
      ),
    );
  }

}