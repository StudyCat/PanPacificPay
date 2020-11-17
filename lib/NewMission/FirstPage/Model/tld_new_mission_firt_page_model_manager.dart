

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TPNewMissionFirstPageModelManager{
   void getWalletInfo(String walletAddress,Function(TPWalletInfoModel) success,Function(TPError) failure){
      TPBaseRequest request = TPBaseRequest({'walletAddress' : walletAddress}, 'wallet/queryOneWallet');
      request.postNetRequest((value) {
        Map data = value;
        TPWalletInfoModel model = TPWalletInfoModel.fromJson(data);
        for (TPWallet wallet  in TPDataManager.instance.purseList) {
          if (model.walletAddress == wallet.address){
            model.wallet = wallet;
            break;
          }
        }
        success(model);
      }, (error) => failure(error));
    }

}