import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_button.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PPMissionListDoMissionHeaderView extends StatefulWidget {
  PPMissionListDoMissionHeaderView({Key key,this.didClickBuyBtnCallBack,this.missionModel}) : super(key: key);

  final TPMissionBuyModel missionModel;

  final Function didClickBuyBtnCallBack;

  @override 
  _PPMissionListDoMissionHeaderViewState createState() => _PPMissionListDoMissionHeaderViewState();
}

class _PPMissionListDoMissionHeaderViewState extends State<PPMissionListDoMissionHeaderView> {
  @override
  Widget build(BuildContext context) {
    String contentString = widget.missionModel.sellerWalletAddress;
    String titleContent = '地址:' + contentString;
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
                     child: Text(titleContent ,style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.fade,textAlign: TextAlign.start,softWrap: false,),
                   ),
                  picAndTextButton('购买', widget.didClickBuyBtnCallBack)
                 ],
               ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     getBuyInfoLabel(I18n.of(context).totalAmountLabel,widget.missionModel.totalCount + 'TP'),
                     getBuyInfoLabel(I18n.of(context).remainAmountLabel,widget.missionModel.currentCount + 'TP'),
                   ],
                 ),)]
             );
  }
}