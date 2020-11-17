import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPAcceptanceRankModel {
  String acptUserName;
  int rankId;
  String profitQuota;

  TPAcceptanceRankModel(
      {this.acptUserName,
      this.rankId,
      this.profitQuota,});

  TPAcceptanceRankModel.fromJson(Map<String, dynamic> json) {
    acptUserName = json['acptUserName'];
    rankId = json['rankId'];
    profitQuota = json['profitQuota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acptUserName'] = this.acptUserName;
    data['rankId'] = this.rankId;
    data['profitQuota'] = this.profitQuota;
    return data;
  }
}

class TPRankAccptanceModelManager{
  void getAcceptanceRankList(Function(List) success,Function(TPError) failure){
     TPBaseRequest request = TPBaseRequest({},'rank/acptSort');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        TPAcceptanceRankModel model = TPAcceptanceRankModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}