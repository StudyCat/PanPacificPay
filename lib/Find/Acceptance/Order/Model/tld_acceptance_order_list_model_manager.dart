import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';

class TPAcceptanceOrderListModelManager{
  void getOrderList(int page,Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'pageNo':page,'pageSize':10},'acpt/order/billOrderList');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        TPApptanceOrderListModel molde = TPApptanceOrderListModel.fromJson(item);
        result.add(molde);
      }
      success(result);
    }, (error) => failure(error));
  }
}