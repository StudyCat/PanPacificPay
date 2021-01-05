import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../dataBase/tld_database_manager.dart';
import '../../../Purse/Settings/Page/tld_purse_setting_backup_word_page.dart';
import '../../../dataBase/tld_database_manager.dart';
import '../../../tld_tabbar_page.dart';

class TPCreatePurseSuccessPage extends StatefulWidget {
  TPCreatePurseSuccessPage({Key key,this.wallet}) : super(key: key);

  final TPWallet wallet;
  @override
  _TPCreatePurseSuccessPageState createState() =>
      _TPCreatePurseSuccessPageState();
}

class _TPCreatePurseSuccessPageState extends State<TPCreatePurseSuccessPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'create_purse_success_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).createWallet),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child : _getBodyWidget(context)
        ),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child:  Center(
              child: Image.asset('assetss/images/purse_success.png')),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text(I18n.of(context).createWalletSuccess,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        // Container(
        //   margin: EdgeInsets.only(
        //       top: ScreenUtil().setHeight(200),
        //       left: ScreenUtil().setWidth(100),
        //       right: ScreenUtil().setWidth(100)),
        //   height: ScreenUtil().setHeight(80),
        //   width: size.width - ScreenUtil().setWidth(200),
        //   child: CupertinoButton(
        //       child: Text(
        //         '确定',
        //         style: TextStyle(
        //             fontSize: ScreenUtil().setSp(28), color: Colors.white),
        //       ),
        //       padding: EdgeInsets.all(0),
        //       color: Theme.of(context).primaryColor,
        //       onPressed: () {

        //          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TPTabbarPage()), (route) => route == null);
        //       }),
        // ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(100),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                I18n.of(context).backupWalletMnemonicWord,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPurseSeetingBackWordPage(wallet: widget.wallet,type: TPBackWordType.create,)));
              }),
        )
      ],
    ));
  }

}
