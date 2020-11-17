import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

import '../../../Base/tld_base_request.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';

class TPSaleFormModel{
  TPWalletInfoModel infoModel;
  TPPaymentModel paymentModel;
  String maxBuyAmount;//最小额度
  String payMethodName;
  String saleAmount;
  String tmpWalletAddress;
  String rate;
  String maxAmount; //可挂售最大额度
}

class TPExchangeModelManager{

  void submitSaleForm(TPSaleFormModel formModel,Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':formModel.infoModel.walletAddress,'payId':formModel.paymentModel.payId,'max':formModel.maxBuyAmount,'count':formModel.saleAmount,'rate':formModel.rate,'maxAmount':formModel.maxAmount},'sell/create');
    request.postNetRequest((value) {
      Map dataMap = value;
      formModel.tmpWalletAddress = dataMap['tmpWalletAddress'];
      _submitSignSaleForm(formModel, success, failure);
    }, (error) => failure(error));
  }

  void _submitSignSaleForm(TPSaleFormModel formModel,Function success,Function(TPError) failure){
     TPBaseRequest request = TPBaseRequest({'walletAddress':formModel.infoModel.walletAddress,'tmpWalletAddress':formModel.tmpWalletAddress,'count':formModel.saleAmount},'sell/signCreate');
     request.postNetRequest((value) {
       success();
     }, (error) => failure(error));
  }

}