import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonFunction/tld_common_function.dart';

class TPPurseHeaderCell extends StatefulWidget {
  TPPurseHeaderCell({Key key,this.totalAmount = 0.000}) : super(key: key);

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
    return Container(
      width: screenSize.width - 30,
      child: _getBodyWidget(),
    );
  }

  Widget _getContentWidget(){
    Size screenSize = MediaQuery.of(context).size;
    String moneyStr = widget.totalAmount > 0 ?  NumUtil.getNumByValueDouble(widget.totalAmount, 3).toStringAsFixed(3) : '0.0';
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('总资产（TP）',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: screenSize.width - ScreenUtil().setWidth(250),
                child: Text(_isShowMoney ? getMoneyStyleStr(moneyStr):'***',style : TextStyle(fontSize : 26,color : Theme.of(context).primaryColor)),
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
                child:  _isShowMoney ? Icon(IconData(0xe60c,fontFamily: 'appIconFonts'),color: Theme.of(context).primaryColor,) : Icon(IconData(0xe648,fontFamily: 'appIconFonts'),color: Theme.of(context).primaryColor,size: ScreenUtil().setWidth(50)),
              ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left : 0 ,top : 6),
            child: Text('1.00TP=1.00USD',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),),
          )
        ],
      );
  }

  Widget _getBodyWidget(){
    return  Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(120),
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
          child: Container(
            padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.all(Radius.circular(4)),
              color : Colors.white,
              boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 5.0), //阴影xy轴偏移量
                            blurRadius: 5.0, //阴影模糊程度
                            spreadRadius: 1.0 //阴影扩散程度
                            )
                      ]
            ),
            child: _getContentWidget(),
          ),
        )
      ],
    );
  }

  // Widget _getRowHeaderRowWidget(){
  //   return Row(

  //   )
  // }

}