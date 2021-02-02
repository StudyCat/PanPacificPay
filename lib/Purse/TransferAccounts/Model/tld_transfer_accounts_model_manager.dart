import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonModelManager/tld_qr_code_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';

class TPTranferAmountPramaterModel {
  String chargeValue;
  String chargeWalletAddress;
  String fromWalletAddress;
  String toWalletAddress;
  String value;
  bool isRecharge;
}

class TPTransferAccountsModelManager {
  void getAddressFromQrCode(
      String qrCode, Function(String) success, Function(TPError) failure) {
    if (qrCode.contains('isTPQRCode')) {
      if (qrCode.contains('walletAddress')) {
        Uri uri = Uri.parse(qrCode);
        String walletAddress = uri.queryParameters['walletAddress'];
        success(walletAddress);
      } else {
        TPError error = TPError(500, '无法识别的二维码');
        failure(error);
      }
    } else if (qrCode.contains('isTP')) {
      Uri url = Uri.parse(qrCode);
      if (url.queryParameters['codeType'] != null) {
        if (int.parse(url.queryParameters['codeType']) == 2) {
          if (url.queryParameters['walletAddress'] != null) {
            String redEnvelopeId = url.queryParameters['walletAddress'];
            success(redEnvelopeId);
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
      TPError error = TPError(500, '无法识别的二维码');
      failure(error);
    }
  }

  void transferAmount(TPTranferAmountPramaterModel pramaterModel,
      Function(int) success, Function(TPError) failure) {
    Map pramaterMap = {
      'chargeValue': pramaterModel.chargeValue,
      'chargeWalletAddress': pramaterModel.chargeWalletAddress,
      'fromWalletAddress': pramaterModel.fromWalletAddress,
      'toWalletAddress': pramaterModel.toWalletAddress,
      'value': pramaterModel.value,
    };
    if (pramaterModel.isRecharge != null) {
      pramaterMap.addEntries({'type': 1}.entries);
    }
    TPBaseRequest request = TPBaseRequest(pramaterMap, 'wallet/transfer');
    request.isNeedSign = true;
    request.walletAddress = pramaterModel.fromWalletAddress;
    request.postNetRequest((dynamic value) {
      int txId = value['txId'];
      success(txId);
    }, (error) => failure(error));
  }

  void getWalletInfo(String walletAddress, Function(TPWalletInfoModel) success,
      Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest(
        {'walletAddress': walletAddress}, 'wallet/queryOneWallet');
    request.postNetRequest((value) {
      Map data = value;
      success(TPWalletInfoModel.fromJson(data));
    }, (error) => failure(error));
  }
}
