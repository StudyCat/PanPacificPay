
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPUserFeedbackQuestionTypeModel {
  String typeName;
  int questionTypeId;

  TPUserFeedbackQuestionTypeModel({this.typeName, this.questionTypeId});

  TPUserFeedbackQuestionTypeModel.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    questionTypeId = json['questionTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['questionTypeId'] = this.questionTypeId;
    return data;
  }
}

class TPUserFeedbackQuestionTypeModelManager{
  void getQuestTypeList(Function(List) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'question/typeList');
    request.postNetRequest((dynamic value) {
        Map data = value;
        List dataList = data['list'];
        List resultList = [];
        for (Map item in dataList) {
          TPUserFeedbackQuestionTypeModel model = TPUserFeedbackQuestionTypeModel.fromJson(item);
          resultList.add(model);
        }
        success(resultList);
    }, (error) => failure(error));
  }
}