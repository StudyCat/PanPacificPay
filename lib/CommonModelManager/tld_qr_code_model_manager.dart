

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

enum QRCodeType{
  redEnvelope,
  transfer,
  inviteCode
}

class TPQRcodeCallBackModel{
  var data;
  QRCodeType type;

  TPQRcodeCallBackModel({this.data,this.type});
}

class TPQRCodeModelManager{
  void scanQRCodeResult(String qrCode,Function success,Function failure){
    try{
    if (qrCode.contains('isTP')){
      Uri url = Uri.parse(qrCode);
      if (url.queryParameters['codeType'] != null){
        QRCodeType type;
        if (int.parse(url.queryParameters['codeType']) == 1){
          type = QRCodeType.redEnvelope;
          if (url.queryParameters['redEnvelopeId'] != null){
            String redEnvelopeId = url.queryParameters['redEnvelopeId'];
            
            success(TPQRcodeCallBackModel(data:redEnvelopeId,type: type));
          }else{
            TPError error = TPError(500,'无法识别的二维码');
            failure(error);
          }
        }else if (int.parse(url.queryParameters['codeType']) == 2){
          type = QRCodeType.transfer;
          if (url.queryParameters['walletAddress'] != null){
            String walletAddress = url.queryParameters['walletAddress'];
            
            success(TPQRcodeCallBackModel(data:walletAddress,type: type));
          }else{
            TPError error = TPError(500,'无法识别的二维码');
            failure(error);
          }
        }else if (int.parse(url.queryParameters['codeType']) == 3){
           type = QRCodeType.inviteCode;
          if (url.queryParameters['inviteCode'] != null){
            String inviteCode = url.queryParameters['inviteCode'];
            
            success(TPQRcodeCallBackModel(data:inviteCode,type: type));
          }else{
            TPError error = TPError(500,'无法识别的二维码');
            failure(error);
          }
        }
      }else{
        TPError error = TPError(500,'无法识别的二维码');
        failure(error);
      }
    }else{
      TPError error = TPError(500,'无法识别的二维码');
      failure(error);
    }
    }catch(e){
      TPError error = TPError(501,'识别二维码错误');
      failure(error);
    }
  }


}