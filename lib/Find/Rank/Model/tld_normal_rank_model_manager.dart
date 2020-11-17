import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPNormalRankModel {
  int rankId;
  String walletAddress;
  String totalTxCount;

  TPNormalRankModel({this.rankId, this.walletAddress, this.totalTxCount});

  TPNormalRankModel.fromJson(Map<String, dynamic> json) {
    rankId = json['rankId'];
    walletAddress = json['walletAddress'];
    totalTxCount = json['totalTxCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankId'] = this.rankId;
    data['walletAddress'] = this.walletAddress;
    data['totalTxCount'] = this.totalTxCount;
    return data;
  }
}

class TPNormalRankModelManager {
  void getMonthRankList(Function(List) success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'rank/monthSort');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        TPNormalRankModel model = TPNormalRankModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }

  void getWeekRankList(Function(List) success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'rank/weekSort');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        TPNormalRankModel model = TPNormalRankModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}