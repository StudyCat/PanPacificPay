import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceDetailWithdrawBottomCell extends StatefulWidget {
  TPAcceptanceDetailWithdrawBottomCell({Key key,this.didClickActionBtnCallBack,this.detailModel}) : super(key: key);

  final Function didClickActionBtnCallBack;

  final TPAcceptanceWithdrawOrderListModel detailModel;

  @override
  _TPAcceptanceDetailWithdrawBottomCellState createState() => _TPAcceptanceDetailWithdrawBottomCellState();
}

class _TPAcceptanceDetailWithdrawBottomCellState extends State<TPAcceptanceDetailWithdrawBottomCell> {

  List _actionBtnTitleList = [];

  @override
  void initState() { 
    super.initState();
    
    TPOrderStatusInfoModel infoModel = TPDataManager.acceptanceWithdrawOrderStatusMap[widget.detailModel.cashStatus];
    if (widget.detailModel.amApply) {
      _actionBtnTitleList.addAll(infoModel.sellerActionButtonTitle);
    }else{
      _actionBtnTitleList.addAll(infoModel.buyerActionButtonTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(10)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20),top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child:  widget.detailModel.amApply ? _getMeTakeColumnView() : _getNotMeTakeView(),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
            child: _getActionBtn(context),
          )
        ],
      ),
    );;
  }

  Widget _getMeTakeColumnView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(I18n.of(context).pleaseReferToThePaymentMethod,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(24)),),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(16)),
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
          ),
        )
      ],
    );
  }

  Widget _getNotMeTakeView(){
    return  Text(I18n.of(context).pleaseReferToThePaymentMethod,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(24)),);
  }

   Widget _getActionBtn(BuildContext context) {
    if (_actionBtnTitleList.length == 0) {
      return Container();
    } else if (_actionBtnTitleList.length == 1) {
      return _getOnlyOneActionBtnView();
    } else {
      return _getTwoActionBtnView(context);
    }
  }

  Widget _getOnlyOneActionBtnView() {
    return Container(
        height: ScreenUtil().setHeight(80),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        child: CupertinoButton(
          onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList.first),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          padding: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          child: Text(
            _actionBtnTitleList.first,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Theme.of(context).hintColor),
          ),
        ));
  }

  Widget _getTwoActionBtnView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(80),
          width: size.width / 2.0 - ScreenUtil().setWidth(40),
          child: OutlineButton(
            onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[0]),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
              width: 1,
            ),
            child: Text(
              _actionBtnTitleList[0],
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Theme.of(context).hintColor),
            ),
          ),
        ),
        Container(
            width: size.width / 2.0 - ScreenUtil().setWidth(40),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(
                child: Text(
                  _actionBtnTitleList[1],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28), color: Colors.white),
                ),
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).hintColor,
                onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[1]))),
      ],
    );
  }

}