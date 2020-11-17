  
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_mission_progress_model_manager.dart';

class TPNewMissionPublishMissionModelManager{
  void getPublishMissionList(String walletAddress,int page,Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'walletAddress':walletAddress,'pageNo':page,'pageSize':10,},'newTask/myReleaseBuyList');
    request.postNetRequest((value) {
       Map data = value;
      List dataList = data['list'];
       List result = [];
      for (Map item in dataList) {
        result.add(TPMissionProgressModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void cancelPublish(String taskBuyNo,Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'taskBuyNo':taskBuyNo,},'newTask/cancelRelease');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}