import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_list_do_mission_header_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PPMissionListDoMissionCell extends StatefulWidget {
  PPMissionListDoMissionCell({Key key,this.didClickBuyBtnCallBack,this.missionModel}) : super(key: key);

    final Function didClickBuyBtnCallBack;

    final TPMissionBuyModel missionModel;

  @override
  _PPMissionListDoMissionCellState createState() => _PPMissionListDoMissionCellState();
}

class _PPMissionListDoMissionCellState extends State<PPMissionListDoMissionCell> {
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
            Offstage(
              offstage: !widget.missionModel.showCurrentCount,
              child: _getInfoTextWidget('数量', widget.missionModel.currentCount + 'TP'),
            ),
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
            child: CachedNetworkImage(imageUrl: widget.missionModel.avatar,fit: BoxFit.fitWidth),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : [
            Text(widget.missionModel.nickName,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28),fontWeight: FontWeight.bold),),
            Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(240),
              child: Row(
                children: <Widget>[
                  Text('地址：',style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),),
                  Expanded(child: Text(widget.missionModel.sellerWalletAddress,style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(24)),maxLines: 1,overflow: TextOverflow.ellipsis,softWrap:true,),)
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
              Text('限额' + '：' + widget.missionModel.max + '~' + widget.missionModel.maxAmount + 'TP',style: TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),),
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(6)),
               child:   Container(
            height : ScreenUtil().setHeight(40),
            width :  ScreenUtil().setHeight(40),
            child: CachedNetworkImage(imageUrl: widget.missionModel.payMethodVO.payIcon,fit : BoxFit.cover),
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
