
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/register&login/Model/tld_register_model_manager.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_invite_code_page.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_bottom_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_header_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_input_cell.dart';
import 'package:dragon_sword_purse/register&login/View/tld_register_verify_code_cell.dart';
import 'package:dragon_sword_purse/tld_not_purse_page.dart';
import 'package:dragon_sword_purse/tld_tabbar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TPRegisterView extends StatefulWidget {
  TPRegisterView({Key key}) : super(key: key);

  @override
  _TPRegisterViewState createState() => _TPRegisterViewState();
}

class _TPRegisterViewState extends State<TPRegisterView> {
  TPRegisterPramater _pramater;

  TPRegisterModelManager _modelManager;

  bool _isLoading = false;

  TextEditingController _inviteController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getPurseList();

    _inviteController = TextEditingController();

    _pramater = TPRegisterPramater();

    _modelManager = TPRegisterModelManager();
  }

  void _getPurseList() async{
    TPDataBaseManager manager = TPDataBaseManager();
     await manager.openDataBase();
     List allPurse = await manager.searchAllWallet();
    await manager.closeDataBase();
    allPurse == null ? TPDataManager.instance.purseList = [] : TPDataManager.instance.purseList = List.from(allPurse);
  }

  void _sendTelCode(bool isVerify)async{
    var status = await Permission.phone.status;
    if (status == PermissionStatus.denied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: '请开启手机电话权限');
      return;
    }

    try{
    if (isVerify){
    List<SimCard> simCards = await MobileNumber.getSimCards;
    bool allHaveNumber = true;
    if (simCards == null){
       Fluttertoast.showToast(msg: '非法设备，你的手机未插入电话卡，请插入电话卡后再试。');
       return;
    }
    
    if (simCards.length == 0){
       Fluttertoast.showToast(msg: '非法设备，你的手机未插入电话卡，请插入电话卡后再试。');
       return;
    }

    for (SimCard item in simCards) {
        if (item.number == null){
          allHaveNumber = false;
          break;
        }

        if (item.number.length == 0){
          allHaveNumber = false;
          break;
        }
    }

    if (allHaveNumber){
     bool haveNumber = false;
     String cardNumStr= '';
     for (int i = 0; i < simCards.length;i++ ) {
       SimCard simCard = simCards[i];
       if (simCard.number.contains(_pramater.tel)){
         haveNumber = true;
         _pramater.mobileOperators = simCard.carrierName;
       }
       int cardNum = i + 1;
       String sonNumStr = '卡$cardNum :${simCard.number},';
       cardNumStr = cardNumStr + sonNumStr;
     }
     if (haveNumber == false){
       Fluttertoast.showToast(msg: '您当前手机的电话卡为：$cardNumStr  与你输入的不符合，请插入电话卡后再注册或者登录。');
      return;
     }

    }else{
      if (simCards.length == 0){
        Fluttertoast.showToast(msg: '非法设备，你的手机未插入电话卡，请插入电话卡后再试。');
        return;
      }
      }
    }

    setState(() {
      _isLoading = true;
    });
    _modelManager.getMessageCode(_pramater.tel, (){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '获取验证码成功，请留意短信或者电话');
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg);
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
    });
    }catch(e){
      Fluttertoast.showToast(msg: '非法设备，你的手机未插入电话卡，请插入电话卡后再试。');
    }
  }

  void _register() {
    if (_pramater.tel == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterYourCellPhoneNumber);
      return;
    } 
    if (_pramater.telCode == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterVerifyCode);
      return;
    }
    if (_pramater.telCode == null){
      Fluttertoast.showToast(msg: I18n.of(context).pleaseEnterYourNickName);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.register(_pramater, (String token) async {
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      TPDataManager.instance.acceptanceToken = token;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('acceptanceToken', token);
      if (TPDataManager.instance.purseList.length > 0){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TPTabbarPage()), (route) => route == null);
      }else{
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => TPNotPurseHomePage()), (route) => route == null);
      }
    }, (TPError error){
       if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
     if (error.code == -3){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TPRegisterInviteCodePage(pramater: _pramater,)));
     }else{
        Fluttertoast.showToast(msg: error.msg);
     }
    });
  }

  void _getSimVerify(){
    _modelManager.openSimVerify((bool isVerify){
      _sendTelCode(isVerify);
    },(TPError error){
      _sendTelCode(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'register_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).register),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TPRegisterHeaderCell();
      }else if(index < 3){
        String placeholder;
        if (index == 1){
          placeholder = I18n.of(context).pleaseEnterYourCellPhoneNumber;
        }else{
          placeholder = I18n.of(context).pleaseEnterYourNickName;
        }
        return TPRegisterInputCell(placeHolder : placeholder,index: index,textDidChangeCallBack: (String text,int index){
          if (index == 1){
            _pramater.tel = text;
          }else{
            _pramater.nickname = text;
          }
        },);
      }else if (index == 3){
        return TPRegisterVerifyCodeCell(didClickSendCodeBtnCallBack: (){
          _getSimVerify();
        },codeDidChangeCallBack: (str){
          _pramater.telCode = str;
        },
        );
      }else if (index == 4){
         return Padding(
           padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
           child: Container(
             height : ScreenUtil().setHeight(110),
             child : Column(
               children: <Widget>[
                 _inviteCodeRowWidget(),
                 Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child:  Divider(
              height: ScreenUtil().setHeight(2),
              color: Color.fromARGB(255, 221, 221, 221),
            ),
          )
               ],
             )
           ),
         );
      }
      return TPRegisterBottomCell(
        didClickNextCallBack: (){
          _register();
        },
      );
     },
    );
  }

  Widget _inviteCodeRowWidget(){
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(400),
                child: CupertinoTextField(
                  controller: _inviteController,
                  padding: EdgeInsets.zero,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color.fromARGB(255, 51, 51, 51)),
                  placeholderStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color.fromARGB(255, 153, 153, 153)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                  ),
                  placeholder: '请输入邀请码(选填)',
                  onChanged: (str){
                    _pramater.inviteCode = str;
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
        )]);
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
                      _pramater.inviteCode = inviteCode;
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