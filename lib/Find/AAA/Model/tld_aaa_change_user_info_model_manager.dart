import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPAAAUserInfo {
  TPAAAUserInfo({
    this.nickName,
    this.wechat,
    this.tel,
    this.walletAddress,
    this.inviteWechat,
    this.totalProfit,
    this.levelIcon,
    this.aaaLevel,
    this.balance,
    this.signList,
    this.curTime
  });

  factory TPAAAUserInfo.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null){
      return null;
    }

    final List<TPSignModel> signList =
        jsonRes['signList'] is List ? <TPSignModel>[] : null;
    if (signList != null) {
      for (final dynamic item in jsonRes['signList']) {
        if (item != null) {
          signList.add(
              TPSignModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return  TPAAAUserInfo(
              nickName: asT<String>(jsonRes['nickName']),
              wechat: asT<String>(jsonRes['wechat']),
              tel: asT<String>(jsonRes['tel']),
              walletAddress: asT<String>(jsonRes['walletAddress']),
              inviteWechat: asT<String>(jsonRes['inviteWechat']),
              totalProfit: asT<String>(jsonRes['totalProfit']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
              aaaLevel : asT<int>(jsonRes['aaaLevel']),
              balance : asT<String>(jsonRes['balance']),
              curTime: asT<int>(jsonRes['curTime']),
              signList: signList
            );
  }

  int aaaLevel;
  String levelIcon;
  String nickName;
  String wechat;
  String balance;
  String tel;
  String walletAddress;
  String inviteWechat;
  String totalProfit;
  List signList;
  int curTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'wechat': wechat,
        'tel': tel,
        'walletAddress': walletAddress,
        'inviteWechat': inviteWechat,
        'totalProfit': totalProfit,
        'levelIcon' : levelIcon,
        'aaaLevel' : aaaLevel,
        'balance' : balance,
        'curTime' : curTime
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPAAAChangeUserInfoModelManager {
  void getUserInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'aaa/accountInfo');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0){
        success(TPAAAUserInfo());
      }else{
        success(TPAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

  void saveUserInfo(TPAAAUserInfo userInfo,Function success, Function failure) {
    Map pramaterMap = {'nickName': userInfo.nickName,'walletAddress':userInfo.walletAddress,'wechat':userInfo.wechat,'tel':userInfo.tel};
    TPBaseRequest request = TPBaseRequest(pramaterMap,'aaa/editAccountInfo');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
