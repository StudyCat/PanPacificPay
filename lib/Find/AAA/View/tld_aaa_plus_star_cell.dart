import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_plus_star_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPAAAPlusStarCell extends StatefulWidget {
  TPAAAPlusStarCell({Key key,this.starModel,this.didClickPlusStarButton}) : super(key: key);
  
  final TPTeamStarModel starModel;

  final Function didClickPlusStarButton;

  @override
  _TPAAAPlusStarCellState createState() => _TPAAAPlusStarCellState();
}

class _TPAAAPlusStarCellState extends State<TPAAAPlusStarCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Container(
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
         decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(4))),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             _getTopWidget(),
             Padding(
               padding: EdgeInsets.only(top :ScreenUtil().setHeight(20)),
               child: _getContentWidget(),
              ),
                Padding(
               padding: EdgeInsets.only(top :ScreenUtil().setHeight(20)),
               child: _getBottomWidget(),
            ),
           ],
         ),
       ),
    );
  }

  Widget _getTopWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         RichText(text: TextSpan(
          children : <InlineSpan>[
             WidgetSpan(
                    child : CachedNetworkImage(imageUrl: widget.starModel.levelIcon,width: ScreenUtil().setSp(58),height: ScreenUtil().setSp(58),fit: BoxFit.fill,),
                  ),
             TextSpan(
               text : '  好友圈',
               style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color.fromARGB(255, 51, 51, 51))
             )
          ]
        )),
        RichText(text: TextSpan(
           text : 'x${widget.starModel.starLevel} ',
           style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color.fromARGB(255, 51, 51, 51)),
          children : <InlineSpan>[
             WidgetSpan(
                    child : Icon(IconData(0xe6c3,fontFamily: 'appIconFonts'),size: ScreenUtil().setSp(36),color: Color.fromARGB(255, 217, 176, 123),),
                  ),
          ]
        )),
      ],
    );
  }

  Widget _getContentWidget(){
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 242, 242, 242),borderRadius: BorderRadius.all(Radius.circular(4))),
      padding: EdgeInsets.only(left :ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(36),top: ScreenUtil().setHeight(36)),
      child: Column(
        children: [
           Container(
                 width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                 child : RichText(
                   textAlign: TextAlign.start,
                   text: TextSpan(
                     text: '${widget.starModel.teamLevel}级好友圈,每升一星,好友成功签到,可额外获取',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
                     children: <InlineSpan>[
                     TextSpan(
                     text: '(${widget.starModel.addProfit}TP)',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),),
                     ]
                   ),
                 )
            ),
            Padding(
              padding: EdgeInsets.only(top :ScreenUtil().setHeight(26)),
              child:  Container(
                 width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                 child : RichText(
                   textAlign: TextAlign.start,
                   text: TextSpan(
                     text: '额外收益',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
                     children: <InlineSpan>[
                     TextSpan(
                     text: '   ${widget.starModel.curProfit}',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 217 , 176, 123)),),
                     TextSpan(
                     text: 'TP',
                     style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255,51, 51, 51)),),
                     ]
                   ),
                 )
            ),
              ),
        ],
      ),
    );
  }


  Widget _getBottomWidget(){
    return Container(
      width : ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(80),
      child: CupertinoButton(
        color: Color.fromARGB(255, 217, 176, 123),
        padding: EdgeInsets.zero,
        child: Text('我要升星',style : TextStyle(fontSize :ScreenUtil().setSp(24),color :Color.fromARGB(255, 57, 57, 57))),
        onPressed: (){
          widget.didClickPlusStarButton();
        },
      ),
    );
  }
}