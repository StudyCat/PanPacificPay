import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPUnopenRedEnvelopeAlertView extends StatefulWidget {
  TPUnopenRedEnvelopeAlertView({Key key,this.redEnvelopeModel,this.didClickOpenButtonCallBack}) : super(key: key);

  final TPDetailRedEnvelopeModel redEnvelopeModel;

  final Function didClickOpenButtonCallBack;

  @override
  _TPUnopenRedEnvelopeAlertViewState createState() => _TPUnopenRedEnvelopeAlertViewState();
}

class _TPUnopenRedEnvelopeAlertViewState extends State<TPUnopenRedEnvelopeAlertView> {

  TPWalletInfoModel _walletInfoModel;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
         children: <Widget>[
           Container(
            width: ScreenUtil().setHeight(528),
            height: ScreenUtil().setHeight(704),
            child: Image.asset('assetss/images/unopen_red_envelope.png',fit: BoxFit.fill,),
          ),
          _getContentColumn()
         ],
    ),
    );
  }

  Widget _getContentColumn(){
    return Container(
      width: ScreenUtil().setHeight(500),
      height: ScreenUtil().setHeight(500 / 635 * 920),
      child : Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(55)),
          child: Container(
            width: ScreenUtil().setHeight(400),
            child: Text(widget.redEnvelopeModel.rdesc,textAlign: TextAlign.center,softWrap: true,overflow: TextOverflow.ellipsis,style : TextStyle(fontSize : ScreenUtil().setHeight(30),color: Color.fromARGB(255, 248, 231, 28),decoration: TextDecoration.none)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(150)),
          child: Container(
            width: ScreenUtil().setHeight(400),
            child: RichText(
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text : widget.redEnvelopeModel.tldCount,
                style : TextStyle(fontSize : ScreenUtil().setHeight(60),color:Color.fromARGB(255, 248, 231, 28),decoration: TextDecoration.none),
                children: <InlineSpan>[
                  TextSpan(
                    text : "  TP",
                    style : TextStyle(fontSize : ScreenUtil().setHeight(30),color:Color.fromARGB(255, 248, 231, 28),decoration: TextDecoration.none),
                  )
                ]
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(130)),
          child: _getWalletWidget(),
        ),
        Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(70)),
          child: Container(
            width: ScreenUtil().setHeight(270),
            height: ScreenUtil().setHeight(80),
            decoration : BoxDecoration(
              border : Border.all(color : Color.fromARGB(255, 252, 238, 80),width: 4),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
              color: Color.fromARGB(255, 225, 180, 1)
            ),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).openRedDenvelope,style : TextStyle(fontSize : ScreenUtil().setHeight(30),color:Color.fromARGB(255, 255,46 , 77),decoration: TextDecoration.none)), 
              onPressed: (){
                widget.didClickOpenButtonCallBack(_walletInfoModel.walletAddress);
                Navigator.of(context).pop();
              }),
          ),
          )
      ],
    )
    );
  }

   Widget _getWalletWidget(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
          setState(() {
            _walletInfoModel = infoModel;
          });
          // widget.didChooseWalletCallBack(infoModel.walletAddress);
        },)));
      },
      child:  Container(
      width: ScreenUtil().setHeight(480),
      child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
          child: Text(_walletInfoModel == null ? I18n.of(context).chooseWallet:_walletInfoModel.wallet.name,style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(30),decoration: TextDecoration.none),),
        ),
        Icon(Icons.keyboard_arrow_right,color: Colors.white,size:ScreenUtil().setSp(40) ,)
      ],
    )
    ),
    );
  }

}