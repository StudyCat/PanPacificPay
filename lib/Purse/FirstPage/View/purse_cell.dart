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
      child : Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           padding: EdgeInsets.only(top : 9 ,left:10,right: 10),
           child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     _getWalletNameRowView(),
                      Container(
                        padding: EdgeInsets.only(top : 8,right: 15),
                        child: Text(widget.walletInfo.value+'TP',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top : 4,right: 15,bottom: 10),
                        child: Text('='+widget.walletInfo.value+'CNY',style: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: 12),),
                      )
                    ],
                  ),
         ),
       ),
    )
    );
  }

  Widget _getWalletNameRowView(){
    Size size = MediaQuery.of(context).size;
    return  Container(
        width : size.width - 30,
        child : Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(widget.walletInfo.wallet.name,style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51))),
          // Padding(
          //   padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
          //   child: RichText(text: TextSpan(children:<InlineSpan>[
          //   WidgetSpan(child: CachedNetworkImage(imageUrl: widget.walletInfo.levelIcon,width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),fit: BoxFit.fill,),),
          //   TextSpan(text :' (' + widget.walletInfo.expProgress + ')',style:TextStyle(
          //         fontSize: ScreenUtil().setSp(28),
          //         color: Color.fromARGB(255, 51, 51, 51)))
          // ])),
          // )
        ],
      )
    );
  }
}