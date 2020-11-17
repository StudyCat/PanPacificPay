

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPIntergrationDescModelManager{

  void getRate(Function(String) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'wallet/tldRateDesc');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }
}
