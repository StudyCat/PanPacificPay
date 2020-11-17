import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_export_key_address_view.dart';

class TPExportKeyPage extends StatefulWidget {
  TPExportKeyPage({Key key,this.wallet}) : super(key: key);

  final TPWallet wallet;

  @override
  _TPExportKeyPageState createState() => _TPExportKeyPageState();
}

class _TPExportKeyPageState extends State<TPExportKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'export_key_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).exportPrivateKey),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(150),
          ),
          child: Center(
              child: Image.asset('assetss/images/warning_copy.png',width: ScreenUtil().setWidth(218),height: ScreenUtil().setWidth(190),)),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(42),
          ),
          child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text(I18n.of(context).pleaseCopyCarefullyAndKeepItProperlyDoNotDivulgeThePrivateKey,textAlign: TextAlign.center,style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 208, 2, 27))),
              ),
          ),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(140),
            left: ScreenUtil().setWidth(30),
          ),
          child:  Text(I18n.of(context).WalletAddress,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)
          ),
          child: Center(
            child : TPExportKeyAddressView(address: widget.wallet.address,),
          ),
        ),
          Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(32),
            left: ScreenUtil().setWidth(30),
          ),
          child:  Text(I18n.of(context).privateKey,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)
          ),
          child: Center(
            child : TPExportKeyAddressView(privateKey: widget.wallet.privateKey,),
          ),
        )
      ],
    );
  }
}