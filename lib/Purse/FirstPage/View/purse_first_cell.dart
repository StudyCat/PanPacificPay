import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonFunction/tld_common_function.dart';

class TPPurseHeaderCell extends StatefulWidget {
  TPPurseHeaderCell({Key key,this.didClickCreatePurseButtonCallBack,this.didClickImportPurseButtonCallBack,this.totalAmount = 0.000}) : super(key: key);

  final Function didClickCreatePurseButtonCallBack;
  final Function didClickImportPurseButtonCallBack;
  final double totalAmount;

  @override
  _TPPurseHeaderCellState createState() => _TPPurseHeaderCellState();
}

class _TPPurseHeaderCellState extends State<TPPurseHeaderCell> {
  bool _isShowMoney;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowMoney = true;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String moneyStr = widget.totalAmount > 0 ?  NumUtil.getNumByValueDouble(widget.totalAmount, 3).toStringAsFixed(3) : '0.0';
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      width: screenSize.width - 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('TP',style: TextStyle(color:Theme.of(context).hintColor,fontSize: 12),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: screenSize.width - ScreenUtil().setWidth(150),
                child: Text(_isShowMoney ? getMoneyStyleStr(moneyStr):'***',style : TextStyle(fontSize : 26,color : Theme.of(context).hintColor)),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _isShowMoney = !_isShowMoney;
                  });
                },
                child: Container(
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(40),
                padding : EdgeInsets.only(right : 0,left: 10),
                child:  _isShowMoney ? Icon(IconData(0xe60c,fontFamily: 'appIconFonts'),color: Theme.of(context).hintColor,size: ScreenUtil().setWidth(50),) : Icon(IconData(0xe648,fontFamily: 'appIconFonts'),color: Theme.of(context).hintColor,size: ScreenUtil().setWidth(50)),
              ),
              )
            ],
          ),
          
          Container(
            padding: EdgeInsets.only(left : 0 ,top : 6),
            child: Text('1.00TP=1.00CNY',style: TextStyle(color:Theme.of(context).hintColor,fontSize: 12),),
          ),

          Container(
            padding: EdgeInsets.only(top : 10),
            height: ScreenUtil().setHeight(80),
            child: _getActionWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getActionWidget(){
    List purseList = TPDataManager.instance.purseList;
    bool isHaveImport = false;
    for (TPWallet wallet in purseList) {
        if (wallet.type != null && wallet.type == 1){
          isHaveImport = true;
          break;
        }else{
          
        }
    }

    if (isHaveImport){
      return getButton(()=>widget.didClickCreatePurseButtonCallBack(), I18n.of(context).createWalletBtnTitle, MediaQuery.of(context).size.width * 2);
    }else{
      return  Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getButton(()=>widget.didClickCreatePurseButtonCallBack(), I18n.of(context).createWalletBtnTitle, MediaQuery.of(context).size.width),
                getButton(()=>widget.didClickImportPurseButtonCallBack(), I18n.of(context).importWalletBtnTitle, MediaQuery.of(context).size.width),
              ]);
    }
  }

  Widget getButton(Function didClickCallBack,String title, double scrrenWidth){
      return Container(
                 width : scrrenWidth / 2.0 - 30,
                  child: CupertinoButton(
                  color: Theme.of(context).hintColor,
              onPressed: () => didClickCallBack(),
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                  child: Text(
                           title,
                           textAlign: TextAlign.center,
                           style : TextStyle(color: Colors.white,fontSize: 14)),
                      ),
              );
  } 
}