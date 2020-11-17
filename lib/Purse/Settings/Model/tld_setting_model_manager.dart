import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../Base/tld_base_request.dart';

class TPSettingModelManager{

  void deletePurse(TPWallet wallet,Function success ,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAdress':wallet.address,}, 'wallet/deleteWallet');
    request.postNetRequest((dynamic data)async{
      TPDataBaseManager dataBaseManager = TPDataBaseManager();
      await dataBaseManager.openDataBase();
      await dataBaseManager.deleteDataBase(wallet);
      await dataBaseManager.closeDataBase();
      TPDataManager.instance.purseList.remove(wallet);
      success();
    }, (error) => failure(error));
  }

}