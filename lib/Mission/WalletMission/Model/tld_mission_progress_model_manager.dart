

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TPMissionProgressModel {
  String taskBuyNo;
  int taskLevel;
  String levelIcon;
  String quote;
  String totalCount;
  String realCount;
  String currentCount;
  int payId;
  TPPaymentModel payMethodVO;
  String releaseWalletAddress;
  int createTime;
  int status;
  List<TaskOrderListModel> taskOrderList;
  bool isOpen = false;

  TPMissionProgressModel(
      {this.taskBuyNo,
      this.taskLevel,
      this.levelIcon,
      this.quote,
      this.totalCount,
      this.realCount,
      this.currentCount,
      this.payId,
      this.payMethodVO,
      this.releaseWalletAddress,
      this.createTime,
      this.status,
      this.taskOrderList});

  TPMissionProgressModel.fromJson(Map<String, dynamic> json) {
    taskBuyNo = json['taskBuyNo'];
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    quote = json['quote'];
    totalCount = json['totalCount'];
    realCount = json['realCount'];
    currentCount = json['currentCount'];
    payId = json['payId'];
    payMethodVO = json['payMethodVO'] != null
        ? new TPPaymentModel.fromJson(json['payMethodVO'])
        : null;
    releaseWalletAddress = json['releaseWalletAddress'];
    createTime = json['createTime'];
    status = json['status'];
    if (json['taskOrderList'] != null) {
      taskOrderList = new List<TaskOrderListModel>();
      json['taskOrderList'].forEach((v) {
        taskOrderList.add(new TaskOrderListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskBuyNo'] = this.taskBuyNo;
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['quote'] = this.quote;
    data['totalCount'] = this.totalCount;
    data['realCount'] = this.realCount;
    data['currentCount'] = this.currentCount;
    data['payId'] = this.payId;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['releaseWalletAddress'] = this.releaseWalletAddress;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    if (this.taskOrderList != null) {
      data['taskOrderList'] =
          this.taskOrderList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class TaskOrderListModel {
  int orderId;
  String orderNo;
  String taskBuyNo;
  int taskLevel;
  String quote;
  String profit;
  String buyerWalletAddress;
  String sellerWalletAddress;
  String createTime;
  int status;
  String buyerUserName;
  String sellerUserName;
  bool amIBuyer;

  TaskOrderListModel(
      {this.orderId,
      this.orderNo,
      this.taskBuyNo,
      this.taskLevel,
      this.quote,
      this.profit,
      this.buyerWalletAddress,
      this.sellerWalletAddress,
      this.createTime,
      this.status,
      this.buyerUserName,
      this.sellerUserName,
      this.amIBuyer});

  TaskOrderListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    taskBuyNo = json['taskBuyNo'];
    taskLevel = json['taskLevel'];
    quote = json['quote'];
    profit = json['profit'];
    buyerWalletAddress = json['buyerWalletAddress'];
    sellerWalletAddress = json['sellerWalletAddress'];
    createTime = json['createTime'];
    status = json['status'];
    buyerUserName = json['buyerUserName'];
    sellerUserName = json['sellerUserName'];
    amIBuyer = json['amIBuyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['taskBuyNo'] = this.taskBuyNo;
    data['taskLevel'] = this.taskLevel;
    data['quote'] = this.quote;
    data['profit'] = this.profit;
    data['buyerWalletAddress'] = this.buyerWalletAddress;
    data['sellerWalletAddress'] = this.sellerWalletAddress;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['buyerUserName'] = this.buyerUserName;
    data['sellerUserName'] = this.sellerUserName;
    data['amIBuyer'] = this.amIBuyer;
    return data;
  }
}


class TPMissionProgressModelManager{
  
  void getMissionProgress(int taskWalletId,Function(TPMissionProgressModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'taskWalletId':taskWalletId,},'task/taskProgress');
    request.postNetRequest((value) {
      Map data = value;
      success(TPMissionProgressModel.fromJson(data));
    }, (error) => failure(error));
  }

}