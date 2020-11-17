import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_person_center_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPAAATeamModel {
  TPAAATeamModel({
    this.aaaLevel,
    this.size,
    this.lock,
    this.teamList,
    this.levelIcon,
    this.isNeedUpgrade = false,
    this.isOpen = false
  });

  factory TPAAATeamModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TPAAATeamListModel> teamList =
        jsonRes['teamList'] is List ? <TPAAATeamListModel>[] : null;
    if (teamList != null) {
      for (final dynamic item in jsonRes['teamList']) {
        if (item != null) {
          teamList.add(
              TPAAATeamListModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TPAAATeamModel(
      aaaLevel: asT<int>(jsonRes['aaaLevel']),
      size: asT<int>(jsonRes['size']),
      lock: asT<bool>(jsonRes['lock']),
      teamList: teamList,
      levelIcon: asT<String>(jsonRes['levelIcon']),
      isNeedUpgrade: false,
      isOpen: false
    );
  }

  int aaaLevel;
  int size;
  bool lock;
  List<TPAAATeamListModel> teamList;
  String levelIcon;
  bool isOpen; // 是否展开
  bool isNeedUpgrade;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'aaaLevel': aaaLevel,
        'size': size,
        'lock': lock,
        'teamList': teamList,
        'levelIcon': levelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAAATeamListModel {
  TPAAATeamListModel({
    this.nickName,
    this.aaaUserId,
  });

  factory TPAAATeamListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPAAATeamListModel(
              nickName: asT<String>(jsonRes['nickName']),
              aaaUserId: asT<int>(jsonRes['aaaUserId']),
            );

  String nickName;
  int aaaUserId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'aaaUserId': aaaUserId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAAAFriendTeamModelManager {
  void getTeamInfo(Function success,Function failure) {
    TPBaseRequest request = TPBaseRequest({},"aaa/teamList");
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TPAAATeamModel.fromJson(item));
      }
      for (TPAAATeamModel item in result) {
        if (item.lock == true){
          item.isNeedUpgrade = true;
          break;
        }
      }
      success(result);
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
}
