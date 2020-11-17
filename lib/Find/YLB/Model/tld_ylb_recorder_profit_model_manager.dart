import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPYLBProfitListModel {
  TPYLBProfitListModel({
    this.logId,
    this.tldCount,
    this.type,
    this.typeName,
    this.createTime,
  });

  factory TPYLBProfitListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPYLBProfitListModel(
              logId: asT<int>(jsonRes['logId']),
              tldCount: asT<String>(jsonRes['tldCount']),
              type: asT<int>(jsonRes['type']),
              typeName: asT<String>(jsonRes['typeName']),
              createTime: asT<int>(jsonRes['createTime']),
            );

  int logId;
  String tldCount;
  int type;
  String typeName;
  int createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'logId': logId,
        'tldCount': tldCount,
        'type': type,
        'typeName': typeName,
        'createTime': createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPYLBRecorderProfitModelManager {
  void getProfitList(int page, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'pageSize': '10', 'pageNo': page}, 'ylb/ylbProfitLog');
    request.postNetRequest((value) {
      List result = [];
      List profitList = value['list'];
      for (Map item in profitList) {
        result.add(TPYLBProfitListModel.fromJson(item));
      }
      success(result);
    }, (TPError error) => failure(error));
  }
}
