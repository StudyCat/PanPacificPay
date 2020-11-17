
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';

class TPNewMissionDealMissionModelManager{
  
   void getMissionBuyList(String walletAddress,int page,Function(List,String) success, Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'pageNo':page,'walletAddress':walletAddress,'pageSize':10},'newTask/taskBuyList');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
      String progressCount = data['progressCount'];
       List result = [];
      for (Map item in dataList) {
        result.add(TPMissionBuyInfoModel.fromJson(item));
      }
      success(result,progressCount);
    }, (error) => failure(error));
  }

    void buyMission(TPMissionBuyPramaterModel pramaterModel ,Function(String) success, Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':pramaterModel.buyerWalletAddress,'taskBuyNo':pramaterModel.taskBuyNo},'newTask/buyTask');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
    }


    

}