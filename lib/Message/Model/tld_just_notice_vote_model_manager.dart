import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TPOrderAppealModel {
  int appealId;
  String orderNo;
  TPPaymentModel payMethodVO;
  String sellerWalletAddress;
  String buyerWalletAddress;
  String appealDesc;
  String appealImgList;
  int createTime;
  int appealStatus;
  int finishTime;

  TPOrderAppealModel(
      {this.appealId,
      this.orderNo,
      this.payMethodVO,
      this.sellerWalletAddress,
      this.buyerWalletAddress,
      this.appealDesc,
      this.appealImgList,
      this.createTime,
      this.appealStatus,
      this.finishTime});

  TPOrderAppealModel.fromJson(Map<String, dynamic> json) {
    appealId = json['appealId'];
    orderNo = json['orderNo'];
    payMethodVO = json['payMethodVO'] != null
        ? new TPPaymentModel.fromJson(json['payMethodVO'])
        : null;
    sellerWalletAddress = json['sellerWalletAddress'];
    buyerWalletAddress = json['buyerWalletAddress'];
    appealDesc = json['appealDesc'];
    appealImgList = json['appealImgList'];
    createTime = json['createTime'];
    appealStatus = json['appealStatus'];
    finishTime = json['finishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appealId'] = this.appealId;
    data['orderNo'] = this.orderNo;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['sellerWalletAddress'] = this.sellerWalletAddress;
    data['buyerWalletAddress'] = this.buyerWalletAddress;
    data['appealDesc'] = this.appealDesc;
    data['appealImgList'] = this.appealImgList;
    data['createTime'] = this.createTime;
    data['appealStatus'] = this.appealStatus;
    data['finishTime'] = this.finishTime;
    return data;
  }
}

class PayMethodVO {
  int payId;
  String realName;
  String walletAddress;
  int type;
  String payMethodName;
  String account;
  String imageUrl;
  Null subBranch;
  String quota;
  int createTime;

  PayMethodVO(
      {this.payId,
      this.realName,
      this.walletAddress,
      this.type,
      this.payMethodName,
      this.account,
      this.imageUrl,
      this.subBranch,
      this.quota,
      this.createTime});

  PayMethodVO.fromJson(Map<String, dynamic> json) {
    payId = json['payId'];
    realName = json['realName'];
    walletAddress = json['walletAddress'];
    type = json['type'];
    payMethodName = json['payMethodName'];
    account = json['account'];
    imageUrl = json['imageUrl'];
    subBranch = json['subBranch'];
    quota = json['quota'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payId'] = this.payId;
    data['realName'] = this.realName;
    data['walletAddress'] = this.walletAddress;
    data['type'] = this.type;
    data['payMethodName'] = this.payMethodName;
    data['account'] = this.account;
    data['imageUrl'] = this.imageUrl;
    data['subBranch'] = this.subBranch;
    data['quota'] = this.quota;
    data['createTime'] = this.createTime;
    return data;
  }
}

class TPJustVoteModelManager{
  void getOrderAppealInfoWithAppealId(int appealId,Function(TPOrderAppealModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'appealId':appealId},'appeal/appealDetail');
    request.postNetRequest((value) {
      Map dataMap = value;
      TPOrderAppealModel appealModel = TPOrderAppealModel.fromJson(dataMap);
      success(appealModel);
    }, (error) => failure(error));
  }

  void voteOrderAppeal(int voteValue,int appealId,Function success,Function(TPError) failure){
    int voteFlag = voteValue - 1;//客户端定义的flag需要-1
    String userToken = TPDataManager.instance.userToken;
    TPBaseRequest request = TPBaseRequest({'appealId':appealId,'flag':voteFlag,'userToken':userToken},'appeal/appealVote');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void cancelAppeal(int appealId,Function success,Function(TPError) failure){
        TPBaseRequest request = TPBaseRequest({'appealId':appealId},'appeal/cancelAppeal');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}