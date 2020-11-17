import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';

class TPAcceptanceDetailWithdrawModelManager {
  void getDetailInfo(
      String cashNo,
      Function(TPAcceptanceWithdrawOrderListModel) success,
      Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/cashDetail');
    request.postNetRequest((value) {
      success(TPAcceptanceWithdrawOrderListModel.fromJson(value));
    }, (error) => failure(error));
  }

  void cancelWithdraw(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/cancelCash');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void sentWithdrawTP(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmReceived');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void reminder(String cashNo, Function success, Function(TPError) failure){
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/reminder');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void withdrawSurePay(
      String cashNo, Function success, Function(TPError) failure) {
    TPBaseRequest request =
        TPBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmPay');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
