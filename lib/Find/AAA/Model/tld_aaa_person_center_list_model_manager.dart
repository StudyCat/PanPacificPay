import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;


T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPAAAUpgradeListModel {
  TPAAAUpgradeListModel({
    this.fromNickName,
    this.toNickName,
    this.curLevelIcon,
    this.nextLevelIcon,
    this.tldCount,
    this.createTime,
    this.isAdd
  });

  factory TPAAAUpgradeListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPAAAUpgradeListModel(
              fromNickName: asT<String>(jsonRes['fromNickName']),
              toNickName: asT<String>(jsonRes['toNickName']),
              curLevelIcon: asT<String>(jsonRes['curLevelIcon']),
              nextLevelIcon: asT<String>(jsonRes['nextLevelIcon']),
              tldCount: asT<String>(jsonRes['tldCount']),
              createTime: asT<int>(jsonRes['createTime']),
              isAdd:  asT<bool>(jsonRes['isAdd'])
            );

  String fromNickName;
  String toNickName;
  String curLevelIcon;
  String nextLevelIcon;
  String tldCount;
  int createTime;
  bool isAdd;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fromNickName': fromNickName,
        'toNickName': toNickName,
        'curLevelIcon': curLevelIcon,
        'nextLevelIcon': nextLevelIcon,
        'tldCount': tldCount,
        'createTime': createTime,
        'isAdd' : isAdd
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAAAPersonCenterListModelManager {
  void getUpgradeList(int type, int page, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest(
        {'type': type, 'pageNo': page, 'pageSize': 10}, 'aaa/upgradeLog');
    request.postNetRequest((value) {
      List upgradeList = value['list'];
      List result = [];
      for (Map item in upgradeList) {
        TPAAAUpgradeListModel pramaterModel = TPAAAUpgradeListModel.fromJson(item);
        result.add(pramaterModel);
      }
      success(result);
    }, (error) => failure(error));
  }
}
