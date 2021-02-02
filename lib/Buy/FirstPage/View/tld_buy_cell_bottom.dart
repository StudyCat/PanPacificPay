import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getCellBottomView(TPBuyListInfoModel model,BuildContext context){
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
              CachedNetworkImage(imageUrl: model.payMethodVO.payIcon,width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50),fit: BoxFit.cover,),
            ],
          ),
        ),
      ],
    ),
  );
}