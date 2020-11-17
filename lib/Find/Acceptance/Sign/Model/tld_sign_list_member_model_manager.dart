import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPSignMemberModel {
  TPSignMemberModel({
    this.nickName,
    this.signProfitCount,
    this.createTime,
  });

  factory TPSignMemberModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPSignMemberModel(
              nickName: asT<String>(jsonRes['nickName']),
              signProfitCount: asT<String>(jsonRes['signProfitCount']),
              createTime: asT<int>(jsonRes['createTime']),
            );

  String nickName;
  String signProfitCount;
  int createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'signProfitCount': signProfitCount,
        'createTime': createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPSignListMemberModelManager {
  void getSignList(int page, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest(
        {'pageNo': page, 'pageSize': 10}, 'acpt/user/teamSignList');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        TPSignMemberModel model = TPSignMemberModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}
