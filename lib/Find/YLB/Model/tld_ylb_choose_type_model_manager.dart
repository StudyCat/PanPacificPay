import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPYLBTypeModel {
  TPYLBTypeModel({
    this.balance,
    this.typeName,
    this.type,
  });

  factory TPYLBTypeModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPYLBTypeModel(
              balance: asT<String>(jsonRes['balance']),
              typeName: asT<String>(jsonRes['typeName']),
              type: asT<int>(jsonRes['type']),
            );

  String balance;
  String typeName;
  int type;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'balance': balance,
        'typeName': typeName,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPYLBChooseTypeModelManager {
  void getTypeList(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'ylb/accountBalance');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TPYLBTypeModel.fromJson(item));
      }
      success(result);
    }, (TPError error) => failure(error));
  }
}
