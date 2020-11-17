import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPBillBuyPramaterModel{
  int count;
  int billId;
  String walletAddress;
  String walletName;
  int payType;
  int ylbType;
}

class TPBillInfoListModel {
  int billId;
  int billLevel;
  String billPrice;
  String profitRate;
  int alreadyBuyCount;
  int totalBuyCount;
  bool lock;
  bool isOpen = false;
  List orderList;
  String tip;
  String maxProfitDesc;

  TPBillInfoListModel(
      {this.billId,
      this.billLevel,
      this.billPrice,
      this.profitRate,
      this.alreadyBuyCount,
      this.totalBuyCount,
      this.lock,
      this.orderList,this.tip,this.maxProfitDesc});

  TPBillInfoListModel.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billLevel = json['billLevel'];
    billPrice = json['billPrice'];
    profitRate = json['profitRate'];
    alreadyBuyCount = json['alreadyBuyCount'];
    totalBuyCount = json['totalBuyCount'];
    tip = json['tip'];
    lock = json['lock'];
    maxProfitDesc = json['maxProfitDesc'];
    if (json['orderList'] != null) {
      orderList = new List();
      json['orderList'].forEach((v) {
        orderList.add(new TPApptanceOrderListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billLevel'] = this.billLevel;
    data['billPrice'] = this.billPrice;
    data['profitRate'] = this.profitRate;
    data['alreadyBuyCount'] = this.alreadyBuyCount;
    data['totalBuyCount'] = this.totalBuyCount;
    data['tip'] = this.tip;
    data['lock'] = this.lock;
    data['maxProfitDesc'] = this.maxProfitDesc;
    if (this.orderList != null) {
      data['orderList'] = this.orderList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TPApptanceOrderListModel {
  int acptOrderId;
  String acptOrderNo;
  int billId;
  String billPrice;
  int billCount;
  int billExpireDayCount;
  int buyAcptUserId;
  int acptOrderStatus; //(-1，已暂停，0，收益中,1：已到期)
  String createTime;
  String expectProfit;
  String walletAddress;
  String billProfitRate;
  int billLevel;
  String totalPrice;


  TPApptanceOrderListModel(
      {this.acptOrderId,
      this.acptOrderNo,
      this.billId,
      this.billPrice,
      this.billCount,
      this.billExpireDayCount,
      this.buyAcptUserId,
      this.acptOrderStatus,
      this.createTime,this.expectProfit,this.walletAddress,this.billProfitRate,this.billLevel,this.totalPrice});

  TPApptanceOrderListModel.fromJson(Map<String, dynamic> json) {
    acptOrderId = json['acptOrderId'];
    acptOrderNo = json['acptOrderNo'];
    billId = json['billId'];
    billPrice = json['billPrice'];
    billCount = json['billCount'];
    billExpireDayCount = json['billExpireDayCount'];
    buyAcptUserId = json['buyAcptUserId'];
    acptOrderStatus = json['acptOrderStatus'];
    createTime = json['createTime'];
    expectProfit = json['expectProfit'];
    walletAddress = json['walletAddress'];
    billProfitRate = json['billProfitRate'];
    billLevel = json['billLevel'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acptOrderId'] = this.acptOrderId;
    data['acptOrderNo'] = this.acptOrderNo;
    data['billId'] = this.billId;
    data['billPrice'] = this.billPrice;
    data['billCount'] = this.billCount;
    data['billExpireDayCount'] = this.billExpireDayCount;
    data['buyAcptUserId'] = this.buyAcptUserId;
    data['acptOrderStatus'] = this.acptOrderStatus;
    data['createTime'] = this.createTime;
    data['expectProfit'] = this.expectProfit;
    data['walletAddress'] = this.walletAddress;
    data['billProfitRate'] = this.billProfitRate;
    data['billLevel'] = this.billLevel;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}


class TPAcceptanceBillListModelManager {
  void getBillList(Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'acpt/bill/billList');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TPBillInfoListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void buyBill(TPBillBuyPramaterModel pramaterModel,Function(String) success,Function(TPError) failure){
    Map pramaterMap = {'billCount':pramaterModel.count,'billId':pramaterModel.billId,'payType':pramaterModel.payType};
    if (pramaterModel.payType == 1){
      pramaterMap.addEntries({'walletAddress':pramaterModel.walletAddress}.entries);
    }else{
      pramaterMap.addEntries({'ylbType':pramaterModel.ylbType}.entries);
    }

    TPBaseRequest request = TPBaseRequest(pramaterMap,'acpt/bill/buyBill');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }
}