import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';
import 'tld_choose_payment_page.dart';


class TPPaymentChooseWalletPage extends StatefulWidget {
  TPPaymentChooseWalletPage({Key key}) : super(key: key);

  @override
  _TPPaymentChooseWalletPageState createState() => _TPPaymentChooseWalletPageState();
}

class _TPPaymentChooseWalletPageState extends State<TPPaymentChooseWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_payment_wallet_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).chooseWalletLabel),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }




  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: TPDataManager.instance.purseList.length,
      itemBuilder: (BuildContext context, int index) {
        TPWallet wallet = TPDataManager.instance.purseList[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TPChoosePaymentPage(walletAddress: wallet.address,)));
          },
          child: Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(2)),
            child: TPClipCommonCell(title: wallet.name,titleStyle: TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28)),type: TPClipCommonCellType.normalArrow,content: '',),
          )
        );
     });
  }


}