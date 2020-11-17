import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_question_type_model_manager.dart';

class TPUserFeedBackPramatersModel {
  String nickname = '';
  String email = '';
  String imgList = '';
  String questionDesc = '';
  TPUserFeedbackQuestionTypeModel questionType;
  String tel = '';
  List imageFileList = [];
}

class TPUserFeedBackModelManager {
  void sendFeedBack(TPUserFeedBackPramatersModel pramatersModel,
      Function success, Function(TPError) failure) {
    Map pramaters = {
      'nickname': pramatersModel.nickname,
      'email': pramatersModel.email,
      'questionDesc': pramatersModel.questionDesc,
      'questionType': pramatersModel.questionType.questionTypeId,
      'tel': pramatersModel.tel
    };
    if (pramatersModel.imageFileList.length == 0) {
      TPBaseRequest request = TPBaseRequest(pramaters, 'feedback/add');
      request.postNetRequest((value) {
        success();
      }, (error) => failure(error));
    } else {
      this.uploadImageList(pramatersModel.imageFileList, (String imageUrlJson) {
        pramaters.addAll({'imgList': imageUrlJson});
        TPBaseRequest request = TPBaseRequest(pramaters, 'feedback/add');
        request.postNetRequest((value) {
          success();
        }, (error) => failure(error));
      }, (error) => failure(error));
    }
  }

  void uploadImageList(
      List imageList, Function(String) success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest({}, '');
    request.uploadFile(imageList, (List urlList) {
      List resultList = [];
      for (Map item in urlList) {
        resultList.add(item['url']);
      }
      String jsonStr = jsonEncode(resultList);
      success(jsonStr);
    }, (error) => failure(error));
  }
}
