import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPMerchantInfoModel {
  TPMerchantInfoModel({
    this.realName,
    this.merchantPrivateKey,
    this.merchantId,
    this.apiDocUrl,
    this.appName,
    this.walletAddress,
    this.walletPrivateKey
  });

  factory TPMerchantInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPMerchantInfoModel(
              realName: asT<String>(jsonRes['realName']),
              merchantPrivateKey: asT<String>(jsonRes['merchantPrivateKey']),
              merchantId: asT<String>(jsonRes['merchantId']),
              apiDocUrl: asT<String>(jsonRes['apiDocUrl']),
              appName: asT<String>(jsonRes['appName']),
              walletAddress : asT<String>(jsonRes['walletAddress']),
              walletPrivateKey: asT<String>(jsonRes['walletPrivateKey'])
            );

  String realName;
  String merchantPrivateKey;
  String merchantId;
  String apiDocUrl;
  String appName;
  String walletAddress;
  String walletPrivateKey;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'realName': realName,
        'merchantPrivateKey': merchantPrivateKey,
        'merchantId': merchantId,
        'apiDocUrl': apiDocUrl,
        'appName': appName,
        'walletPrivateKey' : walletPrivateKey,
        'walletAddress':walletAddress
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPMerchantInfoModelManager{
  void getMerchantInfo(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'merchant/merchantInfo');
    request.postNetRequest((value) {
      success(TPMerchantInfoModel.fromJson(value));
    }, (error) => failure(error));
  }
}
