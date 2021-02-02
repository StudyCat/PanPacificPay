import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TPAcceptanceLoginPramater {
  String inviteCode;
  String tel;
  String telCode;
  String walletAddress;
}

class TPAcceptanceLoginModelManager {
  void getMessageCode(String cellPhoneNum, String walletAddress,
      Function() success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest(
        {'tel': cellPhoneNum, 'walletAddress': walletAddress},
        'common/getRegisterTelCode');
    request.isNeedSign = true;
    request.walletAddress = walletAddress;
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void loginWithPramater(TPAcceptanceLoginPramater pramater,
      Function(String) suceess, Function(TPError) failure) {
    String imUserName = TPDataManager.instance.username;
    TPBaseRequest request = TPBaseRequest({
      'tel': pramater.tel,
      'inviteCode': pramater.inviteCode,
      'telCode': pramater.telCode,
      'walletAddress': pramater.walletAddress,
      'TPUserName': imUserName
    }, 'acpt/user/registerAcptUser');
    request.postNetRequest((value) async {
      String token = value['jwtToken'];
      TPDataManager.instance.acceptanceToken = token;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('acceptanceToken', token);
      suceess(token);
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
