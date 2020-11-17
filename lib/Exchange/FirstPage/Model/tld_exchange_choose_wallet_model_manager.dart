import '../../../Base/tld_base_request.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../dataBase/tld_database_manager.dart';
import 'dart:convert';



class TPExchangeChooseWalletModelManager{
  void getWalletListData(bool isNeedFilter,Function(List<TPWalletInfoModel>) success,Function(TPError) failure)async {
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
      List canChangeList = [];
      if (isNeedFilter == true){
        for (Map item in dataList) {
          if(item['existSell'] == false){
            canChangeList.add(item);
        }
      }
      }else{
        canChangeList = List.from(dataList);
      }
      List<TPWalletInfoModel> result = [];
      for (TPWallet wallet in purseList) {
        for (Map infoMap in canChangeList) {
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


  void bindingWalletAddress(String walletAddress, Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress' : walletAddress}, 'acpt/user/bindWallet');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}