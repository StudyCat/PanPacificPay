import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/material.dart';


class TPWalletInfoModel {
  String createTime;
  String rate;
  List<PayMethodList> payMethodList;
  bool lock;
  bool existSell;
  String walletAddress;
  String value;
  String walletLevel;
  String chargeWalletAddress;
  TPWallet wallet;
  String minRate;
  String maxRate;
  String expProgress;
  String levelIcon;

  TPWalletInfoModel(
      {this.createTime,
      this.rate,
      this.payMethodList,
      this.lock,
      this.existSell,
      this.walletAddress,
      this.value,
      this.walletLevel,
      this.chargeWalletAddress,
      this.wallet,
      this.minRate,
      this.maxRate,
      this.expProgress,
      this.levelIcon
      });

  TPWalletInfoModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    rate = json['rate'];
    if (json['payMethodList'] != null) {
      payMethodList = new List<PayMethodList>();
      json['payMethodList'].forEach((v) {
        payMethodList.add(new PayMethodList.fromJson(v));
      });
    }
    lock = json['lock'];
    existSell = json['existSell'];
    walletAddress = json['walletAddress'];
    value = json['value'];
    walletLevel = json['walletLevel'];
    chargeWalletAddress = json['chargeWalletAddress'];
    minRate = json['minRate'];
    maxRate = json['maxRate'];
    expProgress = json['expProgress'];
    levelIcon = json['levelIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['rate'] = this.rate;
    if (this.payMethodList != null) {
      data['payMethodList'] =
          this.payMethodList.map((v) => v.toJson()).toList();
    }
    data['lock'] = this.lock;
    data['existSell'] = this.existSell;
    data['walletAddress'] = this.walletAddress;
    data['value'] = this.value;
    data['walletLevel'] = this.walletLevel;
    data['chargeWalletAddress'] = this.chargeWalletAddress;
    data['minRate'] = this.minRate;
    data['maxRate'] = this.maxRate;
    data['expProgress'] = this.expProgress;
    data['levelIcon'] = this.levelIcon;
    return data;
  }
}

class PayMethodList {
  int payId;
  String realName;
  String walletAddress;
  int type;
  String payMethodName;
  String account;
  String imageUrl;
  String subBranch;
  String quota;
  int createTime;

  PayMethodList(
      {this.payId,
      this.realName,
      this.walletAddress,
      this.type,
      this.payMethodName,
      this.account,
      this.imageUrl,
      this.subBranch,
      this.quota,
      this.createTime});

  PayMethodList.fromJson(Map<String, dynamic> json) {
    payId = json['payId'];
    realName = json['realName'];
    walletAddress = json['walletAddress'];
    type = json['type'];
    payMethodName = json['payMethodName'];
    account = json['account'];
    imageUrl = json['imageUrl'];
    subBranch = json['subBranch'];
    quota = json['quota'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payId'] = this.payId;
    data['realName'] = this.realName;
    data['walletAddress'] = this.walletAddress;
    data['type'] = this.type;
    data['payMethodName'] = this.payMethodName;
    data['account'] = this.account;
    data['imageUrl'] = this.imageUrl;
    data['subBranch'] = this.subBranch;
    data['quota'] = this.quota;
    data['createTime'] = this.createTime;
    return data;
  }
}