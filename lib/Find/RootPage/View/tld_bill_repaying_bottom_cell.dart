import 'package:dragon_sword_purse/Find/RootPage/Model/tld_bill_repaying_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPBillRepayingBottomCell extends StatefulWidget {
  TPBillRepayingBottomCell({Key key,this.repayingModel,this.didClickClearButton}) : super(key: key);

  final TPBillRepayingModel repayingModel;

  final Function didClickClearButton;

  @override
  _TPBillRepayingBottomCellState createState() => _TPBillRepayingBottomCellState();
}

class _TPBillRepayingBottomCellState extends State<TPBillRepayingBottomCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
          child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Text('结算规则说明',style: TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text(widget.repayingModel.clearRule,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),),
                    )
                  ]
                )
              ),
        ),
          Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
          child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Text('转入余利宝规则说明',style: TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text(widget.repayingModel.ylbRule,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),),
                    )
                  ]
                )
              ),
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(100)),
          child: Container(
            width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
            height: ScreenUtil().setHeight(88),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Theme.of(context).primaryColor,
              child: Text(
                '确认清退',
                style: TextStyle(
                  color : Colors.white,
                  fontSize:ScreenUtil().setSp(28)
                ),
            ), onPressed: (){
              widget.didClickClearButton();
            }),
          ),
        )
      ],
    );
  }
}