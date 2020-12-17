import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPDetailOrderPayMethodCell extends StatefulWidget {
  TPDetailOrderPayMethodCell({Key key,this.paymentModel,this.isOpen,this.titleStyle,this.title,this.didClickCallBack,this.didClickQrCodeCallBack}) : super(key: key);

  final TPPaymentModel paymentModel;

  final String title;

  final TextStyle titleStyle;

  final bool isOpen;

  final Function didClickCallBack;

  final Function didClickQrCodeCallBack;

  @override
  _TPDetailOrderPayMethodCellState createState() => _TPDetailOrderPayMethodCellState();
}

class _TPDetailOrderPayMethodCellState extends State<TPDetailOrderPayMethodCell> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: _getContentView(),
    );
  }

  Widget _getContentView(){
    if (widget.isOpen) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(28)),
              child: _getHedaerView(Icon(Icons.keyboard_arrow_down,color: Color.fromARGB(255, 51, 51, 51))),
            ),
            _getPayMethodView()
          ],
        ),
      );
    }else{
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: _getHedaerView(Icon(Icons.keyboard_arrow_right,color: Color.fromARGB(255, 51, 51, 51),)),
      );
    }
  }

  Widget _getHedaerView(Icon arrowIcon){
    return GestureDetector(
      onTap: widget.didClickCallBack,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),child : Text(
              widget.title,
              style: widget.titleStyle,
            )),
            Container(
              width : ScreenUtil().setWidth(100),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CachedNetworkImage(imageUrl: widget.paymentModel.payIcon,height: ScreenUtil().setWidth(32),width: ScreenUtil().setWidth(32),),
                Expanded(child: arrowIcon)
              ]
            ),
            )
          ],
      ),
    );
  }

  Widget _getPayMethodView(){
    if (widget.paymentModel.type == 1) {
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(36)),
        child: Column(
          children: <Widget>[
            _getNormalPayInfoView(I18n.of(context).realNameLabel, widget.paymentModel == null ? '':widget.paymentModel.realName),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getBankCodeInfoView(I18n.of(context).bankCardNumLabel,widget.paymentModel == null ? '':widget.paymentModel.account)
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getNormalPayInfoView(I18n.of(context).openAccountBankLabel, widget.paymentModel == null ? '':widget.paymentModel.subBranch),
            )
          ],
        ),
      );
    }else if (widget.paymentModel.type > 3){
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(36)),
        child: Column(
          children: <Widget>[
            _getNormalPayInfoView(I18n.of(context).paymentTermLabel, widget.paymentModel == null ? '':widget.paymentModel.myPayName),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getBankCodeInfoView(I18n.of(context).paymentAccountLabel,widget.paymentModel == null ? '':widget.paymentModel.account)
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getNormalPayInfoView(I18n.of(context).realNameLabel, widget.paymentModel == null ? '':widget.paymentModel.realName),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getQrCodePayInfoView(),
            )
          ],
        ),
      );
    }
    else{
      return Padding(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right : ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(36)),
        child: Column(
          children: <Widget>[
            _getNormalPayInfoView(I18n.of(context).collectionAccountLabel, widget.paymentModel == null ? '' :widget.paymentModel.account),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getQrCodePayInfoView(),
            )
          ],
        ),
      );
    }
  }

  // 获取只有两个文字展示的支付信息view
  Widget _getNormalPayInfoView(String title , String content){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child :Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102)))
        ),
        Container(
          child: Text(content,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102)),maxLines: null,textAlign: TextAlign.end,),
        ),
      ],
    );
  }

  //获取二维码
  Widget _getQrCodePayInfoView(){
     return GestureDetector(
       onTap : widget.didClickQrCodeCallBack,
       child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(I18n.of(context).qrCodeLabel,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
        Icon(IconData(0xe640,fontFamily : 'appIconFonts'))
      ],
    )
     );
  }

  //获取银行卡号信息
  Widget _getBankCodeInfoView(String title,String bankAcount){
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:(){
        Clipboard.setData(ClipboardData(text : bankAcount == null ? "":bankAcount));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      },
      child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102))),
         Container(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(400),
                    child :Text(bankAcount,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 102, 102, 102)),textAlign: TextAlign.end,maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right : ScreenUtil().setWidth(0)),
                  child: Icon(IconData(0xe601,fontFamily : 'appIconFonts',),size: ScreenUtil().setWidth(28),)
                  ),
              ]
            ),
         )],
    )
    );
  }
}