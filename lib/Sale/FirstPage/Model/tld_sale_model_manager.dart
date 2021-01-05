import 'dart:convert';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';

import '../../../Base/tld_base_request.dart';
import 'tld_sale_list_info_model.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../dataBase/tld_database_manager.dart';


class TPSaleModelManager{
  void getSaleList(int type,Function success,Function(TPError) failure) {
    List purseList = TPDataManager.instance.purseList;
      List addressList = [];
      for (TPWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    TPBaseRequest request = TPBaseRequest({'walletAddressList':addressListJson,'type':type},'sell/list');
    request.postNetRequest((dynamic data) { 
      Map dataMap = data;
      List dataList = dataMap['list'];
      TPTMissionUserInfoModel userInfoModel = TPTMissionUserInfoModel.fromJson(dataMap['userInfo']);
      List result = [];
      for (Map item in dataList) {
        TPSaleListInfoModel model = TPSaleListInfoModel.fromJson(item);
        result.add(model);
      }
      for (TPSaleListInfoModel model in result) {
        for (TPWallet wallet in purseList) {
          if(model.walletAddress == wallet.address){
              model.wallet = wallet;
              break;
          }
        }
      }
      success(result,userInfoModel);
    }, (error) => failure(error));
  }

  void cancelSale(TPSaleListInfoModel model,Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'sellNo':model.sellNo,'walletAddress':model.walletAddress},'sell/cancel');
    request.postNetRequest((dynamic data) {
      success();
     }, (TPError error){
       if(error.code == 10000){
         model.realCount = error.msg;
         cancelSale(model, success, failure);
       }else{
         failure(error);
       }
     });
  }
}