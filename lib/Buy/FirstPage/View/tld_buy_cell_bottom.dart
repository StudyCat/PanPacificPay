import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getCellBottomView(TPBuyListInfoModel model,BuildContext context){
  int iconInt;
  if (model.payMethodVO.type == 1){
    iconInt = 0xe679;
  }else if(model.payMethodVO.type == 2){
    iconInt = 0xe61d;
  }else if (model.payMethodVO.type == 3){
    iconInt = 0xe630;
  }else{
    iconInt = 0xe65e;
  }
  return Container(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(18),bottom: ScreenUtil().setHeight(30)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(I18n.of(context).paymentTermLabel,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width: ScreenUtil().setWidth(200),
          child: Row(
            mainAxisAlignment : MainAxisAlignment.end,
            children: <Widget>[
              Icon(IconData(iconInt,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
            ],
          ),
        ),
      ],
    ),
  );
}