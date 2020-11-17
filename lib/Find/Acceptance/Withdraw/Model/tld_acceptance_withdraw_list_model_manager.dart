import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_list_page.dart';

class TPAcceptanceWithdrawOrderListModel {
  bool amApply;
  String cashNo;
  int acptUserId;
  int inviteUserId;
  String applyUserName;
  String inviteUserName;
  int cashType;
  String tldCount;
  String cashPrice;
  int payId;
  TPPaymentModel payMethodVO;
  String applyWalletAddress;
  String inviteWalletAddress;
  int cashStatus;
  int createTime;
  int expireTime;
  int finishTime;
  String chargeRate;
  String chargeValue;
  int appealStatus;
  int appealId;

  TPAcceptanceWithdrawOrderListModel(
      {this.amApply,
      this.cashNo,
      this.acptUserId,
      this.inviteUserId,
      this.applyUserName,
      this.inviteUserName,
      this.cashType,
      this.tldCount,
      this.cashPrice,
      this.payId,
      this.payMethodVO,
      this.inviteWalletAddress,
      this.applyWalletAddress,
      this.cashStatus,
      this.createTime,
      this.expireTime,
      this.finishTime,
      this.chargeRate,
      this.chargeValue,
      this.appealStatus,this.appealId});

  TPAcceptanceWithdrawOrderListModel.fromJson(Map<String, dynamic> json) {
    amApply = json['amApply'];
    cashNo = json['cashNo'];
    acptUserId = json['acptUserId'];
    inviteUserId = json['inviteUserId'];
    applyUserName = json['applyUserName'];
    inviteUserName = json['inviteUserName'];
    cashType = json['cashType'];
    tldCount = json['tldCount'];
    cashPrice = json['cashPrice'];
    payId = json['payId'];
    payMethodVO = json['payMethodVO'] != null
        ? new TPPaymentModel.fromJson(json['payMethodVO'])
        : null;
    inviteWalletAddress = json['inviteWalletAddress'];
    applyWalletAddress = json['applyWalletAddress'];
    cashStatus = json['cashStatus'];
    createTime = json['createTime'];
    expireTime = json['expireTime'];
    finishTime = json['finishTime'];
    chargeValue = json['chargeValue'];
    chargeRate = json['chargeRate'];
    appealStatus = json['appealStatus'];
    appealId = json['appealId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amApply'] = this.amApply;
    data['cashNo'] = this.cashNo;
    data['acptUserId'] = this.acptUserId;
    data['inviteUserId'] = this.inviteUserId;
    data['applyUserName'] = this.applyUserName;
    data['inviteUserName'] = this.inviteUserName;
    data['cashType'] = this.cashType;
    data['tldCount'] = this.tldCount;
    data['cashPrice'] = this.cashPrice;
    data['payId'] = this.payId;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['inviteWalletAddress'] = this.inviteWalletAddress;
    data['applyWalletAddress'] = this.applyWalletAddress;
    data['cashStatus'] = this.cashStatus;
    data['createTime'] = this.createTime;
    data['expireTime'] = this.expireTime;
    data['finishTime'] = this.finishTime;
    data['chargeValue'] = this.chargeValue;
    data['chargeRate'] = this.chargeRate;
    data['appealStatus'] = this.appealStatus;
    data['appealId'] = this.appealId;
    return data;
  }
}

class TPAcceptanceWithdrawListModelManager {
  void getWaitPayOrderList(int page,TPAcceptanceProfitListPageType type,Function(List) success,Function(TPError) failure){
    Map pramater = {'pageNo':page,'pageSize':10};
    if (type == TPAcceptanceProfitListPageType.waitPay) {
      pramater.addEntries({'cashStatus' : 0}.entries);
    }else if (type == TPAcceptanceProfitListPageType.waitSentTP){
      pramater.addEntries({'cashStatus' : 1}.entries);
    }
    TPBaseRequest request = TPBaseRequest(pramater,'acpt/cash/cashApply');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TPAcceptanceWithdrawOrderListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getOtherStatusOrderList(int page,Function(List) success,Function(TPError) failure){
     TPBaseRequest request = TPBaseRequest({'pageNo':page,'pageSize':10},'acpt/cash/cashHistory');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TPAcceptanceWithdrawOrderListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

   void cancelWithdraw(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/cancelCash');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void sentWithdrawTP(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmReceived');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void reminder(String cashNo, Function success, Function(TPError) failure){
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/reminder');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void withdrawSurePay(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmPay');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}