import 'dart:typed_data';
import 'dart:ui';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_page.dart';
import 'package:dragon_sword_purse/tld_tabbar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import '../View/tld_purse_setting_backup_word_gridview.dart';
import 'tld_verify_word_page.dart';

enum TPBackWordType{
  normal,
  delete,
  create
}

class TPPurseSeetingBackWordPage extends StatefulWidget {
  TPPurseSeetingBackWordPage({Key key,this.wallet,this.type = TPBackWordType.normal,this.verifySuccessCallBack}) : super(key: key);

  final TPBackWordType type;

  final TPWallet wallet;

  final Function verifySuccessCallBack;
  @override
  _TPPurseSeetingBackWordPageState createState() => _TPPurseSeetingBackWordPageState();
}

class _TPPurseSeetingBackWordPageState extends State<TPPurseSeetingBackWordPage> {
  List _words;

  GlobalKey repainKey = GlobalKey();

  bool _isLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _words = widget.wallet.mnemonic.split(' ');

    _checkIsLogin();
  }

  void _checkIsLogin() async {
    var token = await TPDataManager.instance.getAcceptanceToken();
    setState(() {
      _isLogin = token != null; 
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_setting_backup_word_page',
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: widget.type != TPBackWordType.create,
        middle: Text(I18n.of(context).walletSetting),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
          child : _getBodyWidget(context)
        ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
      Size size = MediaQuery.of(context).size;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding : EdgeInsets.only(top : ScreenUtil().setHeight(140),left: ScreenUtil().setWidth(30)),
            width: size.width - ScreenUtil().setWidth(60),
            child: Text(I18n.of(context).WriteDownThe12Mnemonic,style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.center,),
          ),
          RepaintBoundary(
            key: repainKey,
            child: Column(
              children : <Widget>[
                Container(
                  height : ScreenUtil().setHeight(280),
                  child : STDPurseSettingBackupWordGridView(words: _words,),
                ),
                Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(236),height: ScreenUtil().setHeight(54),alignment: Alignment.center,),
                ),
                Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: Text(I18n.of(context).WalletAddress + '：${widget.wallet.address}',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 57, 57, 57)),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                  child: Text(I18n.of(context).PleaseKeepItSafe,style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 208, 2, 27)),),
                )
              ]
            )   
          ),
          Container(
            width: size.width - ScreenUtil().setWidth(200),
            margin: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text(widget.type == TPBackWordType.create ? I18n.of(context).done:I18n.of(context).next,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: () async {
              if (widget.type == TPBackWordType.create) {
                Uint8List data = await _capturePng();
                await _saveQrCodeImage(data);
                Widget nextPage = _isLogin ? TPTabbarPage() : TPRegisterView();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => nextPage), (route) => route == null);
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPVerifyWordPage(words: _words,type: widget.type,verifySuccessCallBack: widget.verifySuccessCallBack,)));
              }
            }), 
          ),
        ],
      );
  }

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          repainKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format:  ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;//这个对象就是图片数据
    } catch (e) {
      print(e);
    }
    return null;
  }

   Future _saveQrCodeImage(Uint8List bytes) async{
    // Map<PermissionStatusGetters>
    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    var result = await ImageGallerySaver.saveImage(bytes);
    if (result != null){
      Fluttertoast.showToast(msg: '保存助记词成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }else{
      Fluttertoast.showToast(msg: '保存助记词失败',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }
  }
}