
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAAAPersonCenterHeaderView extends StatefulWidget {
  TPAAAPersonCenterHeaderView({Key key,this.didClickUpgradeButtonCallBack,this.didClickWithdrawCallBack,this.userInfo,this.didClickSignButton,this.futureProfit}) : super(key: key);

  final Function didClickUpgradeButtonCallBack;

  final Function didClickWithdrawCallBack;

  final Function didClickSignButton;

  final TPAAAUserInfo userInfo;

  final String futureProfit;

  @override
  _TPAAAPersonCenterHeaderViewState createState() => _TPAAAPersonCenterHeaderViewState();
}

class _TPAAAPersonCenterHeaderViewState extends State<TPAAAPersonCenterHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(168),bottom: ScreenUtil().setHeight(20)),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           _getUserInfoWidget(),
           Padding(
             padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
             child: Divider(height: ScreenUtil().setHeight(2),color: Colors.white),
           ),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child: Text('待领取收益',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white),),
           ),
           Padding(
             padding: EdgeInsets.only(top :ScreenUtil().setHeight(10)),
             child: Row(
               children : <Widget>[
                 Container(
                   width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(260),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: <Widget>[
                        Container(
                          constraints : BoxConstraints(maxWidth:MediaQuery.of(context).size.width - ScreenUtil().setWidth(360)),
                          child : Text(widget.userInfo != null ? '${widget.userInfo.balance}' : '0',softWrap: true,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Theme.of(context).hintColor),)
                        ),
                        Text(' TP',softWrap: true,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Theme.of(context).hintColor),)
                     ],
                   ),
                 ),
                 Container(
                   width: ScreenUtil().setWidth(180),
                   height: ScreenUtil().setHeight(72),
                   child: CupertinoButton(
                     padding: EdgeInsets.zero,
                     color: Theme.of(context).hintColor,
                     onPressed : widget.didClickWithdrawCallBack,
                     child: Text('领取到钱包',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(30))),
                   ),
                 )
               ]
             ),
           ),
           _getProfitRowWidget(),
           _getAddressView(context),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child: Text(widget.userInfo != null ? '推荐人 ${widget.userInfo.inviteWechat}' : '推荐人',style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white),),
           ),
           Padding(
             padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
             child : Container(
               height: ScreenUtil().setHeight(80),
               width: ScreenUtil.screenWidth - ScreenUtil().setWidth(60),
               child: CupertinoButton(
                 color: Color.fromARGB(255, 126, 211, 33),
                 borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                 child: Text('我要升级',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.white)),
                 onPressed: (){
                   widget.didClickUpgradeButtonCallBack();
                 },
               ),
             )
           )
         ],
       ),
    );
  }

  Widget _getProfitRowWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Row(
        children: <Widget>[
          _getProfitWidget('预计收益', widget.futureProfit.length > 0 ?'${widget.futureProfit}TP' : '计算中'),
          Padding(
            padding: EdgeInsets.only(left :ScreenUtil().setWidth(20)),
            child :  _getProfitWidget('总收益', widget.userInfo!= null ? widget.userInfo.totalProfit + 'TP' : '0TP')
            )
        ],
      ), 
      );
  }

  Widget _getProfitWidget(String title,String content){
    return Container(
      height : ScreenUtil().setHeight(110),
      width: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(80)) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Color.fromARGB(255, 82, 82, 82),
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(24))),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(4)),
            child :  Text(content,style: TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(32))),
          )
        ],
      ), 
    );
  }

  Widget _getUserInfoWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getUserHeaderWidget(),
        _getUserInfoColumnWidget(),
      ],
    );
  }

  Widget _getNickNameLabelSignButton(){
    return Container(
      width : MediaQuery.of(context).size.width - (ScreenUtil().setHeight(96) + ScreenUtil().setWidth(90)),
      height: ScreenUtil().setHeight(50),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(widget.userInfo != null ? widget.userInfo.nickName : '',style : TextStyle(fontSize : ScreenUtil().setSp(32),color : Colors.white)),
        CupertinoButton(padding: EdgeInsets.zero,child: Text(I18n.of(context).signIn,style: TextStyle(color : Theme.of(context).hintColor,fontSize : ScreenUtil().setSp(30)),), onPressed: (){
          widget.didClickSignButton();
        })
      ],
    ),
    );
  }

  Widget _getUserInfoColumnWidget(){
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getNickNameLabelSignButton(),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(
                    child : Icon(IconData(0xe61d,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24),),
                  ),
                  TextSpan(
                    text: widget.userInfo != null ? '  ${widget.userInfo.wechat}   ' : '     ',
                    style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white)
                  ),
                   WidgetSpan(
                    child : Icon(IconData(0xe605,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setSp(24)),
                  ),
                   TextSpan(
                    text: widget.userInfo != null ? '  ${widget.userInfo.tel}' : "  ",
                    style: TextStyle(fontSize: ScreenUtil().setSp(24),color: Colors.white)
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUserHeaderWidget(){
    return Container(
          width : ScreenUtil().setHeight(96),
          height : ScreenUtil().setHeight(96),
          child : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48)),
             child: widget.userInfo != null ? CachedNetworkImage(imageUrl:widget.userInfo.levelIcon,fit: BoxFit.fill,) : Container()
          )
        );
  }

  Widget _getAddressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        
      },
      child: Padding(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
        child: Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Color.fromARGB(255, 82, 82, 82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(190),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: Text(
              widget.userInfo != null ? widget.userInfo.walletAddress : '',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white),
            ),
          )
        ],
      ),
    ),
      ),
    );
  }

}