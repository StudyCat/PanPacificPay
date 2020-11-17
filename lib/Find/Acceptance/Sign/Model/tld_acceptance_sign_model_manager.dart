

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TPSignModel{
  String year;
  String month;
  List dayList;

  TPSignModel(
      {this.year,
      this.month,
      this.dayList,
      });

  TPSignModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    dayList = json['dayList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['dayList'] = this.dayList;
    return data;
  }
}


class TPAcceptanceUserInfoModel {
  String userName;
  String tel;
  String avatar;
  String acptTotalScore;
  String acptSignScore;
  String acptSignTld;
  String idCard;
  String walletAddress;
  String extensionCode;
  String yearMonth;
  List signList;
  String curTime;
  String jwtToken;
  TPWallet wallet;
  String totalWithdraw; //可提现额
  String withdrawLimit; //已提现总额
  String overflowProfit;//收益池
  String inviteProfit; //推广收益
  String todayProfit; //每日收益
  String staticProfit; // 静态收益
  String totalBillProfit;  //累计收益
  bool signFlag;
  String expireDayCountDesc = ''; // 出局描述

  TPAcceptanceUserInfoModel(
      {this.userName,
      this.tel,
      this.avatar,
      this.acptTotalScore,
      this.acptSignScore,
      this.acptSignTld,
      this.idCard,
      this.walletAddress,
      this.extensionCode,
      this.yearMonth,
      this.signList,
      this.jwtToken,
      this.curTime,
      this.withdrawLimit,
      this.totalWithdraw,
      this.overflowProfit,
      this.inviteProfit,
      this.todayProfit,
      this.staticProfit,
      this.totalBillProfit,
      this.signFlag,
      this.expireDayCountDesc
      });

  TPAcceptanceUserInfoModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    tel = json['tel'];
    avatar = json['avatar'];
    acptTotalScore = json['acptTotalScore'];
    acptSignScore = json['acptSignScore'];
    acptSignTld = json['acptSignTld'];
    idCard = json['idCard'];
    walletAddress = json['walletAddress'];
    extensionCode = json['extensionCode'];
    yearMonth = json['yearMonth'];
    signList = _getSignList(json['signList']);
    jwtToken = json['jwtToken'];
    curTime = json['curTime'];
    totalWithdraw = json['totalWithdraw'];
    withdrawLimit = json['withdrawLimit'];
    overflowProfit = json['overflowProfit'];
    inviteProfit = json['inviteProfit'];
    todayProfit = json['todayProfit'];
    staticProfit = json['staticProfit'];
    totalBillProfit = json['totalBillProfit'];
    signFlag = json['signFlag'];
    expireDayCountDesc = json['expireDayCount'];
  }

   List _getSignList(List jsonList){
     List result = [];
     for (Map item in jsonList) {
       result.add(TPSignModel.fromJson(item));
     }
     return result;
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['tel'] = this.tel;
    data['avatar'] = this.avatar;
    data['acptTotalScore'] = this.acptTotalScore;
    data['acptSignTld'] = this.acptSignTld;
    data['idCard'] = this.idCard;
    data['walletAddress'] = this.walletAddress;
    data['extensionCode'] = this.extensionCode;
    data['yearMonth'] = this.yearMonth;
    data['signList'] = this.signList;
    data['jwtToken'] = this.jwtToken;
    data['curTime'] = this.curTime;
    data['totalWithdraw'] = this.totalWithdraw;
    data['withdrawLimit'] = this.withdrawLimit;
    data['overflowProfit'] = this.overflowProfit;
    data['inviteProfit'] = this.inviteProfit;
    data['todayProfit'] = this.todayProfit;
    data['staticProfit'] = this.staticProfit;
    data['totalBillProfit'] = this.totalBillProfit;
    data['signFlag'] = this.signFlag;
    data['expireDayCount'] = this.expireDayCountDesc;
    return data;
  }
}


class TPAcceptanceSignModelManager{

  void getUserInfo(Function(TPAcceptanceUserInfoModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'acpt/user/getAcptUserInfo');
    request.postNetRequest((value) {
      TPAcceptanceUserInfoModel userInfoModel = TPAcceptanceUserInfoModel.fromJson(value);
      List purseList = TPDataManager.instance.purseList;
      for (TPWallet wallet in purseList) {
        if (wallet.address == userInfoModel.walletAddress){
          userInfoModel.wallet = wallet;
          break;
        }
      }
      success(userInfoModel);
    }, (error) => failure(error));
  }

  void getAAAUserInfo(Function(TPAAAUserInfo) success,Function(TPError) failure){
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

  void changeWallet(String walletAddress,Function() success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':walletAddress},'acpt/user/changeWallet');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

 void sign(Function(String) success,Function(TPError) failure){
   TPBaseRequest request = TPBaseRequest({},'acpt/user/acptSign');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
 }

}