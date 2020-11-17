import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_choose_payment_cell.dart';
import 'tld_bank_card_info_page.dart';
import 'tld_wecha_alipay_info_page.dart';
import 'tld_payment_manager_page.dart';

class TPChoosePaymentPage extends StatefulWidget {
  TPChoosePaymentPage({Key key,this.walletAddress,this.isChoosePayment = false,this.didChoosePaymentCallBack}) : super(key: key);

  final String walletAddress;

  final bool isChoosePayment;

  final Function(TPPaymentModel) didChoosePaymentCallBack;

  @override
  _TPChoosePaymentPageState createState() => _TPChoosePaymentPageState();
}

class _TPChoosePaymentPageState extends State<TPChoosePaymentPage> {

    List titles = [
    I18n.of(navigatorKey.currentContext).bankCard,
    I18n.of(navigatorKey.currentContext).weChat,
    I18n.of(navigatorKey.currentContext).aliPay,
    I18n.of(navigatorKey.currentContext).CustomizeTheCollectionMethod
    ];
    
    List icons = [
      0xe679,
      0xe61d,
      0xe630,
      0xe65e,
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_payment_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).collectionMethod),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (BuildContext context, int index){
        return TPChoosePaymentCell(title : titles[index], iconInt: icons[index],
          didClickCallBack: (){
            TPPaymentType type;
            if (index == 0){
              type = TPPaymentType.bank;
            }else if (index == 1) {
                type = TPPaymentType.wechat;
             }else if (index == 2){
                type = TPPaymentType.alipay;
            }else{
              type = TPPaymentType.diy;
            }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPaymentManagerPage(type: type,walletAddress: widget.walletAddress,isChoosePayment: widget.isChoosePayment,didChoosePaymentCallBack: widget.didChoosePaymentCallBack,)));
          },
        );
      }
    );
  }

  void changePurseName(BuildContext context){
   
  }

}