import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPMissionOrderListModel {
  TPMissionOrderListModel(
      {this.orderId,
      this.orderNo,
      this.orderType,
      this.buyUserId,
      this.sellId,
      this.buyerAddress,
      this.sellerAddress,
      this.buyerUserName,
      this.sellerUserName,
      this.amIBuyer,
      this.tmpWalletAddress,
      this.payId,
      this.payMethodVO,
      this.appealId,
      this.appealStatus,
      this.status,
      this.txCount,
      this.createTime,
      this.payTime,
      this.finishTime,
      this.expireTime,
      this.overtime,
      this.remarkPayNo,
      this.profitCount,
      this.profitRate,
      this.payImage,
      this.realPayAmount,
      this.cnyPayAmount,this.taskOrderRemark});

  factory TPMissionOrderListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPMissionOrderListModel(
              orderId: asT<int>(jsonRes['orderId']),
              orderNo: asT<String>(jsonRes['orderNo']),
              orderType: asT<int>(jsonRes['orderType']),
              buyUserId: asT<int>(jsonRes['buyUserId']),
              sellId: asT<int>(jsonRes['sellId']),
              buyerAddress: asT<String>(jsonRes['buyerAddress']),
              sellerAddress: asT<String>(jsonRes['sellerAddress']),
              buyerUserName: asT<String>(jsonRes['buyerUserName']),
              sellerUserName: asT<String>(jsonRes['sellerUserName']),
              amIBuyer: asT<bool>(jsonRes['amIBuyer']),
              tmpWalletAddress: asT<Object>(jsonRes['tmpWalletAddress']),
              payId: asT<int>(jsonRes['payId']),
              payMethodVO: TPPaymentModel.fromJson(
                  asT<Map<String, dynamic>>(jsonRes['payMethodVO'])),
              appealId: asT<int>(jsonRes['appealId']),
              appealStatus: asT<int>(jsonRes['appealStatus']),
              status: asT<int>(jsonRes['status']),
              txCount: asT<String>(jsonRes['txCount']),
              createTime: asT<int>(jsonRes['createTime']),
              payTime: asT<int>(jsonRes['payTime']),
              finishTime: asT<int>(jsonRes['finishTime']),
              expireTime: asT<int>(jsonRes['expireTime']),
              overtime: asT<bool>(jsonRes['overtime']),
              remarkPayNo: asT<String>(jsonRes['remarkPayNo']),
              profitCount: asT<String>(jsonRes['profitCount']),
              profitRate: asT<String>(jsonRes['profitRate']),
              payImage: asT<String>(jsonRes['payImage']),
              realPayAmount: asT<String>(jsonRes['realPayAmount']),
              cnyPayAmount: asT<String>(jsonRes['cnyPayAmount']),
              taskOrderRemark : asT<String>(jsonRes['taskOrderRemark']));

  int orderId;
  String orderNo;
  int orderType;
  int buyUserId;
  int sellId;
  String buyerAddress;
  String sellerAddress;
  String buyerUserName;
  String sellerUserName;
  bool amIBuyer;
  Object tmpWalletAddress;
  int payId;
  TPPaymentModel payMethodVO;
  int appealId;
  int appealStatus;
  int status;
  String txCount;
  int createTime;
  int payTime;
  int finishTime;
  int expireTime;
  bool overtime;
  String remarkPayNo;
  String profitCount;
  String profitRate;
  String payImage;
  String cnyPayAmount;
  String realPayAmount;
  String taskOrderRemark;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'orderId': orderId,
        'orderNo': orderNo,
        'orderType': orderType,
        'buyUserId': buyUserId,
        'sellId': sellId,
        'buyerAddress': buyerAddress,
        'sellerAddress': sellerAddress,
        'buyerUserName': buyerUserName,
        'sellerUserName': sellerUserName,
        'amIBuyer': amIBuyer,
        'tmpWalletAddress': tmpWalletAddress,
        'payId': payId,
        'payMethodVO': payMethodVO.toJson(),
        'appealId': appealId,
        'appealStatus': appealStatus,
        'status': status,
        'txCount': txCount,
        'createTime': createTime,
        'payTime': payTime,
        'finishTime': finishTime,
        'expireTime': expireTime,
        'overtime': overtime,
        'remarkPayNo': remarkPayNo,
        'profitRate': profitRate,
        'profitCount': profitCount,
        'payImage': payImage,
        'cnyPayAmount': cnyPayAmount,
        'realPayAmount': realPayAmount,
        'taskOrderRemark' : taskOrderRemark
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPScreenPayTypeModel {
  TPScreenPayTypeModel({
    this.payType,
    this.payIcon,
    this.payName,
  });

  factory TPScreenPayTypeModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TPScreenPayTypeModel(
              payType: asT<int>(jsonRes['payType']),
              payIcon: asT<String>(jsonRes['payIcon']),
              payName: asT<String>(jsonRes['payName']),
            );

  int payType;
  String payIcon;
  String payName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payType': payType,
        'payIcon': payIcon,
        'payName': payName,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TPMissionListMissionRecorderModelManager {
  void getOrderList(int page, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'pageNo': page, 'pageSize': '10'}, 'task/taskOrderList');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (var item in dataList) {
        result.add(TPMissionOrderListModel.fromJson(item));
      }
      success(result);
    }, (TPError error) => failure(error));
  }
}
