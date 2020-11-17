
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TPAceeptanceWithdrawUsefulInfoModel {
  String acptPlatformCachRate;
  String walletAddress;
  String value;
  String inviteTel;
  bool showPlatform;

  TPAceeptanceWithdrawUsefulInfoModel(
      {this.acptPlatformCachRate, this.walletAddress, this.value,this.inviteTel});

  TPAceeptanceWithdrawUsefulInfoModel.fromJson(Map<String, dynamic> json) {
    acptPlatformCachRate = json['acptPlatformCachRate'];
    walletAddress = json['walletAddress'];
    value = json['value'];
    inviteTel = json['inviteTel'];
    showPlatform = json['showPlatform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acptPlatformCachRate'] = this.acptPlatformCachRate;
    data['walletAddress'] = this.walletAddress;
    data['value'] = this.value;
    data['inviteTel'] = this.inviteTel;
    data['showPlatform'] = this.showPlatform;
    return data;
  }
}

class TPWithdrawPramaterModel {
  int cashType;
  String cashCount;
  TPPaymentModel paymentModel;
  String walletAddress;
}

class TPAcceptanceWithdrawModelManager {
  
  void getUsefulInfo(Function(TPAceeptanceWithdrawUsefulInfoModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'acpt/cash/getCachCharge');
    request.postNetRequest((value) {
      success(TPAceeptanceWithdrawUsefulInfoModel.fromJson(value));
    }, (error) => failure(error));
  }

  void withdraw(TPWithdrawPramaterModel pramaterModel,Function(String) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'cashCount':pramaterModel.cashCount,'cashType':pramaterModel.cashType,'payId':pramaterModel.paymentModel.payId,'walletAddress' : pramaterModel.walletAddress},'acpt/cash/newCash');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}