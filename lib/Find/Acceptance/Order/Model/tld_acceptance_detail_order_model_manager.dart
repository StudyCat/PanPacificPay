import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPAcceptanceDetailOrderInfoModel {
  int acptOrderId;
  String acptOrderNo;
  int billId;
  String billPrice;
  int billCount;
  int billExpireDayCount;
  int buyAcptUserId;
  int acptOrderStatus;
  String createTime;
  String expectProfit;
  String walletAddress;
  String billProfitRate;
  int billLevel;
  String totalPrice;
  String staticProfit;

  TPAcceptanceDetailOrderInfoModel(
      {this.acptOrderId,
      this.acptOrderNo,
      this.billId,
      this.billPrice,
      this.billCount,
      this.billExpireDayCount,
      this.buyAcptUserId,
      this.acptOrderStatus,
      this.createTime,this.expectProfit,this.walletAddress,this.billProfitRate,this.billLevel,this.totalPrice,this.staticProfit});

  TPAcceptanceDetailOrderInfoModel.fromJson(Map<String, dynamic> json) {
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
    staticProfit = json['staticProfit'];
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
    data['staticProfit'] = this.staticProfit;
    return data;
  }
}

class TPAcceptanceDetailOrderModelManager {
   void getDetailOrderInfo(String orderNo,Function(TPAcceptanceDetailOrderInfoModel) success,Function(TPError) failure){
     TPBaseRequest request = TPBaseRequest({'acptOrderNo':orderNo}, 'acpt/order/billOrderDetail');
     request.postNetRequest((value) {
       TPAcceptanceDetailOrderInfoModel detailOrderInfoModel = TPAcceptanceDetailOrderInfoModel.fromJson(value);
       success(detailOrderInfoModel);
     }, (error) => failure(error));
   }
}