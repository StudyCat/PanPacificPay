import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPDetailRecieveRedEnvelopeHeaderCell extends StatefulWidget {
  TPDetailRecieveRedEnvelopeHeaderCell({Key key,this.detailRedEnvelopeModel}) : super(key: key);

  final TPDetailRedEnvelopeModel detailRedEnvelopeModel;

  @override
  _TPDetailRecieveRedEnvelopeHeaderCellState createState() => _TPDetailRecieveRedEnvelopeHeaderCellState();
}

class _TPDetailRecieveRedEnvelopeHeaderCellState extends State<TPDetailRecieveRedEnvelopeHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
          child: Container(
            width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
            child: RichText(
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text : widget.detailRedEnvelopeModel.receiveCount,
                style : TextStyle(fontSize:ScreenUtil().setSp(72),color : Theme.of(context).hintColor
              ),
              children: <InlineSpan>[
                TextSpan(
                text : 'TP',
                style : TextStyle(fontSize:ScreenUtil().setSp(32),color : Theme.of(context).hintColor
                ))
              ]
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom:ScreenUtil().setHeight(40)),
          child: Text(I18n.of(context).itHasBeenDepositedInYourWallet,style: TextStyle(fontSize:ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51),)))
      ],
    );
  }
}