import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_bill_dash_line.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPAcceptanceBillListOpenCell extends StatefulWidget {
  TPAcceptanceBillListOpenCell({Key key,this.didClickBuyButtonCallBack,this.didClickCheckButtonCallBack,this.didClickOpenItemCallBack,this.infoListModel}) : super(key: key);

  final Function didClickBuyButtonCallBack;

  final Function(int) didClickCheckButtonCallBack;

  final Function didClickOpenItemCallBack;

  final TPBillInfoListModel infoListModel;

  @override
  _TPAcceptanceBillListOpenCellState createState() =>
      _TPAcceptanceBillListOpenCellState();
}

class _TPAcceptanceBillListOpenCellState
    extends State<TPAcceptanceBillListOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: _getHeaderWidget(),
          ),
         Offstage(
           offstage: widget.infoListModel.maxProfitDesc.length == 0,
           child:  Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: Text(widget.infoListModel.maxProfitDesc,style:TextStyle(
              color : Color.fromARGB(255, 153, 153, 153),
              fontSize : ScreenUtil().setSp(20)
            )),),
         ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TPBillDashLine(),
          ),
         _getOrderInfoColumnView(),
          _getSaleButtonWidget()
        ]),
      ),
    );
  }

  Widget _getOrderInfoColumnView(){
    if(widget.infoListModel.orderList.length > 0){
      return  Column(
      children: _getOrderList()
    );
    }else{
      return Container();
    }
  }

  List<Widget> _getOrderList(){
    List<Widget> result = [];
    int count = widget.infoListModel.orderList.length;
    for (int i = 0; i < count; i++) {
      TPApptanceOrderListModel listModel = widget.infoListModel.orderList[i];
      result.add(_getOrderInfoRowView(listModel,i));
    }
    return result;
  }

  Widget _getHeaderWidget() {
    return GestureDetector(
      onTap: widget.didClickOpenItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        child: Stack(
          children : <Widget>[
           Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('${widget.infoListModel.billLevel}'+ I18n.of(context).levelTPBill +'：${widget.infoListModel.billPrice}' + I18n.of(context).eachPart +'（${widget.infoListModel.alreadyBuyCount}/${widget.infoListModel.totalBuyCount}）',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(32),),textAlign: TextAlign.center),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(Icons.keyboard_arrow_up,color: Color.fromARGB(255, 153, 153, 153),))
          ]
        ),
    ),
    );
  }

  Widget _getOrderInfoRowView(TPApptanceOrderListModel orderListModel,int index){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30),left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
      child: Container(
        width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(260),
            child : RichText(
              maxLines: 1,
              overflow: TextOverflow.clip,
              text: TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Icon(
              IconData(0xe670, fontFamily: 'appIconFonts'),
              size: ScreenUtil().setWidth(40),
              color: Theme.of(context).hintColor,
            )),
            TextSpan(
                text: " " + I18n.of(context).orderNumLabel + ':${orderListModel.acptOrderNo}',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(24)))
          ])),
          ),
          GestureDetector(
            onTap:(){
              widget.didClickCheckButtonCallBack(index);
            },
            child : RichText(
              text: TextSpan(text: '${orderListModel.billCount}' + I18n.of(context).part,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51)),children: <InlineSpan>[
            TextSpan(
                text: '  ' + I18n.of(context).check,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: ScreenUtil().setSp(28)))
          ]))
          )
          ]
        ),
      ),
      );
  }
  
  Widget _getSaleButtonWidget(){
    return Container(
        padding: EdgeInsets.only(top:ScreenUtil().setHeight(26),bottom: ScreenUtil().setHeight(26)),
        width:ScreenUtil().setWidth(188),
        height : ScreenUtil().setHeight(124),
        child:  CupertinoButton(
            onPressed: widget.didClickBuyButtonCallBack,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(36))),
            padding: EdgeInsets.zero,
            child: Text(I18n.of(context).buyBtnTitle,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28))),
            color: Theme.of(context).hintColor,
          ),
    );
  }
}
