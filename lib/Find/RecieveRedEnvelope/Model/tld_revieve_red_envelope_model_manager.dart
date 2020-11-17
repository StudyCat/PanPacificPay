

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TPRecieveRedEnvelopeModelManager{
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

  void getRecieveRedEnvelopeList(int page, Function success,Function failure){
    List purseList = TPDataManager.instance.purseList;
    List addressList = [];
    for (TPWallet item in purseList) {
      addressList.add(item.address);
    }
    String addressListJson = jsonEncode(addressList);
    TPBaseRequest request = TPBaseRequest({'list':addressListJson,'pageNo':page,'pageSize': '10'},'redEnvelope/receiveLogList');
    request.postNetRequest((value) {
       List list = value['list'];
       List result = [];
       for (var item in list) {
         result.add(TPRedEnvelopeReiceveModel.fromJson(item));
       }
       success(result);
     }, (error) => failure(error));
  }
}