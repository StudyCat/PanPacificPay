
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPDetailMissionInfoModel {
  String taskNo;
  int taskLevel;
  String levelIcon;
  String progressCount;
  String quote;
  String profitRate;
  String profit;
  String chargeRate;
  String realProfit;
  String totalProfit;
  String totalQuote;
  int startTime;
  int endTime;
  int expireTime;
  String receiveWalletAddress;
  String releaseWalletAddress;

  TPDetailMissionInfoModel(
      {this.taskNo,
      this.taskLevel,
      this.levelIcon,
      this.progressCount,
      this.quote,
      this.profitRate,
      this.profit,
      this.chargeRate,
      this.realProfit,
      this.totalProfit,
      this.totalQuote,
      this.startTime,
      this.endTime,
      this.expireTime,
      this.receiveWalletAddress,
      this.releaseWalletAddress});

  TPDetailMissionInfoModel.fromJson(Map<String, dynamic> json) {
    taskNo = json['taskNo'];
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    progressCount = json['progressCount'];
    quote = json['quote'];
    profitRate = json['profitRate'];
    profit = json['profit'];
    chargeRate = json['chargeRate'];
    realProfit = json['realProfit'];
    totalProfit = json['totalProfit'];
    totalQuote = json['totalQuote'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    expireTime = json['expireTime'];
    receiveWalletAddress = json['receiveWalletAddress'];
    releaseWalletAddress = json['releaseWalletAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskNo'] = this.taskNo;
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['progressCount'] = this.progressCount;
    data['quote'] = this.quote;
    data['profitRate'] = this.profitRate;
    data['profit'] = this.profit;
    data['chargeRate'] = this.chargeRate;
    data['realProfit'] = this.realProfit;
    data['totalProfit'] = this.totalProfit;
    data['totalQuote'] = this.totalQuote;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['expireTime'] = this.expireTime;
    data['receiveWalletAddress'] = this.receiveWalletAddress;
    data['releaseWalletAddress'] = this.releaseWalletAddress;
    return data;
  }
}

class TPDetailMissionModelManager{

  void getDetailMissionInfo(int taskWalletId,Function(TPDetailMissionInfoModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'taskWalletId':taskWalletId},'task/taskDetail');
    request.postNetRequest((value) {
      Map data = value;
      success(TPDetailMissionInfoModel.fromJson(data));
    }, (error) => failure(error));
  }
}