import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_success_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tld_create_purse_success_page.dart';
import '../Model/create_purse_model_manager.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../tld_not_purse_page.dart';
import '../../../tld_tabbar_page.dart';

enum TPCreatingPursePageType { create, import }

class TPCreatingPursePage extends StatefulWidget {
  TPCreatingPursePage(
      {Key key, @required this.type, this.mnemonicString, this.privateKey,this.walletName})
      : super(key: key);

  final TPCreatingPursePageType type;

  final String walletName;

  final String mnemonicString;

  final String privateKey;

  @override
  _TPCreatingPursePageState createState() => _TPCreatingPursePageState();
}

class _TPCreatingPursePageState extends State<TPCreatingPursePage> {
  TPCreatePurseModelManager _manager;
  @override
  void initState() {
    super.initState();

    _manager = TPCreatePurseModelManager();
    Future.delayed(Duration(seconds: 1), () {
      if (widget.type == TPCreatingPursePageType.create) {
        _createPurse();
      } else {
        if (widget.mnemonicString != null) {
          _importPurseWithWord();
        } else {
          _importPurseWithPrivateKey();
        }
      }
    });
  }

  void _createPurse() async {
    await _manager.createPurse('', widget.walletName,(TPWallet wallet) {
      TPDataManager.instance.purseList.add(wallet);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TPCreatePurseSuccessPage(
                    wallet: wallet,
                  )));
    }, (TPError error) {
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
          _popAction();
    });
  }



  void _importPurseWithWord() async {
    await _manager.importPurseWithWord(widget.mnemonicString,widget.walletName,
        (TPWallet wallet) {
      TPDataManager.instance.purseList.add(wallet);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TPImportPurseSuccessPage()));
    }, (TPError error) {
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      _popAction();
    });
  }

  void _importPurseWithPrivateKey()async{
    await _manager.importPurseWithPrivateKey(widget.privateKey,widget.walletName, (TPWallet wallet){
      TPDataManager.instance.purseList.add(wallet);
          Navigator.push(context,
               MaterialPageRoute(builder: (context) => TPImportPurseSuccessPage()));
    },(TPError error) {
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      _popAction();
    } );
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == TPCreatingPursePageType.create) {
      title = I18n.of(context).createWallet;
    } else {
      title = I18n.of(context).importWallet;
    }
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'creating_purse_page',
        transitionBetweenRoutes: false,
        middle: Text(title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        leading: Container(
          height: ScreenUtil().setHeight(34),
          width: ScreenUtil().setHeight(34),
          child: CupertinoButton(
            child: Icon(
              IconData(
                0xe600,
                fontFamily: 'appIconFonts',
              ),
              color: Color.fromARGB(255, 51, 51, 51),
            ),
            padding: EdgeInsets.all(0),
            onPressed: () => _popAction(),
          ),
        ),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    String str;
    if (widget.type == TPCreatingPursePageType.create) {
      str = I18n.of(context).pleaseWaitWhileTheWalletIsCreated;
    } else {
      str = I18n.of(context).pleaseWaitWhileTheWalletIsImported;
    }
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child: Image.asset(
            'assetss/images/creat_purse_wait.png',
            width: ScreenUtil().setWidth(176),
            height: ScreenUtil().setHeight(212),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text(str,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        )
      ],
    ));
  }

  void _popAction() {
    if (TPDataManager.instance.purseList.length == 0) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TPNotPurseHomePage()),
          (route) => route == null);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TPTabbarPage()),
          (route) => route == null);
    }
  }
}
