import 'dart:convert';

import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../../Base/tld_base_request.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../Model/tld_wallet_info_model.dart';

class TPPurseModelManager{

  void getWalletListData(Function(List<TPWalletInfoModel>) success,Function(TPError) failure)async {
      List purseList = TPDataManager.instance.purseList;
      List addressList = [];
      for (TPWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
      TPBaseRequest request = TPBaseRequest({"list":addressListJson}, 'wallet/queryWallet');
     request.postNetRequest((dynamic data) {
      Map dataMap = data;
      List dataList = dataMap['list'];
      List<TPWalletInfoModel> result = [];
      for (TPWallet wallet in purseList) {
        for (Map infoMap in dataList) {
          if (infoMap['walletAddress'] == wallet.address){
            TPWalletInfoModel model = TPWalletInfoModel.fromJson(infoMap);
            model.wallet = wallet;
            result.add(model);
            break;
          }
        }
      }
      success(result);
       }, (error)=> failure(error));
  }


  void getAllAmount(Function(String) success,Function(TPError) failure){
      List purseList = TPDataManager.instance.purseList;
      List addressList = [];
      for (TPWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
      TPBaseRequest request = TPBaseRequest({"list":addressListJson}, 'wallet/queryAccountTotal');
      request.postNetRequest((value) {
        Map data = value;
        success(data['total']);
      }, (error) => failure(error));
  }

    void getRedEnvelopeInfo(String redEnvelopeId,Function(TPDetailRedEnvelopeModel) success,Function(TPError) failure ){
    TPBaseRequest request = TPBaseRequest({'redEnvelopeId':redEnvelopeId},'redEnvelope/redEnvelopeDetail');
    request.postNetRequest((value) {
      TPDetailRedEnvelopeModel detailRedEnvelopeModel = TPDetailRedEnvelopeModel.fromJson(value);
      success(detailRedEnvelopeModel);
    }, (error) => failure(error));
  }

  void recieveRedEnvelope(String redEnvelopeId,String walletAddress,Function success,Function(TPError) failure ){
    TPBaseRequest request = TPBaseRequest({'redEnvelopeId':redEnvelopeId,'receiveWalletAddress':walletAddress},'redEnvelope/receiveRedEnvelope');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

}