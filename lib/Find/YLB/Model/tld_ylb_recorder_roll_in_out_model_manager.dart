

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_profit_model_manager.dart';



class TPYLBRecorderRollInOutModelManager{

  void getRollInList(int page,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'pageSize' : '10','pageNo':page},'ylb/transferInLog');
    request.postNetRequest((value) {
            List result = [];
      List profitList = value['list'];
      for (Map item in profitList) {
        result.add(TPYLBProfitListModel.fromJson(item));
      }
      success(result);
    }, (TPError error) => failure(error));
  }


  void getRollOutList(int page,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'pageSize' : '10','pageNo':page},'ylb/transferOutLog');
    request.postNetRequest((value) {
            List result = [];
      List profitList = value['list'];
      for (Map item in profitList) {
        result.add(TPYLBProfitListModel.fromJson(item));
      }
      success(result);
    }, (TPError error) => failure(error));
  }

}