

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';

class TPNewMissionMyMissionModelManager{
  void getMyMissionList(String walletAddress,int page,Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':walletAddress,'pageNo':page,'pageSize':10},'newTask/myTaskList');
    request.postNetRequest((value) {
         Map data = value;
      List dataList = data['list'];
       List result = [];
      for (Map item in dataList) {
        result.add(TPOrderListModel.fromJson(item));
      }
      success(result);
    }, (TPError error){
      failure(error);
    });
  }
}