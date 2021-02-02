import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPMissionBuyModel {
  TPMissionBuyModel({
    this.sellId,
    this.sellNo,
    this.totalCount,
    this.currentCount,
    this.max,
    this.maxAmount,
    this.payId,
    this.payMethodVO,
    this.sellerWalletAddress,
    this.createTime,
    this.avatar,
    this.nickName,
    this.showCurrentCount
  });

  factory TPMissionBuyModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPMissionBuyModel(
              sellId: asT<String>(jsonRes['sellId']),
              sellNo: asT<String>(jsonRes['sellNo']),
              totalCount: asT<String>(jsonRes['totalCount']),
              currentCount: asT<String>(jsonRes['currentCount']),
              max: asT<String>(jsonRes['max']),
              maxAmount: asT<String>(jsonRes['maxAmount']),
              payId: asT<int>(jsonRes['payId']),
              payMethodVO: TPPaymentModel.fromJson(
                  asT<Map<String, dynamic>>(jsonRes['payMethodVO'])),
              sellerWalletAddress: asT<String>(jsonRes['sellerWalletAddress']),
              createTime: asT<String>(jsonRes['createTime']),
              nickName : asT<String>(jsonRes['nickName']),
              avatar: asT<String>(jsonRes['avatar']),
              showCurrentCount : asT<bool>(jsonRes['showCurrentCount'])
            );

  String sellId;
  String sellNo;
  String totalCount;
  String currentCount;
  String max;
  String maxAmount;
  int payId;
  TPPaymentModel payMethodVO;
  String sellerWalletAddress;
  String createTime;
  String payImage;
  String avatar;
  String nickName;
  bool showCurrentCount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sellId': sellId,
        'sellNo': sellNo,
        'totalCount': totalCount,
        'currentCount': currentCount,
        'max': max,
        'maxAmount': maxAmount,
        'payId': payId,
        'payMethodVO': payMethodVO,
        'sellerWalletAddress': sellerWalletAddress,
        'createTime': createTime,
        'nickName' : nickName,
        'avatar' : avatar,
        'showCurrentCount' : showCurrentCount
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPTMissionUserInfoModel {
    TPTMissionUserInfoModel({
this.userLevelIcon,
this.curQuota,
this.totalQuota,
this.avatar,
this.platformModel
    });


  factory TPTMissionUserInfoModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:TPTMissionUserInfoModel(userLevelIcon : asT<String>(jsonRes['userLevelIcon']),
curQuota : asT<String>(jsonRes['curQuota']),
totalQuota : asT<String>(jsonRes['totalQuota']),
avatar: asT<String>(jsonRes['avatar']),
platformModel:asT<bool>(jsonRes['platformModel'])
);

  String userLevelIcon;
  String curQuota;
  String totalQuota;
  String avatar;
  bool platformModel;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userLevelIcon': userLevelIcon,
        'curQuota': curQuota,
        'totalQuota': totalQuota,
        'avatar' : avatar,
        'platformModel' :platformModel
};

  @override
String  toString() {
    return json.encode(this);
  }
}


class TPMissionListDoMissionModelManager {
  void getMissionList(int page, int payType,Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'pageNo': page, 'pageSize': 10,'payType':payType}, 'task/taskBuyList');
    request.postNetRequest((value) {
      TPTMissionUserInfoModel userInfoModel = TPTMissionUserInfoModel.fromJson(value['taskUserInfo']);
      List data = value['list'];
      List payTypeList = value['payTypeList'];
      List result = [];
      List payTypeResult = [];
      for (var item in data) {
        result.add(TPMissionBuyModel.fromJson(item));
      }
      for (var item in payTypeList) {
        payTypeResult.add(TPScreenPayTypeModel.fromJson(item));
      }
      success(userInfoModel,result,payTypeResult);
    }, (error) => failure(error));
  }

  void buyMission(TPBuyPramaterModel buyPramaterModel,Function success,Function failure){
     TPBaseRequest request =
        TPBaseRequest({'sellNo': buyPramaterModel.sellNo, 'tpCount': buyPramaterModel.buyCount,'walletAddress':buyPramaterModel.buyerAddress}, 'task/buyTask');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

    void getRate(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'order/getUsdRate');
    request.postNetRequest((value) {
      success(double.parse(value));
    }, (error) => failure(error));
  }

}
