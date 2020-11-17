import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPInviteDetailEarningModel {
  String userName;
  String tel;
  List<TPEarningBillModel> list;
  String totalProfit;
  String realTel;

  TPInviteDetailEarningModel(
      {this.userName, this.tel, this.list, this.totalProfit});

  TPInviteDetailEarningModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    tel = json['tel'];
    realTel = json['realTel'];
    if (json['list'] != null) {
      list = new List<TPEarningBillModel>();
      json['list'].forEach((v) {
        list.add(new TPEarningBillModel.fromJson(v));
      });
    }
    totalProfit = json['totalProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['tel'] = this.tel;
    data['realTel'] = this.realTel;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['totalProfit'] = this.totalProfit;
    return data;
  }
}

class TPEarningBillModel {
  int billLevel;
  int billCount;
  String totalPrice;
  String extensionProfit;

  TPEarningBillModel({this.billLevel, this.billCount, this.totalPrice, this.extensionProfit});

  TPEarningBillModel.fromJson(Map<String, dynamic> json) {
    billLevel = json['billLevel'];
    billCount = json['billCount'];
    totalPrice = json['totalPrice'];
    extensionProfit = json['extensionProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billLevel'] = this.billLevel;
    data['billCount'] = this.billCount;
    data['totalPrice'] = this.totalPrice;
    data['extensionProfit'] = this.extensionProfit;
    return data;
  }
}

class TPAcceptanceInvitationDetailEarningModelManager {
  
  void getDetailEarningInfo(String userName,Function(TPInviteDetailEarningModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'userName' : userName}, 'acpt/user/profitDetail');
    request.postNetRequest((value) {
      success(TPInviteDetailEarningModel.fromJson(value));
    }, (error) => failure(error));
  }

}