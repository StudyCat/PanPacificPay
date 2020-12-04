import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceWithdrawListCell extends StatefulWidget {
  TPAcceptanceWithdrawListCell({Key key,this.didClickIMBtnCallBack,this.orderListModel,this.didClickActionBtn}) : super(key: key);

  final Function didClickIMBtnCallBack;

  final TPAcceptanceWithdrawOrderListModel orderListModel;

  final Function(String) didClickActionBtn;

  @override
  _TPAcceptanceWithdrawListCellState createState() => _TPAcceptanceWithdrawListCellState();
}

class _TPAcceptanceWithdrawListCellState extends State<TPAcceptanceWithdrawListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(10)),
       child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                _getHeaderRowView(),
                _getMissionInfoView(),
                Padding(
                  padding:  EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                  child: _getBottomWidget(),
                  )
              ],
            ),
          ),
    );
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(80),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[
          Text( I18n.of(context).number + '：' + widget.orderListModel.cashNo,style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
        GestureDetector(
          onTap: widget.didClickIMBtnCallBack,
          child: Container(
          width: ScreenUtil().setWidth(74),
          height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            borderRadius : BorderRadius.only(topLeft:Radius.circular(ScreenUtil().setHeight(30)),bottomLeft:Radius.circular(ScreenUtil().setHeight(30))),
            color: Theme.of(context).primaryColor
          ),
          child: Icon(IconData(0xe609,fontFamily : 'appIconFonts'),color: Colors.white,),
        ),
        )
      ]
    ),
    );
  }

  Widget _getMissionInfoView(){
    TPOrderStatusInfoModel infoModel = TPDataManager.acceptanceWithdrawOrderStatusMap[widget.orderListModel.cashStatus];
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getMissionInfoColumWidget(I18n.of(context).countLabel, '${widget.orderListModel.tldCount}TP', null),
          _getMissionInfoColumWidget(I18n.of(context).amount,  '${widget.orderListModel.cashPrice}USD', null),
          _getMissionInfoColumWidget(I18n.of(context).statusLabel, infoModel.orderStatusName, infoModel.orderStatusColor)
        ]
      ),
    );
  }

  Widget _getMissionInfoColumWidget(String title,String content,Color color){
    return Column(
      children: <Widget>[
        Text(title,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:color != null ? color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _getBottomWidget(){
    TPOrderStatusInfoModel statusInfoModel = TPDataManager.acceptanceWithdrawOrderStatusMap[widget.orderListModel.cashStatus];
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[
        _getDateRowView(),
        _getActionButton()
      ]
    ),
    );
  }

  Widget _getDateRowView(){
    return Container(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:<Widget>[
        Offstage(
          offstage: !widget.orderListModel.amApply,
          child: Container(
            width : ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              border : Border.all(color:Color.fromARGB(255, 217, 176, 123),width:0.5),
              borderRadius : BorderRadius.all(Radius.circular(4)),
              color :Theme.of(context).hintColor
            ),
            child: Center(
              child : Text(I18n.of(context).iStarted,style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 121, 87, 43)))
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
          child : Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.orderListModel.createTime), [yyyy,'-',mm,'-',dd,' ',HH,':',nn]),style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153)))
          )
      ]
    ),
    );
  }

  Widget _getActionButton(){
     TPOrderStatusInfoModel statusInfoModel = TPDataManager.acceptanceWithdrawOrderStatusMap[widget.orderListModel.cashStatus];
     List actionBtnList = [];
     if (widget.orderListModel.amApply) {
       actionBtnList = statusInfoModel.sellerActionButtonTitle;
     }else{
       actionBtnList = statusInfoModel.buyerActionButtonTitle;
     }
      if (actionBtnList.length > 0) {
         return Container(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(180),
          child: CupertinoButton(
            child: Text(actionBtnList.first,style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Theme.of(context).hintColor)),
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
            onPressed:()=> widget.didClickActionBtn(actionBtnList.first),
          ),
        );
       }else{
         return Container();
       }
  }
}