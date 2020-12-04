import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'dart:io';

class TPDetailOrderModel {
  int finishTime;
  String orderNo;
  int orderId;
  int payTime;
  String sellerAddress;
  String remarkPayNo;
  String buyerAddress;
  int expireTime;
  int createTime;
  String payMethod;
  String tmpWalletAddress;
  String txCount;
  bool overtime;
  int status; //(-1：已取消，0：待支付，1：已支付，2：已完成，3：已超时)
  TPPaymentModel payMethodVO;
  int appealStatus; //申诉状态(-1：没有申诉，0：正在申诉，1：申诉成功，2：申诉失败)
  int appealId;
  String buyerUserName;
  String sellerUserName;
  bool amIBuyer;
  int orderType; // 1.普通订单 2.任务订单
  String payImage;
  String realPayAmount;//实际付款
  String cnyPayAmount;//人密闭

  TPDetailOrderModel(
      {this.finishTime,
      this.orderNo,
      this.orderId,
      this.payTime,
      this.sellerAddress,
      this.remarkPayNo,
      this.buyerAddress,
      this.expireTime,
      this.createTime,
      this.payMethod,
      this.tmpWalletAddress,
      this.txCount,
      this.overtime,
      this.status,
      this.payMethodVO,
      this.appealStatus,
      this.appealId,
      this.buyerUserName,
      this.sellerUserName,
      this.amIBuyer,
      this.orderType,
      this.payImage,
      this.realPayAmount,
      this.cnyPayAmount});

  TPDetailOrderModel.fromJson(Map<String, dynamic> json) {
    finishTime = json['finishTime'];
    orderNo = json['orderNo'];
    orderId = json['orderId'];
    payTime = json['payTime'];
    sellerAddress = json['sellerAddress'];
    remarkPayNo = json['remarkPayNo'];
    buyerAddress = json['buyerAddress'];
    expireTime = json['expireTime'];
    createTime = json['createTime'];
    payMethod = json['payMethod'];
    tmpWalletAddress = json['tmpWalletAddress'];
    txCount = json['txCount'];
    overtime = json['overtime'];
    status = json['status'];
    payMethodVO = TPPaymentModel.fromJson(json['payMethodVO']);
    appealId = json['appealId'];
    appealStatus = json['appealStatus'];
    buyerUserName = json['buyerUserName'];
    sellerUserName = json['sellerUserName'];
    orderType = json['orderType'];
    amIBuyer = json['amIBuyer'];
    payImage = json['payImage'];
    realPayAmount = json['realPayAmount'];
    cnyPayAmount = json['cnyPayAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finishTime'] = this.finishTime;
    data['orderNo'] = this.orderNo;
    data['orderId'] = this.orderId;
    data['payTime'] = this.payTime;
    data['sellerAddress'] = this.sellerAddress;
    data['remarkPayNo'] = this.remarkPayNo;
    data['buyerAddress'] = this.buyerAddress;
    data['expireTime'] = this.expireTime;
    data['createTime'] = this.createTime;
    data['payMethod'] = this.payMethod;
    data['tmpWalletAddress'] = this.tmpWalletAddress;
    data['txCount'] = this.txCount;
    data['overtime'] = this.overtime;
    data['status'] = this.status;
    data['payMethodVO'] = this.payMethodVO.toJson();
    data['appealStatus'] = this.appealStatus;
    data['appealId'] = this.appealId;
    data['buyerUserName'] = this.buyerUserName;
    data['sellerUserName'] = this.sellerUserName;
    data['amIBuyer'] = this.amIBuyer;
    data['orderType'] = this.orderType;
    data['payImage'] = this.payImage;
    data['realPayAmount'] = this.realPayAmount;
    data['cnyPayAmount'] = this.cnyPayAmount;
    return data;
  }
}

class TPDetailOrderModelManager {
  void getDetailOrderInfoWithOrderNo(
      String orderNo, Function(TPDetailOrderModel) success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo}, 'order/detail');
    request.postNetRequest((dynamic value) {
      Map data = value;
      TPDetailOrderModel detailModel = TPDetailOrderModel.fromJson(data);
      success(detailModel);
    }, (error) => failure(error));
  }

  void cancelOrderWithOrderNo(String orderNo, Function success, Function failure){
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo}, 'order/cancel');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

//walletAdress 买家地址
  void confirmPaid(String orderNo,String walletAdress, Function success, Function failure){
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo,'walletAddress':walletAdress,}, 'order/confirmPaid');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  //walletAdress 卖家地址
  void sureSentCoin(String orderNo,String walletAdress, Function success, Function failure){
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo,'walletAddress':walletAdress,}, 'order/confirmReceived');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  void remindOrder(String orderNo,Function success, Function failure){
    TPBaseRequest request = TPBaseRequest({'orderNo': orderNo}, 'order/reminder');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  
  void uploadPayProof(File proof, String walletAddress, String orderNo,
      Function success, Function failure) {
    TPBaseRequest imageRequest = TPBaseRequest({}, '');
    imageRequest.uploadFile([proof], (List filePathList) {
      Map payImagePathMap = filePathList.first;
      String payImagePath = payImagePathMap['url'];
      TPBaseRequest request = TPBaseRequest({
        'orderNo': orderNo,
        'walletAddress': walletAddress,
        'payImage': payImagePath
      }, 'order/confirmPaid');
      request.postNetRequest((dynamic value) {
        success();
      }, (error) => failure(error));
    }, (error) => failure(error));
  }
}
