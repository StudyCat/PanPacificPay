import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';

import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPRollOutAwardModel {
  TPRollOutAwardModel({
    this.min,
    this.max,
    this.awardRate,
    this.isNeedAward,
    this.totalTld,
  });

  factory TPRollOutAwardModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPRollOutAwardModel(
              min: asT<String>(jsonRes['min']),
              max: asT<String>(jsonRes['max']),
              awardRate: asT<String>(jsonRes['awardRate']),
              isNeedAward: asT<bool>(jsonRes['isNeedAward']),
              totalTld: asT<String>(jsonRes['totalTld']),
            );

  String min;
  String max;
  String awardRate;
  bool isNeedAward;
  String totalTld;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'min': min,
        'max': max,
        'awardRate': awardRate,
        'isNeedAward': isNeedAward,
        'totalTld': totalTld,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPRollOutPramaterModel {
  TPWalletInfoModel infoModel;
  String amount;
}

class TPRollOutModelManager {
  void getAwardInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({},'acpt/user/billTransferRate');
    request.postNetRequest((value) {
      success(TPRollOutAwardModel.fromJson(value));
    }, (error) => failure(error));
  }

  void rollOut(TPRollOutPramaterModel pramaterModel,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'toWalletAddress':pramaterModel.infoModel.walletAddress,'tsfCount':pramaterModel.amount},'acpt/user/billTransfer');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}
