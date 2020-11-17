

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPAcceptanceProfitListModel {
  int billId;
  int billLevel;
  int billCount;
  String billIcon;
  String profitTldCount;
  int createTime;
  String profitDesc;

  TPAcceptanceProfitListModel(
      {this.billId,
      this.billLevel,
      this.billCount,
      this.billIcon,
      this.profitTldCount,
      this.createTime,
      this.profitDesc});

  TPAcceptanceProfitListModel.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billLevel = json['billLevel'];
    billCount = json['billCount'];
    billIcon = json['billIcon'];
    profitTldCount = json['profitTldCount'];
    createTime = json['createTime'];
    profitDesc = json['profitDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billLevel'] = this.billLevel;
    data['billCount'] = this.billCount;
    data['billIcon'] = this.billIcon;
    data['profitTldCount'] = this.profitTldCount;
    data['createTime'] = this.createTime;
    data['profitDesc'] = this.profitDesc;
    return data;
  }
}

class TPAcceptanceProfitModelManager {
  
  void getProfitList(int page,Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'pageNo':page,'pageSize':10},'acpt/bill/profitRecord');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (var item in dataList) {
        result.add(TPAcceptanceProfitListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}