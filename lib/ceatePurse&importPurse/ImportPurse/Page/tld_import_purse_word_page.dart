import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/View/tld_import_purse_input_word_textfield.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_import_purse_input_word_view.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_import_purse_success_page.dart';
import '../Model/tld_import_purse_model_manager.dart';

class TPImportPurseWordPage extends StatefulWidget {
  TPImportPurseWordPage({Key key,this.walletName}) : super(key: key);
 
  final String walletName;

  @override
  _TPImportPurseWordPageState createState() => _TPImportPurseWordPageState();
}

class _TPImportPurseWordPageState extends State<TPImportPurseWordPage> {
  List words;

  TPImportPurseModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TPImportPurseModelManager();

    words = [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(40)),
          child: Text(I18n.of(context).WriteDownThe12Mnemonic,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        TPImportPurseInputWordView(
          textFieldEditingWithIndexCallBack: (String text, int index) {
            words[index] = text;
          },
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(150),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                I18n.of(context).sureBtnTitle,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                bool isEmpty = false;
                for (String word in words) {
                  if (word.length == 0 || word == null) {
                    isEmpty = true;
                    break;
                  }
                }
                if (isEmpty) {
                  showDialog(context: context , builder : (context) => TPAlertView(title : '温馨提示',type : TPAlertViewType.normal ,alertString: '需要将助记词补满哦',didClickSureBtn: (){},));
                }else{
                  _manager.jugeMnemonicisLegal(words, (mnemonicString){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatingPursePage(walletName: widget.walletName,type: TPCreatingPursePageType.import,mnemonicString: mnemonicString,)));
                  }, (int value) {
                    String msg; 
                    if(value == 0){
                      msg = '助记词非法';
                    }else{
                      msg = '已拥有该钱包';
                    }
                     Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                  });
                }
              }),
        )
      ],
    )
    );
  }
}
