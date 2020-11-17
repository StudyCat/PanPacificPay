import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPDetailRedEnvelopeModel {
  TPDetailRedEnvelopeModel({
    this.redEnvelopeId,
    this.type,
    this.policy,
    this.redEnvelopeNum,
    this.expireNum,
    this.walletAddress,
    this.tldCount,
    this.expireTldCount,
    this.createTime,
    this.expireTime,
    this.status,
    this.receiveList,
    this.qrCode,
    this.rdesc,
    this.receiveCount
  });

  factory TPDetailRedEnvelopeModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TPRedEnvelopeReiceveModel> receiveList =
        jsonRes['receiveList'] is List ? <TPRedEnvelopeReiceveModel>[] : null;
    if (receiveList != null) {
      for (final dynamic item in jsonRes['receiveList']) {
        if (item != null) {
          receiveList.add(TPRedEnvelopeReiceveModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TPDetailRedEnvelopeModel(
      redEnvelopeId: asT<String>(jsonRes['redEnvelopeId']),
      type: asT<int>(jsonRes['type']),
      policy: asT<int>(jsonRes['policy']),
      redEnvelopeNum: asT<int>(jsonRes['redEnvelopeNum']),
      expireNum: asT<int>(jsonRes['expireNum']),
      walletAddress: asT<String>(jsonRes['walletAddress']),
      tldCount: asT<String>(jsonRes['tldCount']),
      expireTldCount: asT<String>(jsonRes['expireTldCount']),
      createTime: asT<int>(jsonRes['createTime']),
      expireTime: asT<int>(jsonRes['expireTime']),
      status: asT<int>(jsonRes['status']),
      receiveList: receiveList,
      qrCode: asT<String>(jsonRes['qrCode']),
      rdesc: asT<String>(jsonRes['rdesc']),
      receiveCount: asT<String>(jsonRes['receiveCount'])
    );
  }

  String redEnvelopeId;
  int type;
  int policy;
  int redEnvelopeNum;
  int expireNum;
  String walletAddress;
  String tldCount;
  String expireTldCount;
  int createTime;
  int expireTime;
  int status;
  List<TPRedEnvelopeReiceveModel> receiveList;
  String qrCode;
  String rdesc;
  String receiveCount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'redEnvelopeId': redEnvelopeId,
        'type': type,
        'policy': policy,
        'redEnvelopeNum': redEnvelopeNum,
        'expireNum': expireNum,
        'walletAddress': walletAddress,
        'tldCount': tldCount,
        'expireTldCount': expireTldCount,
        'createTime': createTime,
        'expireTime': expireTime,
        'status': status,
        'receiveList': receiveList,
        'qrCode': qrCode,
        'rdesc': rdesc,
        'receiveCount' : receiveCount
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPRedEnvelopeReiceveModel {
  TPRedEnvelopeReiceveModel(
      {this.createTime,
      this.receiveCount,
      this.receiveWalletAddress,
      this.receiveLogId,
      this.redEnvelopeId});

  factory TPRedEnvelopeReiceveModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPRedEnvelopeReiceveModel(
              createTime: asT<int>(jsonRes['createTime']),
              receiveCount: asT<String>(jsonRes['receiveCount']),
              receiveWalletAddress:
                  asT<String>(jsonRes['receiveWalletAddress']),
              receiveLogId: asT<int>(jsonRes['receiveLogId']),
              redEnvelopeId: asT<String>(jsonRes['redEnvelopeId']),
            );

  int createTime;
  String receiveCount;
  String receiveWalletAddress;
  int receiveLogId;
  String redEnvelopeId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'createTime': createTime,
        'receiveCount': receiveCount,
        'receiveWalletAddress': receiveWalletAddress,
        'receiveLogId': receiveLogId,
        'redEnvelopeId': redEnvelopeId
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPDetailRedEnvelopeModelManager {
  void getDetailRedEnvelope(String redEnvelopeId,
      Function(TPDetailRedEnvelopeModel) success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest(
        {'redEnvelopeId': redEnvelopeId}, 'redEnvelope/redEnvelopeDetail');
    request.postNetRequest((value) {
      TPDetailRedEnvelopeModel detailRedEnvelopeModel =
          TPDetailRedEnvelopeModel.fromJson(value);
      success(detailRedEnvelopeModel);
    }, (error) => failure(error));
  }
}
