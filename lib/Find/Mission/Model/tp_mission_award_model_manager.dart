import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;
import 'tp_mission_list_do_mission_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPMissionBuyDealDetailsModel {
  TPMissionBuyDealDetailsModel({
    this.id,
    this.txType,
    this.acptUserId,
    this.orderNo,
    this.txCount,
    this.remark,
    this.createTime,
    this.valid,
  });

  factory TPMissionBuyDealDetailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPMissionBuyDealDetailsModel(
              id: asT<int>(jsonRes['id']),
              txType: asT<int>(jsonRes['txType']),
              acptUserId: asT<int>(jsonRes['acptUserId']),
              orderNo: asT<String>(jsonRes['orderNo']),
              txCount: asT<Object>(jsonRes['txCount']),
              remark: asT<String>(jsonRes['remark']),
              createTime: asT<int>(jsonRes['createTime']),
              valid: asT<bool>(jsonRes['valid']),
            );

  int id;
  int txType;
  int acptUserId;
  String orderNo;
  Object txCount;
  String remark;
  int createTime;
  bool valid;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'txType': txType,
        'acptUserId': acptUserId,
        'orderNo': orderNo,
        'txCount': txCount,
        'remark': remark,
        'createTime': createTime,
        'valid': valid,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPMissionAwardPoolInfoModel {
  TPMissionAwardPoolInfoModel({
    this.profitPoolCount,
    this.levelIcon,
    this.profitRate,
  });

  factory TPMissionAwardPoolInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPMissionAwardPoolInfoModel(
              profitPoolCount: asT<String>(jsonRes['profitPoolCount']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
              profitRate: asT<String>(jsonRes['profitRate']),
            );

  String profitPoolCount;
  String levelIcon;
  String profitRate;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'profitPoolCount': profitPoolCount,
        'levelIcon': levelIcon,
        'profitRate': profitRate,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPMissionAwardModelManager {
  void getAwardPoolInfo(int page, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest(
        {'pageNo': page, 'pageSize': 10}, 'task/profitPoolDetail');
    request.postNetRequest((value) {
      TPTMissionUserInfoModel userInfoModel = TPTMissionUserInfoModel.fromJson(value['taskUserInfo']);
      TPMissionAwardPoolInfoModel awardPoolInfoModel = TPMissionAwardPoolInfoModel.fromJson(value['profitPoolInfo']);
      List detailsList = value['list'];
      List result = [];
      for (var item in detailsList) {
        result.add(TPMissionBuyDealDetailsModel.fromJson(item));
      }
      success(userInfoModel,awardPoolInfoModel,result);
    }, (error) => failure(error));
  }

  void exCharge(String amount,String walletAddress,Function success,Function failure){
     TPBaseRequest request = TPBaseRequest(
        {'num': amount, 'walletAddress': walletAddress}, 'task/exchangeProfit');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}
