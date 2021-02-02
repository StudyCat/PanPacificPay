
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../CommonWidget/tld_data_manager.dart';
import 'dart:convert';

class TPOrderListModel {
  int orderId;
  String orderNo;
  String buyerAddress;
  String sellerAddress;
  Null tmpWalletAddress;
  String payMethod;
  int status;
  String txCount;
  int createTime;
  int payTime;
  int finishTime;
  int expireTime;
  bool overtime;
  String remarkPayNo;
  int taskLevel;
  TPPaymentModel payMethodVO;
  String quote;
  String profit;
  String taskBuyNo;
  String buyerUserName;
  String sellerUserName;
  bool amIBuyer;
  int appealStatus; ////申诉状态(-1：没有申诉，0：正在申诉，1：申诉成功，2：申诉失败)
  int appealId;
  int orderType; // 1.普通订单 2.任务订单
  String taskOrderRemark;

  TPOrderListModel(
      {this.orderId,
      this.orderNo,
      this.buyerAddress,
      this.sellerAddress,
      this.tmpWalletAddress,
      this.payMethod,
      this.status,
      this.txCount,
      this.createTime,
      this.payTime,
      this.finishTime,
      this.expireTime,
      this.overtime,
      this.remarkPayNo,
      this.payMethodVO,
      this.taskLevel,this.quote,this.profit,this.taskBuyNo,this.buyerUserName,this.sellerUserName,this.amIBuyer,this.appealStatus,this.appealId,this.orderType,this.taskOrderRemark});

  TPOrderListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    buyerAddress = json['buyerAddress'];
    sellerAddress = json['sellerAddress'];
    tmpWalletAddress = json['tmpWalletAddress'];
    payMethod = json['payMethod'];
    status = json['status'];
    txCount = json['txCount'];
    createTime = json['createTime'];
    payTime = json['payTime'];
    finishTime = json['finishTime'];
    expireTime = json['expireTime'];
    overtime = json['overtime'];
    remarkPayNo = json['remarkPayNo'];
    payMethodVO = TPPaymentModel.fromJson(json['payMethodVO']);
    taskLevel = json['taskLevel'];
    quote = json['quote'];
    profit = json['profit'];
    taskBuyNo = json['taskBuyNo'];
    buyerUserName = json['buyerUserName'];
    sellerUserName = json['sellerUserName'];
    amIBuyer = json['amIBuyer'];
    appealStatus = json['appealStatus'];
    appealId = json['appealId'];
    orderType = json['orderType'];
    taskOrderRemark = json['taskOrderRemark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['buyerAddress'] = this.buyerAddress;
    data['sellerAddress'] = this.sellerAddress;
    data['tmpWalletAddress'] = this.tmpWalletAddress;
    data['payMethod'] = this.payMethod;
    data['status'] = this.status;
    data['txCount'] = this.txCount;
    data['createTime'] = this.createTime;
    data['payTime'] = this.payTime;
    data['finishTime'] = this.finishTime;
    data['expireTime'] = this.expireTime;
    data['overtime'] = this.overtime;
    data['remarkPayNo'] = this.remarkPayNo;
    data['payMethodVO'] = this.payMethodVO.toJson();
    data['taskLevel'] = this.taskLevel;
    data['quote'] = this.quote;
    data['profit'] = this.profit;
    data['taskBuyNo'] = this.taskBuyNo;
    data['buyerUserName'] = this.buyerUserName;
    data['sellerUserName'] = this.sellerUserName;
    data['amIBuyer'] = this.amIBuyer;
    data['appealStatus'] = this.appealStatus;
    data['appealId'] = this.appealId;
    data['orderType'] = this.orderType;
    data['taskOrderRemark'] = this.taskOrderRemark;
    return data;
  }
}

class TPOrderListPramaterModel{
  int type;
  int page;
  int status;
  String walletAddress = '';
}


class TPOrderListModelManager{
  void getOrderList(TPOrderListPramaterModel pramaterModel,Function(List) success,Function(TPError) failure){
    List addressList = [];
    if (pramaterModel.walletAddress.length > 0){
      addressList.add(pramaterModel.walletAddress);
    }else{
      List purseList = TPDataManager.instance.purseList;
      for (TPWallet item in purseList) {
        addressList.add(item.address);
      }
    }
    String addressListJson = jsonEncode(addressList);
    Map pramater = {'type': pramaterModel.type,'pageNo':pramaterModel.page,'pageSize':10,'walletAddressList':addressListJson};
    if(pramaterModel.status != null){
      pramater.addAll({'status':pramaterModel.status});
    }
    TPBaseRequest request = TPBaseRequest(pramater,'order/list');
    request.postNetRequest((dynamic value) {
      Map dataMap = value;
      List dataList = dataMap['list'];
      List result = [];
      for (Map item in dataList) {
        TPOrderListModel model = TPOrderListModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (TPError error){
        failure(error);
    });
  }

    //walletAdress 卖家地址
  void sureSentCoin(String orderNo,String walletAdress, Function success, Function failure){
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo,'walletAddress':walletAdress,}, 'order/confirmReceived');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

}