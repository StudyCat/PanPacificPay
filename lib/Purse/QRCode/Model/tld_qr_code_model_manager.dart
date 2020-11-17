


import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPQrCodeModelManager{
  void getTransferQrCode(String walletAddress,Function(String) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress' : walletAddress},'wallet/getTransferQrCode');
    request.postNetRequest((value) {
      String qrCode = value['transferQrCode'];
      success(qrCode);
    }, (error) => failure(error));
  }
}