

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';

class TPAAAUserInfoModelManager{

  void getUserInfo(int userId,Function success,Function failure){
        TPBaseRequest request = TPBaseRequest({'aaaUserId':userId}, 'aaa/accountUserDetail');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0){
        success(TPAAAUserInfo());
      }else{
        success(TPAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

}