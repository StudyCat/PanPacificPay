import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPAcceptancePersonCenterProfitModel {
  TPAcceptancePersonCenterProfitModel({
    this.data,
    this.title,
  });

  factory TPAcceptancePersonCenterProfitModel.fromJson(
      Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TPAcceptancePersonCenterProfitSonModel> data =
        jsonRes['data'] is List
            ? <TPAcceptancePersonCenterProfitSonModel>[]
            : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']) {
        if (item != null) {
          data.add(TPAcceptancePersonCenterProfitSonModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TPAcceptancePersonCenterProfitModel(
      data: data,
      title: asT<String>(jsonRes['title']),
    );
  }

  List<TPAcceptancePersonCenterProfitSonModel> data;
  String title;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'title': title,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAcceptancePersonCenterProfitSonModel {
  TPAcceptancePersonCenterProfitSonModel({
    this.value,
    this.content,
  });

  factory TPAcceptancePersonCenterProfitSonModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPAcceptancePersonCenterProfitSonModel(
              value: asT<String>(jsonRes['value']),
              content: asT<String>(jsonRes['content']),
            );

  String value;
  String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'content': content,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAcceptancePersonCenterProfitModelManager {
  void getMyProfit(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'acpt/user/selfProfitDetail');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TPAcceptancePersonCenterProfitModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getInviteProfit(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'acpt/user/sjProfitDetail');
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TPAcceptancePersonCenterProfitModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}
