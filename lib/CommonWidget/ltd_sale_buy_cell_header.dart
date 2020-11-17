import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import '../Buy/FirstPage/View/tld_buy_button.dart';
import '../Buy/FirstPage/View/tld_buy_info_label.dart';

class TPCommonCellHeaderView extends StatefulWidget {
  TPCommonCellHeaderView({Key key,this.title,this.buttonTitle,this.onPressCallBack,this.buttonWidth,this.saleModel,this.buyModel,this.isHiddenBtn}) : super(key: key);

  final String title;
  final String buttonTitle; 
  final Function onPressCallBack;
  final double buttonWidth;
  final TPSaleListInfoModel saleModel;
  final TPBuyListInfoModel buyModel;
  final bool isHiddenBtn;
  @override
  _TPCommonCellHeaderViewState createState() => _TPCommonCellHeaderViewState();
}

class _TPCommonCellHeaderViewState extends State<TPCommonCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    String contentString = widget.saleModel != null ? widget.saleModel.sellNo : widget.buyModel.sellerWalletAddress;
    String titleContent = widget.title +'：' + contentString;
    Size size = MediaQuery.of(context).size;
    return Column(
             children : <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : 10),
                     width: size.width - widget.buttonWidth,
                     height: ScreenUtil().setHeight(30),
                     child: Text(titleContent ,style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.fade,textAlign: TextAlign.start,softWrap: false,),
                   ),
                   Offstage(
                     offstage : widget.buyModel != null ? widget.buyModel.isMine : widget.isHiddenBtn,
                     child : picAndTextButton(widget.buttonTitle, widget.onPressCallBack)
                   )
                 ],
               ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     getBuyInfoLabel(I18n.of(context).totalAmountLabel, widget.saleModel != null ?  widget.saleModel.totalCount + 'TP' :widget.buyModel.totalCount + 'TP'),
                     getBuyInfoLabel(I18n.of(context).remainAmountLabel, widget.saleModel != null ?  widget.saleModel.currentCount + 'TP' :widget.buyModel.currentCount + 'TP'),
                   ],
                 ),)]
             );
  }
}

