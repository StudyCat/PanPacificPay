import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';

class TPMissionDetailOrderModelManager {
  void getDetailOrderInfo(String orderNo, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo}, 'task/taskOrderDetail');
    request.postNetRequest((value) {
      success(TPMissionOrderListModel.fromJson(value));
    }, (error) => failure(error));
  }

  void cancelOrderWithOrderNo(
      String orderNo, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({'orderNo': orderNo}, 'order/cancel');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

//walletAdress 买家地址
  void confirmPaid(
      String orderNo, String walletAdress, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({
      'orderNo': orderNo,
      'walletAddress': walletAdress,
    }, 'order/confirmPaid');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  //walletAdress 卖家地址
  void sureSentCoin(
      String orderNo, String walletAdress, Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({
      'orderNo': orderNo,
      'walletAddress': walletAdress,
    }, 'order/confirmReceived');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  void remindOrder(String orderNo, Function success, Function failure) {
    TPBaseRequest request =
        TPBaseRequest({'orderNo': orderNo}, 'order/reminder');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  void uploadPayProof(File proof, String walletAddress, String orderNo,
      Function success, Function failure) {
    TPBaseRequest imageRequest = TPBaseRequest({}, '');
    imageRequest.uploadFile([proof], (List filePathList) {
      Map payImagePathMap = filePathList.first;
      String payImagePath = payImagePathMap['url'];
      TPBaseRequest request = TPBaseRequest({
        'orderNo': orderNo,
        'walletAddress': walletAddress,
        'payImage': payImagePath
      }, 'order/confirmPaid');
      request.postNetRequest((dynamic value) {
        success();
      }, (error) => failure(error));
    }, (error) => failure(error));
  }
}
