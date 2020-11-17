import 'package:dragon_sword_purse/Base/tld_base_request.dart';

import 'tld_detail_sale_model.dart';

class TPDetailSaleModelManager{
  void getDetailSale(String saleNo,Function(TPDetailSaleModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'sellNo':saleNo}, 'sell/detail');
    request.postNetRequest((dynamic value) { 
      success(TPDetailSaleModel.fromJson(value));
    }, (error) => failure(error));
  }
}