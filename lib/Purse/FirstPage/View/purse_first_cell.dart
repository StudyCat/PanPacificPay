import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/tp_purse_first_page_header_painter.dart';
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
      child: _getBodyWidget(),
    );
  }

  Widget _getContentWidget(){
    Size screenSize = MediaQuery.of(context).size;
    String moneyStr = widget.totalAmount > 0 ?  NumUtil.getNumByValueDouble(widget.totalAmount, 3).toStringAsFixed(3) : '0.0';
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left : screenSize.width - ScreenUtil().setWidth(250),top: ScreenUtil().setHeight(40)),
            child: GestureDetector(
                onTap: (){
                  setState(() {
                    _isShowMoney = !_isShowMoney;
                  });
                },
                child: Container(
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(40),
                child:  _isShowMoney ? Icon(IconData(0xe60c,fontFamily: 'appIconFonts'),color: Colors.white,) : Icon(IconData(0xe648,fontFamily: 'appIconFonts'),color: Colors.white,size: ScreenUtil().setWidth(50)),
              ),
              )
          ),
          Container(
            child: CustomPaint(
            size : Size(screenSize.width,(screenSize.width - ScreenUtil().setWidth(132)) / 2),
            painter: TPPurseFirstPageHeaderPainter(mouneyStr: _isShowMoney ? moneyStr : '*****'),
          ),
          ),
           Container(
            decoration : BoxDecoration(
                image: DecorationImage(image: AssetImage('assetss/images/first_purse_bottom.png'),fit: BoxFit.fitWidth)
            ),
            height: MediaQuery.of(context).size.width /750 * 116,
            width: MediaQuery.of(context).size.width,
        ),
          // Text('总资产（TP）',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Container(
          //       width: screenSize.width - ScreenUtil().setWidth(250),
          //       child: Text(_isShowMoney ? getMoneyStyleStr(moneyStr):'***',style : TextStyle(fontSize : 26,color : Theme.of(context).primaryColor)),
          //     ),
          //     GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           _isShowMoney = !_isShowMoney;
          //         });
          //       },
          //       child: Container(
          //       width: ScreenUtil().setWidth(80),
          //       height: ScreenUtil().setHeight(40),
          //       child:  _isShowMoney ? Icon(IconData(0xe60c,fontFamily: 'appIconFonts'),color: Theme.of(context).primaryColor,) : Icon(IconData(0xe648,fontFamily: 'appIconFonts'),color: Theme.of(context).primaryColor,size: ScreenUtil().setWidth(50)),
          //     ),
          //     )
          //   ],
          // ),
          // Container(
          //   padding: EdgeInsets.only(left : 0 ,top : 6),
          //   child: Text('1.00TP=1.00USD',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),),
          // )
        ],
      );
  }

  Widget _getBodyWidget(){
    return Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 24, 191, 254),
                  Color.fromARGB(255, 2, 113, 212),
                ],
              ), 
      ),
      child: _getContentWidget(),
    );
  }

  // Widget _getRowHeaderRowWidget(){
  //   return Row(

  //   )
  // }

}