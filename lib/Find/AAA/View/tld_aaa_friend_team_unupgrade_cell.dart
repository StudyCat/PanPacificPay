import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_friend_team_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAAAFriendTeamUnUpgradeCell extends StatefulWidget {
  TPAAAFriendTeamUnUpgradeCell({Key key,this.teamModel,this.didClickUpgradeCallBack}) : super(key: key);

  final TPAAATeamModel teamModel;

  final Function didClickUpgradeCallBack;

  @override
  _TPAAAFriendTeamUnUpgradeCellState createState() =>
      _TPAAAFriendTeamUnUpgradeCellState();
}

class _TPAAAFriendTeamUnUpgradeCellState
    extends State<TPAAAFriendTeamUnUpgradeCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        height: ScreenUtil().setHeight(96),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(
            left: ScreenUtil().setWidth(0)),
            child:  RichText(
                  text: TextSpan(children: <InlineSpan>[
                WidgetSpan(
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.teamModel.levelIcon,
                    width: ScreenUtil().setSp(58),
                    height: ScreenUtil().setSp(58),
                    fit: BoxFit.fill,
                  ),
                ),
                TextSpan(
                    text: '  好友圈',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Color.fromARGB(255, 51, 51, 51)))
              ])),
                ),
              GestureDetector(
                onTap: (){
                  widget.didClickUpgradeCallBack();
                },
                child: Text('我要升级', textAlign: TextAlign.center,style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Theme.of(context).hintColor)),
                ),
              Icon(IconData(0xe60b,fontFamily : 'appIconFonts'),color: Color.fromARGB(255, 153, 153, 153),size: ScreenUtil().setSp(28),)
            ]),
        ),
      ),
    );
  }
}
