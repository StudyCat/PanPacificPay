
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPBindInviteModelManager{
      void getInvationCodeFromQrCode(
      String qrCode, Function(String) success, Function(TPError) failure) {
    if (qrCode.contains('http://www.tldollar.com')) {
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

  void bindInviteCode(String inviteCode ,Function success,Function failure){
       TPBaseRequest request = TPBaseRequest({'inviteCode':inviteCode}, 'acpt/user/bindInviteCode');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}