import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tld_wallet_info_model.dart';

class TPPurseFirstPageCell extends StatefulWidget {
  TPPurseFirstPageCell({Key key,this.didClickCallBack,this.walletInfo}) : super(key: key);
  final Function didClickCallBack;
  final TPWalletInfoModel walletInfo;
  @override
  _TPPurseFirstPageCellState createState() => _TPPurseFirstPageCellState();
}

class _TPPurseFirstPageCellState extends State<TPPurseFirstPageCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap : () => widget.didClickCallBack(),
      child : Padding(
           padding: EdgeInsets.only(top :ScreenUtil().setHeight(20) ,left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(40)),
           child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     _getWalletNameRowView(),
                      Padding(
                        padding: EdgeInsets.only(top : ScreenUtil().setHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children : [
                            Padding(
                              padding :  EdgeInsets.only(left : ScreenUtil().setHeight(24)),
                              child: RichText(
                                text: TextSpan(
                                text: widget.walletInfo.value + 'TP',
                                style: TextStyle(color: Color.fromARGB(255, 1, 141, 248),fontSize: ScreenUtil().setSp(36)),
                                children: [
                                  TextSpan(
                                text: '\n=\$' + widget.walletInfo.value,
                                style: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),
                              )
                                ] 
                              ),
                              ),
                            ),
                            Container(
                              height: ScreenUtil().setHeight(60),
                              width: ScreenUtil().setWidth(134),
                              child: CupertinoButton(
                                color: Color.fromARGB(255, 1, 141, 248),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
                                padding: EdgeInsets.zero,
                                child: Text('查看',style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
                                onPressed: (){
                                  widget.didClickCallBack();
                                },
                              ),
                            )
                          ]
                        )
                      )
                    ],
                  ),
         ),
    );
  }

  Widget _getWalletNameRowView(){
    Size size = MediaQuery.of(context).size;
    return  Container(
        width : size.width - ScreenUtil().setWidth(120),
        child : Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(widget.walletInfo.wallet.name,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ],
      )
    );
  }
}