

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPSendRedEnvelopePramater{
  String desc;
  int policy;//红包策略
  int redEnvelopeNum;
  String tldCount;
  String walletAddress;
  int type;
}

class TPSendRedEnvelopeModelManager{
  void sendRedEnvelope(TPSendRedEnvelopePramater pramater,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'desc':pramater.desc,'policy':pramater.policy,'redEnvelopeNum':pramater.redEnvelopeNum,'tldCount':pramater.tldCount,'walletAddress':pramater.walletAddress,'type':pramater.type}, 'redEnvelope/generateRedEnvelope');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}