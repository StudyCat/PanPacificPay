import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPChooseWalletCell extends StatefulWidget {
  TPChooseWalletCell({Key key,this.walletInfo,this.didClickItemCallBack}) : super(key: key);

  final TPWalletInfoModel walletInfo;

  final Function didClickItemCallBack;

  @override
  _TPChooseWalletCellState createState() => _TPChooseWalletCellState();
}

class _TPChooseWalletCellState extends State<TPChooseWalletCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
      child : GestureDetector(
        child : Container(
       decoration: BoxDecoration(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         color : Colors.white
       ),
       child:  Padding(
           padding: EdgeInsets.only(top :ScreenUtil().setHeight(20) ,left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(40),bottom: ScreenUtil().setHeight(20)),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children : [
               Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     _getWalletNameRowView(),
                      Padding(
                        padding: EdgeInsets.only(top : ScreenUtil().setHeight(16)),
                        child:Padding(
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
                      )
                    ],
                  ),
                  Container(
                              child: Icon(IconData(0xe61c,fontFamily : 'appIconFonts')),
                            )
             ]
           )
         ),
    ),
    onTap: (){
      widget.didClickItemCallBack();
    },
      ));
  }

    Widget _getWalletNameRowView(){
    Size size = MediaQuery.of(context).size;
    return  Container(
        width : size.width - ScreenUtil().setWidth(200),
        child : Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.walletInfo.wallet.name,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
        ],
      )
    );
  }

}