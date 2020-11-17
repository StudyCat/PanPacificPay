import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TPAcceptanceInvitationQRCodeView extends StatefulWidget {
  TPAcceptanceInvitationQRCodeView({Key key,this.qrCode,this.inviteCode}) : super(key: key);

  final String qrCode;

  final String inviteCode;

  @override
  _TPAcceptanceInvitationQRCodeViewState createState() => _TPAcceptanceInvitationQRCodeViewState();
}

class _TPAcceptanceInvitationQRCodeViewState extends State<TPAcceptanceInvitationQRCodeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right: ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30)),
       child: Container(
         height : ScreenUtil().setHeight(760),
         width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(140),
         color :Theme.of(context).primaryColor,
         child : Column(
           children : <Widget>[
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
               child: Text(I18n.of(context).myInvitationCode,style: TextStyle(color:Theme.of(context).hintColor,fontSize: ScreenUtil().setSp(40)),),
             ),
             Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: widget.qrCode.length > 0 ? QrImage(data: widget.qrCode,size : ScreenUtil().setWidth(408),backgroundColor: Colors.white,) : Container(width : ScreenUtil().setWidth(408),height: ScreenUtil().setWidth(408),),
            ),
              Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
               child: Text( I18n.of(context).promotionCode +' ${widget.inviteCode}',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(24)),),
             ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(48)),
                child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(236),height: ScreenUtil().setHeight(54),alignment: Alignment.center,),
              ),
           ]
         )
       ),
    );
  }
}