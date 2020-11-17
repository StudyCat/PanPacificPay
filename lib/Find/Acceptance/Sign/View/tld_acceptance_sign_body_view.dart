import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceSignBodyView extends StatefulWidget {
  TPAcceptanceSignBodyView({Key key,this.userInfoModel,this.didClickSignButton,this.didClickWalletButton}) : super(key: key);
  
  final TPAAAUserInfo userInfoModel;

  final Function didClickSignButton;

  final Function didClickWalletButton;

  @override
  _TPAcceptanceSignBodyViewState createState() => _TPAcceptanceSignBodyViewState();
}

class _TPAcceptanceSignBodyViewState extends State<TPAcceptanceSignBodyView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child:  Container(
        padding: EdgeInsets.only(bottom : ScreenUtil().setHeight(20)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
         decoration: BoxDecoration(
           borderRadius : BorderRadius.all(Radius.circular(4)),
           color : Colors.white
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: <Widget>[
            //  _getChooseWalletWidget(),
             TPAcceptanceSignView(userInfoModel: widget.userInfoModel,didClickItemToSignCallBack: (){
               widget.didClickSignButton();
             },),
            //   Container(
            //    width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
            //    child: Text('签到累计获得：' + _getTotalAmount() + '积分'+ '  '+_getTPAmount() + 'TP',style:TextStyle(fontSize:ScreenUtil().setSp(20),color: Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.start,),
            //  )
           ],
         ),
      )
    );
  }

  // String _getTotalAmount(){
  //   return widget.userInfoModel != null ? widget.userInfoModel.acptSignScore : '0.0';
  // }

  // String _getTPAmount(){
  //   return widget.userInfoModel != null ? widget.userInfoModel.acptSignTld : '0.0';
  // }

  // Widget _getChooseWalletWidget(){
  //   String walletAddress = widget.userInfoModel != null ? widget.userInfoModel.wallet.name : I18n.of(context).notLogin;
  //   return Padding(
  //     padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),right : ScreenUtil().setWidth(20)),
  //     child: GestureDetector(
  //       onTap : widget.didClickWalletButton,
  //       child :  Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //               children : <Widget>[
  //                  Icon(IconData(0xe644,fontFamily: 'appIconFonts'),size: ScreenUtil().setHeight(28),color: Color.fromARGB(255, 51, 51, 51),),
  //                 Text('   ' + walletAddress,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)))
  //               ]
  //           )
  //     ),
  //   );
  // }

}