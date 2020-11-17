import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPInviteTeamModel {
  int totalUserCount;
  List<TPInviteUserModel> userList;
  String totalProfit;
  String level;
  bool isOpen = false;

  TPInviteTeamModel({this.totalUserCount, this.userList, this.totalProfit,this.level});

  TPInviteTeamModel.fromJson(Map<String, dynamic> json) {
    totalUserCount = json['totalUserCount'];
    if (json['userList'] != null) {
      userList = new List();
      json['userList'].forEach((v) {
        userList.add(new TPInviteUserModel.fromJson(v));
      });
    }
    totalProfit = json['totalProfit'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUserCount'] = this.totalUserCount;
    // data['userList'] = this.userList;
    data['totalProfit'] = this.totalProfit;
    data['level'] = this.level;
    return data;
  }
}

class TPInviteUserModel{
  String userName;
  String profitAmount;

  TPInviteUserModel({this.userName, this.profitAmount, });

  TPInviteUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    profitAmount = json['profitAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['profitAmount'] = this.profitAmount;
    return data;
  }
}

class TPAcceptanceEarningsModelManager {
    void getInviteTeamInfo(String tel,Function(List) success,Function(TPError) failure){
      TPBaseRequest request = TPBaseRequest({'tel':tel}, 'acpt/user/inviteProfit');
      request.postNetRequest((value) {
        List data = value;
        List result = [];
        for (Map item in data) {
          result.add(TPInviteTeamModel.fromJson(item));
        }
        success(result);
      }, (error) => failure(error));
    }
}