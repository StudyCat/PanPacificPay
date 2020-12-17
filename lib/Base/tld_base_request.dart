import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:dragon_sword_purse/register&login/Page/tld_register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:uuid_enhanced/uuid.dart';
import 'package:web3dart/crypto.dart';
import 'package:simple_rsa2/simple_rsa2.dart';

class TPError{
  int code;
  String msg;

  TPError(int code,String msg){
    this.code = code;
    this.msg = msg;
  }
}


class TPBaseRequest{
  //120.92.141.131:8030 测试环境
  //192.168.1.120 本地环境
  //139.224.83.9:8030 生成环境
  //18.166.113.166:8030  新生产环境 
  //http://testtp.esbug.com:7000  测试环境

  static String baseUrl = 'http://192.168.1.120:8030/';
  Map pramatersMap;
  String subUrl;
  CancelToken cancelToken;
  bool isNeedSign;
  String walletAddress;

  final String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCF2Bviwh62uKqlN5uVETTzJEvfulFINwzm3RvKAl8APIe3uEQgt6CHAlzx40yMXqGMvsc+cUcAFRRoyKkvjUDlw5cELn2eBtvZ660uGxL/YB7y9zXLNisrJNu+lcqYBqwbIL3iMrpPXkOqwiiRfDkpvypwLMUl+1fAcWF+iS9BJQIDAQAB";


  TPBaseRequest(Map pramatersMap,String subUrl){
    this.pramatersMap = pramatersMap;
    this.subUrl = subUrl;
    cancelToken = CancelToken();
  }
  
  String _authorizationEncode(String userToken,int time,String uuid){
     var content = new Utf8Encoder().convert(userToken);
     var digest = md5.convert(content);
     String md5Str = hex.encode(digest.bytes);
  

     Map authorizationMap = {'userToken':md5Str,'time':time,'uuid':uuid};
     String jsonStr = jsonEncode(authorizationMap);
     var base64Content = utf8.encode(jsonStr);
     var base64Digest = base64Encode(base64Content);
     return base64Digest;
  }

  void getNetRequest(Function(String) success, Function(TPError) failure) async{
    try{
      Dio dio = Dio();
      String userToken = await TPDataManager.instance.getUserToken();
      String acceptanceToken = await TPDataManager.instance.getAcceptanceToken();
       Options options = Options(
        contentType : 'application/json', 
        receiveDataWhenStatusError: false,
     );
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      Map<String, dynamic> headers = {'version':version,};
       if (userToken != null){
        String language = TPDataManager.instance.currentLocal.languageCode;
        int time = DateTime.now().millisecondsSinceEpoch;
        String uuid = Uuid.randomUuid().toString();
        String authorization = _authorizationEncode(userToken, time, uuid);
        headers.addEntries({'authorization':authorization,'uuid':uuid,'userToken':userToken,"Language" : language,'time':time}.entries);
      }
      options.headers.addEntries(headers.entries);
      if (acceptanceToken != null){
        options.headers.addEntries({'jwtToken':acceptanceToken}.entries);
      }

      String pramaterStr = await _encryptPramater();

     Response response = await dio.get(baseUrl+this.subUrl,queryParameters:{'parameter':pramaterStr} ,options: options,cancelToken: cancelToken);
     String jsonString = response.data;
     Map responseMap = jsonDecode(jsonString);
     String codeStr = responseMap['code'];
     String dataStr = responseMap['data'];
     if(int.parse(codeStr) == 200){
       success(dataStr);
     }else{
        if (int.parse(codeStr) == -2 || int.parse(codeStr) == -4){
         _logout(int.parse(codeStr), responseMap['msg']);
       }
       TPError error = TPError(int.parse(codeStr),responseMap['msg']);
       failure(error);
     }
    }catch(e){
      TPError error = TPError(400,'您的网络异常');
       failure(error);
    }
  }

  void postNetRequest(ValueChanged<dynamic> success, Function(TPError) failure) async{
    try{
      String userToken = await TPDataManager.instance.getUserToken();
      String acceptanceToken = await TPDataManager.instance.getAcceptanceToken();
      BaseOptions options = BaseOptions(
        contentType : 'application/json',
        receiveDataWhenStatusError: false
     );
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      Map<String, dynamic> headers = {'version':version,};
       if (userToken != null){
        String language = TPDataManager.instance.currentLocal.languageCode;
        int time = DateTime.now().millisecondsSinceEpoch;
        String uuid = Uuid.randomUuid().toString();
        String authorization = _authorizationEncode(userToken, time, uuid);
        headers.addEntries({'authorization':authorization,'uuid':uuid,'userToken':userToken,"Language" : language,'time':time}.entries);
      }
      options.headers.addEntries(headers.entries);
      if (acceptanceToken != null){
        options.headers.addEntries({'jwtToken':acceptanceToken}.entries);
      }
      if (this.isNeedSign == true) {
        _sign();
      }
      Dio dio = Dio(options);
     String url = baseUrl + this.subUrl;

     String pramaterStr = await _encryptPramater();

     Response response = await dio.post(url,queryParameters: {'parameter':pramaterStr},cancelToken: cancelToken);
     Map responseMap = response.data;
     String codeStr = responseMap['code'];
     dynamic dataStr = responseMap['data'];
     if(int.parse(codeStr) == 200){
       success(dataStr);
     }else{
      if (int.parse(codeStr) == -2 || int.parse(codeStr) == -4){
         _logout(int.parse(codeStr), responseMap['msg']);
       }
       TPError error = TPError(int.parse(codeStr),responseMap['msg']);
       failure(error);
     }
    }catch(e){
      TPError error = TPError(400,'您的网络异常');
       failure(error);
    }
  }

  Future<String> _encryptPramater() async {
    String pramaterJson = jsonEncode(this.pramatersMap);

    
    return await encryptString(pramaterJson, publicKey);
       
  }


  void _sign(){
    TPWallet wallet;
    List purseList = TPDataManager.instance.purseList;
    for (TPWallet item in purseList) {
      if (item.address == this.walletAddress) {
        wallet = item;
      }
    }
    String pramaterStr = jsonEncode(this.pramatersMap);
    Uint8List privateKey = hexToBytes(wallet.privateKey);
    Uint8List messageHash = keccakUtf8(pramaterStr);
    MsgSignature signature = sign(messageHash, privateKey);
    Map signMap = {'r':signature.r.toString(),'v' : signature.v.toString(),'s':signature.s.toString()};
    String signStr = jsonEncode(signMap);
    this.pramatersMap.addEntries({'sign':signStr,'jsonStr':pramaterStr}.entries);
  } 


  void uploadFile(List datas,Function(List) success,Function(TPError) failure)async{
      BaseOptions options = BaseOptions(
        contentType : 'application/json',
        receiveDataWhenStatusError: false
     );
     String url = baseUrl + 'common/uploadFile';
      Dio dio = Dio(options);
      List uploadDatas = [];
      for (File item in datas) {
        String path = item.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        MultipartFile file = await MultipartFile.fromFile(item.path,filename: name);
        uploadDatas.add(file); 
      }
      FormData formData = FormData.fromMap({
        'files' : uploadDatas
      });
      Response response = await dio.post(url,data:formData,cancelToken: cancelToken);
      Map responseMap = response.data;
      String codeStr = responseMap['code'];
     Map dataStr = responseMap['data'];
     List fileUrlList = dataStr['list'];
     if(int.parse(codeStr) == 200){
       success(fileUrlList);
     }else{
       if (int.parse(codeStr) == -2 || int.parse(codeStr) == -4){
         _logout(int.parse(codeStr), responseMap['msg']);
       }
       TPError error = TPError(400,'您的网络异常');
       failure(error);
     }
  }

  void _logout(int code,String msg){
    // showDialog(context: navigatorKey.currentContext,builder: (context){
    //   return TPAlertView(title: '警告',type: TPAlertViewType.normal,alertString: msg,sureTitle: '重新登录',didClickSureBtn: (){
        TPDataManager.instance.deleteAcceptanceToken();
        navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TPRegisterView()), (route) => route == null);
      // },);
    // });
  }

  void cancelRequest(){
    cancelToken.cancel();
  } 

}