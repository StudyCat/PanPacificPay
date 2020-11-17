import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPAccountUpgradeActionSheet extends StatefulWidget {
  TPAccountUpgradeActionSheet({Key key,this.payAmount,this.content,this.levelIcon,this.didClickUpgrade}) : super(key: key);

  final String content;

  final String payAmount;

  final String levelIcon;

  final Function didClickUpgrade;

  @override
  _TPAccountUpgradeActionSheetState createState() => _TPAccountUpgradeActionSheetState();
}

class _TPAccountUpgradeActionSheetState extends State<TPAccountUpgradeActionSheet> {

  String _walletAddress;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90.w, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      color: Color.fromARGB(255, 242, 242, 242),
                      height: ScreenUtil().setHeight(80),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('账户升级',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Color.fromARGB(255, 51, 51, 51))),
                      ),
                    ),
                    _levelWidget(),
                    GestureDetector(
                      onTap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TPEchangeChooseWalletPage(
                                      didChooseWalletCallBack:
                                          (TPWalletInfoModel infoModel) {
                                        setState(() {
                                          _walletAddress =
                                              infoModel.walletAddress;
                                        });
                                      },
                                    )));
                      },
                      child: _walletAddressWidget(),
                    ),
                    _bottomWidget()
                  ])
                ])));
  }

  Widget _levelWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
      child: Container(
        width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60), 
        child : RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '${widget.content}  ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 74, 74, 74)),
            children: [
              WidgetSpan(
                  child: Container(
                width: ScreenUtil().setHeight(30),
                height: ScreenUtil().setHeight(30),
                child: CachedNetworkImage(
                  imageUrl: widget.levelIcon,
                  fit: BoxFit.fill,
                ),
              ))
            ]),
      )
      ),
    );
  }


  Widget _walletAddressWidget() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '支付钱包',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(280),
                    child: Text(
                      _walletAddress != null ? _walletAddress : '请选择钱包',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )),
                Icon(Icons.keyboard_arrow_right)
              ])
            ],
          )),
    );
  }


  Widget _bottomWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        height: ScreenUtil().setHeight(80),
        color: Color.fromARGB(255, 242, 242, 242),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: RichText(
                text: TextSpan(
                    text: widget.payAmount,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                        color: Color.fromARGB(255, 74, 74, 74),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'TP',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(260),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).hintColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Text('确认升级',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                  onPressed: () {
                    if (_walletAddress == null){
                      Fluttertoast.showToast(msg: '请先选择钱包');
                      return;
                    }
                    widget.didClickUpgrade(_walletAddress);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}