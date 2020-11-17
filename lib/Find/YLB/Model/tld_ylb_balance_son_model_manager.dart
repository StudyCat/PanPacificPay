import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPYLBDetailProfitModel {
  TPYLBDetailProfitModel({
    this.totalProfit,
    this.lastProfit,
    this.profitRate,
    this.totalCount,
    this.transferCount,
  });

  factory TPYLBDetailProfitModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPYLBDetailProfitModel(
              totalProfit: asT<String>(jsonRes['totalProfit']),
              lastProfit: asT<String>(jsonRes['lastProfit']),
              profitRate: asT<String>(jsonRes['profitRate']),
              totalCount: asT<String>(jsonRes['totalCount']),
              transferCount: asT<String>(jsonRes['transferCount']),
            );

  String totalProfit;
  String lastProfit;
  String profitRate;
  String totalCount;
  String transferCount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'totalProfit': totalProfit,
        'lastProfit': lastProfit,
        'profitRate': profitRate,
        'totalCount': totalCount,
        'transferCount': transferCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPYLBProfitRateModel {
  TPYLBProfitRateModel({
    this.rate,
    this.type,
  });

  factory TPYLBProfitRateModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPYLBProfitRateModel(
              rate: asT<String>(jsonRes['rate']),
              type: asT<int>(jsonRes['type']),
            );

  String rate;
  int type;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rate': rate,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPYLBBalanceSonModelManager {
  void getDetailProfitInfo(int type, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'type': type}, 'ylb/ylbAccountDetail');
    request.postNetRequest((value) {
      success(TPYLBDetailProfitModel.fromJson(value));
    }, (error) => failure(error));
  }

  void rollIn(int type, String walletAddress, String amount, Function success,
      Function failure) {
    TPBaseRequest request = TPBaseRequest(
        {'type': type, 'walletAddress': walletAddress, 'tldCount': amount},
        'ylb/ylbTransferIn');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

  void rollOut(int type, String walletAddress, String amount, Function success,
      Function failure) {
    TPBaseRequest request = TPBaseRequest(
        {'type': type, 'walletAddress': walletAddress, 'tldCount': amount},
        'ylb/ylbTransferOut');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void getMaxRollOut(int type, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'type': type}, 'ylb/maxTransferOut');
    request.postNetRequest((value) {
      success(value['maxCount']);
    }, (error) => failure(error));
  }

  void getProfitRate(Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({}, 'ylb/transferInRate');
    request.postNetRequest((value) {
        List result = [];
      for (Map item in value) {
        result.add(TPYLBProfitRateModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getTabName(Function success, Function failure){
    TPBaseRequest request =
        TPBaseRequest({}, 'ylb/ylbTab');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}
