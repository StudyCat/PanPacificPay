import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_notice_cell.dart';
import 'package:dragon_sword_purse/Find/BindInvitePeople/model/tp_bind_invite_model_manager.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

class TPBindInvitePeoplePage extends StatefulWidget {
  TPBindInvitePeoplePage({Key key}) : super(key: key);

  @override
  _TPBindInvitePeoplePageState createState() => _TPBindInvitePeoplePageState();
}

class _TPBindInvitePeoplePageState extends State<TPBindInvitePeoplePage> {
  TextEditingController _inviteController;

  TPBindInviteModelManager _modelManager;

  String _inviteCode = '';

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPBindInviteModelManager();

    _inviteController = TextEditingController();
  }

  void _bindInviteCode(){
    if (_inviteCode.length == 0){
      Fluttertoast.showToast(msg: '请填写邀请码');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.bindInviteCode(_inviteCode,(){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '绑定推广码成功');
      Navigator.of(context).pop();
    }, (TPError error){
      if (mounted){
        setState(() {
        _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading,child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
          backgroundColor: Color.fromARGB(255, 242, 242, 242),
          border: Border.all(
            color: Color.fromARGB(0, 0, 0, 0),
          ),
          heroTag: 'bind_invite_people',
          transitionBetweenRoutes: false,
          middle: Text('绑定推荐人'),),
    );
  }

  Widget _getBodyWidget() {
    return Column(
      children: <Widget>[
        TPAAAPlusStarNoticeCell(noticeCotent: '推荐人只能绑定一次!'),
        _getInputWidget()
      ],
    );
  }

  Widget _getInputWidget() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Column(
            children: <Widget>[
              _getTextField(),
              Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(40),
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        ScreenUtil().setWidth(140),
                    height: ScreenUtil().setHeight(80),
                    child: CupertinoButton(
                      child: Text(
                        '绑定',
                        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                      ),
                      onPressed: () {
                        _bindInviteCode();
                      },
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(0),
                    ),
                  ))
            ],
          )),
    );
  }

  Widget _getTextField() {
    return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            top: ScreenUtil().setWidth(40)),
        child: Container(
          alignment: Alignment.topCenter,
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(255, 242, 242, 242),
          ),
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width -
                  ScreenUtil().setWidth(300),
              child: CupertinoTextField(
                controller: _inviteController,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(20)),
                placeholder: '请输入邀请码',
                placeholderStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153),
                    height: 1.1),
                inputFormatters: [TPAmountTextInputFormatter()],
                onChanged: (String text){
                  _inviteCode = text;
                },
              ),
            ),
              Padding(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(10),right:0,top: 0,bottom: 0),
                child: Container(
                 width: ScreenUtil().setWidth(100),
                 height: ScreenUtil().setHeight(80),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),  
                   child: Icon(IconData(0xe606,fontFamily : 'appIconFonts'),color: Theme.of(context).primaryColor,),
                   onPressed: () async{
                     await _scanPhoto();
                   }),
               ),
        )
          ]),
        ));
  }

   Future _scanPhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TPScanQrCodePage(
                  scanCallBack: (String result) {
                    _modelManager.getInvationCodeFromQrCode(result,
                        (String inviteCode) {
                      _inviteController.text = inviteCode;
                      _inviteCode = inviteCode;
                    }, (TPError error) {
                      Fluttertoast.showToast(
                          msg: error.msg,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1);
                    });
                  },
                )));
   }
}
