import 'dart:ffi';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPAAAUpgradeInfoModel {
  TPAAAUpgradeInfoModel({
    this.curLevel,
    this.fullTldCount,
    this.nextLevelIcon,
    this.nextLevel,
    this.nextTldCount,
    this.curLevelIcon,
  });

  factory TPAAAUpgradeInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPAAAUpgradeInfoModel(
              curLevel: asT<int>(jsonRes['curLevel']),
              fullTldCount: asT<String>(jsonRes['fullTldCount']),
              nextLevelIcon: asT<String>(jsonRes['nextLevelIcon']),
              nextLevel: asT<int>(jsonRes['nextLevel']),
              nextTldCount: asT<String>(jsonRes['nextTldCount']),
              curLevelIcon: asT<String>(jsonRes['curLevelIcon']),
            );

  int curLevel;
  String fullTldCount;
  String nextLevelIcon;
  int nextLevel;
  String nextTldCount;
  String curLevelIcon;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'curLevel': curLevel,
        'fullTldCount': fullTldCount,
        'nextLevelIcon': nextLevelIcon,
        'nextLevel': nextLevel,
        'nextTldCount': nextTldCount,
        'curLevelIcon': curLevelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAAAPersonFriendCenterModelManager {
  void getUserInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'aaa/accountInfo');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0) {
        success(TPAAAUserInfo());
      } else {
        success(TPAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

  void getFutureProfit(Function success, Function failure){
     TPBaseRequest request = TPBaseRequest({}, 'aaa/loadingFutureProfit');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

  void getUpgradeInfo(Function success, Function failure){
    TPBaseRequest request = TPBaseRequest(
        {}, 'aaa/nextLevelInfo');
    request.postNetRequest((value) {
      success(TPAAAUpgradeInfoModel.fromJson(value));
    }, (error) => failure(error));
  }

  void upgrade(
      int type, String walletAddress,int paymentType,int ylbType,Function success, Function failure) {
    Map pramaters;
    if (paymentType == 1){
      pramaters = {'type': type, 'walletAddress': walletAddress,'payType':paymentType};
    }else{
      pramaters = {'type': type, 'ylbType': ylbType,'payType':paymentType};
    }
    TPBaseRequest request = TPBaseRequest(
        pramaters, 'aaa/upgrade');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void recieve(String walletAddress,Function success, Function failure){
    TPBaseRequest request = TPBaseRequest(
        {'walletAddress' : walletAddress}, 'aaa/receive');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
