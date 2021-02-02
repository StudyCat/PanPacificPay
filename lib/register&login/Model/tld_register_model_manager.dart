

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TPRegisterPramater {
  String inviteCode;
  String tel;
  String telCode;
  String nickname;
  String mobileOperators;
  String loginPassword;
}

class TPRegisterModelManager{

  void register(TPRegisterPramater pramater,Function success,Function failure){
    String registerId = TPDataManager.instance.registrationID;
    String password = TPDataManager.instance.password;
    TPWallet wallet = TPDataManager.instance.purseList.first;
    Map pramaterMap = {
      // 'code':pramater.telCode,
      'loginPassword' : pramater.loginPassword,
      'nickName':pramater.nickname,'registrationId' : registerId,'password' : password,'tel':pramater.tel,'type' : wallet.type,'walletAddress' : wallet.address};
    if (pramater.inviteCode != null){
      pramaterMap.addEntries({'inviteCode' : pramater.inviteCode}.entries);
    }
    if (pramater.mobileOperators != null){
      pramaterMap.addEntries({'mobileOperators' : pramater.mobileOperators}.entries);
    }
    TPBaseRequest request = TPBaseRequest(pramaterMap,'tldUser/registerTldUser');
    request.postNetRequest((value) async {
      String token = value['jwtToken'];

      String userToken = value['token'];
      String username = value['imUserName'];
      SharedPreferences perference = await SharedPreferences.getInstance();
      perference.setString('userToken',userToken);
      TPDataManager.instance.userToken = userToken;
      perference.setString('username', username);

      success(token);
    }, (error) => failure(error));
  }

    void getMessageCode(String cellPhoneNum,
      Function() success, Function(TPError) failure) {
    TPWallet wallet = TPDataManager.instance.purseList.first;
    String regsterId = TPDataManager.instance.registrationID;
    TPBaseRequest request = TPBaseRequest(
        {'tel': cellPhoneNum,'walletAddress' : wallet.address,'registrationId' : regsterId},
        'common/getRegisterTelCode');
    request.isNeedSign = true;
    request.walletAddress = wallet.address;
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void openSimVerify(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'common/isOpenSimVerify');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

    void getInvationCodeFromQrCode(
      String qrCode, Function(String) success, Function(TPError) failure) {
    if (qrCode.contains('isTPQRCode')) {
      if (qrCode.contains('inviteCode')) {
        Uri uri = Uri.parse(qrCode);
        String walletAddress = uri.queryParameters['inviteCode'];
        success(walletAddress);
      } else {
        TPError error = TPError(1000, '未知的二维码');
        failure(error);
      }
    } else if (qrCode.contains('isTP')) {
      Uri url = Uri.parse(qrCode);
      if (url.queryParameters['codeType'] != null) {
        if (int.parse(url.queryParameters['codeType']) == 3) {
          if (url.queryParameters['inviteCode'] != null) {
            String inviteCode = url.queryParameters['inviteCode'];
            success(inviteCode);
          } else {
            TPError error = TPError(500, '无法识别的二维码');
            failure(error);
          }
        }
      } else {
        TPError error = TPError(500, '无法识别的二维码');
        failure(error);
      }
    } else {
      TPError error = TPError(1000, '未知的二维码');
      failure(error);
    }
  }

}