


import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';

class TPDetailRecieveRedEnvelopeModelManager{
  void getDetailInfo(int receiveLogId,Function(TPDetailRedEnvelopeModel) success,Function failure){
    TPBaseRequest request = TPBaseRequest({'receiveLogId':receiveLogId}, 'redEnvelope/receiveLogDetail');
    request.postNetRequest((value) {
      success(TPDetailRedEnvelopeModel.fromJson(value));
    }, (error) => failure(error));
  }
}