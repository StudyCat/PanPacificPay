import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPRecieveRedEnvelopeCell extends StatefulWidget {
  TPRecieveRedEnvelopeCell({Key key,this.reiceveModel}) : super(key: key);

  final TPRedEnvelopeReiceveModel reiceveModel;

  @override
  _TPRecieveRedEnvelopeCellState createState() => _TPRecieveRedEnvelopeCellState();
}

class _TPRecieveRedEnvelopeCellState extends State<TPRecieveRedEnvelopeCell> {
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(0)),
      child: Container(
      decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(0)),
       child: Column(
         children: <Widget>[
           _getContentRowWidget(),
           Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
              child: Divider(
                height: ScreenUtil().setHeight(2),
                color: Color.fromARGB(255, 219, 218, 216),
              ),
            )
         ],
       ),
    ),
    );
  }


  Widget _getLeftColumnWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children : <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(320),
          child: Text(widget.reiceveModel.receiveWalletAddress,maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
        ),
        Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child:Text(_getDateTime(),style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))))
      ]
    );
  }


  
  String _getDateTime(){
    return formatDate(DateTime.fromMillisecondsSinceEpoch(widget.reiceveModel.createTime), [yyyy,'-',mm,'-',dd,' ',HH,':',nn]);
  }


  Widget _getContentRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getLeftColumnWidget(),
        Text(widget.reiceveModel.receiveCount + 'TP',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32)))
      ],
    );
  }
}