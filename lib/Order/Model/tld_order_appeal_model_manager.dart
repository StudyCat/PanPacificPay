


import 'dart:convert';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Message/Model/tld_just_notice_vote_model_manager.dart';

class TPOrderAppealModelManager{

  void uploadImageToService(List files,Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'');
    request.uploadFile(files, (List urlList){
      List list = [];
      for (Map urlMap in urlList) {
        list.add(urlMap['url']);
      }
      success(list);
    }, (error) => failure(error));
  }

  void orderAppealToService(List imageUrls,String appealDesc,String orderNo,int appealType,Function success,Function(TPError)failure){
      String listJson = jsonEncode(imageUrls);
      TPBaseRequest request = TPBaseRequest({'desc':appealDesc,'imgList':listJson,'orderNo':orderNo,'appealType':appealType},'appeal/create');
      request.postNetRequest((dynamic value) {
          success();
      }, (error) => failure(error));
    }

  void getAppealInfo(int appealId,Function(TPOrderAppealModel) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'appealId':appealId},'appeal/appealDetail');
    request.postNetRequest((value) {
      Map dataMap = value;
      TPOrderAppealModel appealModel = TPOrderAppealModel.fromJson(dataMap);
      success(appealModel);
    }, (error) => failure(error));
  }
}