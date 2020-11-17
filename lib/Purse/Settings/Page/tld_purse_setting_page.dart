import 'dart:ffi';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Purse/Settings/Page/tld_purse_level_desc_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../View/tld_purse_setting_cell.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_purse_setting_backup_word_page.dart';
import 'tld_export_key_page.dart';
import 'tld_delete_purse_success_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Model/tld_setting_model_manager.dart';

class TPPurseSettingPage extends StatefulWidget {
  TPPurseSettingPage({Key key, this.wallet, this.nameChangeSuccessCallBack})
      : super(key: key);

  final TPWallet wallet;

  final ValueChanged<String> nameChangeSuccessCallBack;

  @override
  _TPPurseSettingPageState createState() => _TPPurseSettingPageState();
}

class _TPPurseSettingPageState extends State<TPPurseSettingPage> {
  List titles;

  TPSettingModelManager _manager;

  bool hasMnemonicWord = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TPSettingModelManager();

    if (widget.wallet.mnemonic.length != null && widget.wallet.mnemonic.length > 0){
      hasMnemonicWord = true;
      titles = [ I18n.of(navigatorKey.currentContext).changeWalletName,I18n.of(navigatorKey.currentContext).backupWalletMnemonicWord,I18n.of(navigatorKey.currentContext).exportPrivateKey,I18n.of(navigatorKey.currentContext).deleteWallet,I18n.of(navigatorKey.currentContext).levelDescription];
    }else{
      hasMnemonicWord = false;
      titles = [ I18n.of(navigatorKey.currentContext).changeWalletName,I18n.of(navigatorKey.currentContext).exportPrivateKey,I18n.of(navigatorKey.currentContext).deleteWallet,I18n.of(navigatorKey.currentContext).levelDescription];
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_setting_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).walletSetting),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          return TPPurseSettingCell(
            title: titles[index],
            didClickCallBack: () {
              if (index == 0) {
                changePurseName(context);
              } else if (index == 1) {
                if (hasMnemonicWord){
                  _backUpMnemonicWord();
                } else{
                  _getPrivateKey();
                }
              } else if (index == 2) {
                if (hasMnemonicWord){
                  _getPrivateKey();
                }else{
                  _deletePurse(context);
                }
              } else if(index == 3){
                if (hasMnemonicWord){
                  _deletePurse(context);
                }else{
                  _jumpLevelPage();
                }
              }else{
                _jumpLevelPage();
              }
            },
          );
        });
  }

  void _jumpLevelPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPurseLevelDescPage()));
  }

  void _backUpMnemonicWord(){
    jugeHavePassword(
                    context,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPPurseSeetingBackWordPage(
                                    wallet: widget.wallet,
                                  )));
                    },
                    TPCreatePursePageType.back,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPPurseSeetingBackWordPage(
                                    wallet: widget.wallet,
                                  )));
                    });
  }

  void _getPrivateKey(){
    jugeHavePassword(
                    context,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPExportKeyPage(
                                    wallet: widget.wallet,
                                  )));
                    },
                    TPCreatePursePageType.back,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPExportKeyPage(
                                    wallet: widget.wallet,
                                  )));
                    });
  }

  void changePurseName(BuildContext context) {
    String changeNameString = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TPAlertView(
            title: '修改钱包名称',
            type: TPAlertViewType.input,
            textEditingCallBack: (String text) {
              changeNameString = text;
            },
            didClickSureBtn: () {
              _changePurseName(context, changeNameString);
            },
          );
        });
  }

  void _changePurseName(BuildContext context, String name) {
    jugeHavePassword(
        context,
        () {
          _changePurseNameInDataBase(context, name);
        },
        TPCreatePursePageType.back,
        () {
          _changePurseNameInDataBase(context, name);
        });
  }

  void _changePurseNameInDataBase(BuildContext context, String newName) async {
    TPDataBaseManager dataBaseManager = TPDataBaseManager();
    widget.wallet.name = newName;
    await dataBaseManager.openDataBase();
    await dataBaseManager.changeWalletName(widget.wallet);
    await dataBaseManager.closeDataBase();
    for (TPWallet item in TPDataManager.instance.purseList) {
      if (item.id == widget.wallet.id) {
        item.name = newName;
        break;
      }
    }

    Fluttertoast.showToast(
        msg: '名字修改成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
    widget.nameChangeSuccessCallBack(newName);
  }

  void _deletePurse(BuildContext context) {
    jugeHavePassword(
        context,
        () {
          _deleteAlertAction(context);
        },
        TPCreatePursePageType.back,
        () {
          _deleteAlertAction(context);
        });
  }

  _deleteAlertAction(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TPAlertView(
            title: '警告',
            type: TPAlertViewType.normal,
            alertString: '确定要删除该钱包？',
            didClickSureBtn: () async {
              if (hasMnemonicWord){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPurseSeetingBackWordPage(wallet: widget.wallet,type: TPBackWordType.delete,verifySuccessCallBack: ()async{
                TPDataBaseManager dataBaseManager = TPDataBaseManager();
                await dataBaseManager.openDataBase();
                await dataBaseManager.deleteDataBase(widget.wallet);
                await dataBaseManager.closeDataBase();
                TPDataManager.instance.purseList.remove(widget.wallet);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TPDeletePurseSuccessPage()));
              },)));
              }else{
                TPDataBaseManager dataBaseManager = TPDataBaseManager();
                await dataBaseManager.openDataBase();
                await dataBaseManager.deleteDataBase(widget.wallet);
                await dataBaseManager.closeDataBase();
                TPDataManager.instance.purseList.remove(widget.wallet);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TPDeletePurseSuccessPage()));
              }
            },
          );
        });
  }
}
