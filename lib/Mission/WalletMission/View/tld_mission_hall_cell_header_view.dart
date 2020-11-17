import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_button.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPMissionHallCellHeaderView extends StatefulWidget {
  TPMissionHallCellHeaderView({Key key,this.didClickBuyBtnCallBack,this.infoModel}) : super(key: key);

  final Function didClickBuyBtnCallBack;

  final TPMissionBuyInfoModel infoModel;

  @override
  _TPMissionHallCellHeaderViewState createState() => _TPMissionHallCellHeaderViewState();
}

class _TPMissionHallCellHeaderViewState extends State<TPMissionHallCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
             children : <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : 10),
                     width: size.width - 128,
                     height: ScreenUtil().setHeight(30),
                     child: Text('编号：' +  widget.infoModel.taskBuyNo,style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.fade,textAlign: TextAlign.start,softWrap: false,),
                   ),
                   Offstage(
                     offstage : false,
                     child : picAndTextButton('购买', widget.didClickBuyBtnCallBack)
                   )
                 ],
               ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     getBuyInfoLabel('等级','L' + '${widget.infoModel.taskLevel}'),
                     getBuyInfoLabel('总量', widget.infoModel.totalCount + 'TP'),
                     getBuyInfoLabel('购买额度', widget.infoModel.quote +'TP'),
                     getBuyInfoLabel('剩余', widget.infoModel.currentCount + 'TP'),
                   ],
                 ),)]
             );
  }
}