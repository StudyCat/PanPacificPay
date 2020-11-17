import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPDetailRedEnvelopeHeaderCell extends StatefulWidget {
  TPDetailRedEnvelopeHeaderCell({Key key,this.detailRedEnvelopeModel}) : super(key: key);

  final TPDetailRedEnvelopeModel detailRedEnvelopeModel;

  @override
  _TPDetailRedEnvelopeHeaderCellState createState() => _TPDetailRedEnvelopeHeaderCellState();
}

class _TPDetailRedEnvelopeHeaderCellState extends State<TPDetailRedEnvelopeHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(16),bottom: ScreenUtil().setHeight(2)),
       child: Container(
         decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
         height: ScreenUtil().setHeight(74),
         padding : EdgeInsets.only(left: ScreenUtil().setWidth(20)),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children :<Widget> [ Text(I18n.of(context).alreadyReceived + widget.detailRedEnvelopeModel.receiveList.length.toString() + '/' + widget.detailRedEnvelopeModel.redEnvelopeNum.toString() + ',' +I18n.of(context).total+ widget.detailRedEnvelopeModel.expireTldCount + "/" + widget.detailRedEnvelopeModel.tldCount + "TP",style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),textAlign: TextAlign.start,)]
         ),
       ),
    );
  }
}