import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPMerchantJoinParmater{
  String name;
  String category;
  String dutyOfficer;
  String email;
}

class TPMerchantJoinModelManager{
  void joinMerchant(TPMerchantJoinParmater parmater,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'appName':parmater.name,'appType':parmater.category,'email':parmater.email,'realName':parmater.dutyOfficer},'merchant/regMerchant');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void getDelegateInfo(Function success,Function failure){
      TPBaseRequest request = TPBaseRequest({},'merchant/merchantAgreement');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}