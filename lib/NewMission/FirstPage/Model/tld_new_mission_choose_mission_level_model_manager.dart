
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPMissionLevelModel {
  int taskLevel;
  String levelIcon;
  String levelName;
  String profitRate;

  TPMissionLevelModel(
      {this.taskLevel, this.levelIcon, this.levelName, this.profitRate});

  TPMissionLevelModel.fromJson(Map<String, dynamic> json) {
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    levelName = json['levelName'];
    profitRate = json['profitRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['levelName'] = this.levelName;
    data['profitRate'] = this.profitRate;
    return data;
  }
}

class TPNewMissionChooseMissionLevelModelManager{
   void getMissionLevelList(Function(List) success,Function(TPError) failure){
     TPBaseRequest request = TPBaseRequest({}, 'newTask/taskLevelList');
     request.postNetRequest((value) {
       List data = value;
       List result = [];
       for (Map item in data) {
         result.add(TPMissionLevelModel.fromJson(item));
       }
       success(result);
     }, (error) => failure(error));
   }
}