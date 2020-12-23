import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Model/tld_import_purse_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_import_purse_success_page.dart';
import '../../CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPImportPurseKeyPage extends StatefulWidget {
  TPImportPurseKeyPage({Key key,this.walletName}) : super(key: key);

  final String walletName;

  @override
  _TPImportPurseKeyPageState createState() => _TPImportPurseKeyPageState();
}

class _TPImportPurseKeyPageState extends State<TPImportPurseKeyPage> {

  TextEditingController _controller;

  TPImportPurseModelManager _manager;

  String _keyString = ''; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TPImportPurseModelManager();
    _controller = TextEditingController();
    _controller.addListener((){
      _keyString = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(40)),
          child: Text(I18n.of(context).pleaseEnterYourPrivateKey,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              top: ScreenUtil().setHeight(20)),
          height: ScreenUtil().setHeight(288),
          width: size.width - ScreenUtil().setWidth(40),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
                color: Colors.white,
                child: CupertinoTextField(
                  controller: _controller,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                )),
          ),
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
                bool isEmpty = (_keyString.length == 0);
                if (isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => TPAlertView(
                            title: '温馨提示',
                            type: TPAlertViewType.normal,
                            alertString: '私钥不能为空',
                            didClickSureBtn: () {},
                          ));
                } else {
                   _manager.jugePrivateKeyLegal(_keyString, (privateKey){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatingPursePage(walletName: widget.walletName,type: TPCreatingPursePageType.import,privateKey: privateKey,)));
                  }, (int value) {
                    String msg; 
                    if(value == 0){
                      msg = '私钥非法';
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
    ));
  }



}
