import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPUpgradeLevelDescModel {
  TPUpgradeLevelDescModel({
    this.taskUserLevel,
    this.taskQuota,
    this.levelIcon,
    this.remark,
    this.createTime,
    this.valid,
  });

  factory TPUpgradeLevelDescModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPUpgradeLevelDescModel(
              taskUserLevel: asT<int>(jsonRes['taskUserLevel']),
              taskQuota: asT<String>(jsonRes['taskQuota']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
              remark: asT<String>(jsonRes['remark']),
              createTime: asT<Object>(jsonRes['createTime']),
              valid: asT<bool>(jsonRes['valid']),
            );

  int taskUserLevel;
  String taskQuota;
  String levelIcon;
  String remark;
  Object createTime;
  bool valid;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'taskUserLevel': taskUserLevel,
        'taskQuota': taskQuota,
        'levelIcon': levelIcon,
        'remark': remark,
        'createTime': createTime,
        'valid': valid,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAccountUpgradeModelManager {
  void getAccountInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'task/taskUserInfo');
    request.postNetRequest((value) {
      List taskUserLevelList = value['taskUserLevelList'];
      List result = [];
      Map userInfoMap = value['taskUserInfo'];
      for (var item in taskUserLevelList) {
        result.add(TPUpgradeLevelDescModel.fromJson(item));
      }
      TPTMissionUserInfoModel userInfoModel = TPTMissionUserInfoModel.fromJson(userInfoMap);
      success(userInfoModel,result);
    }, (error) => failure(error));
  }

  void getUpgradeCondition(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({}, 'task/upgradeCondition');
    request.postNetRequest((value) {
      success(value['payCount'],value['content'],value['userLevelIcon']);
    }, (error) => failure(error));
  }

  void upgrade(String walletAddress,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':walletAddress}, 'task/upgradeTaskUserLevel');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
