
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import '../Page/tld_payment_manager_page.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}     
 

class TPPaymentTypeModel {
    TPPaymentTypeModel({
this.payType,
this.payIcon,
this.payName,
    });


  factory TPPaymentTypeModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:TPPaymentTypeModel(payType : asT<int>(jsonRes['payType']),
payIcon : asT<String>(jsonRes['payIcon']),
payName : asT<String>(jsonRes['payName']),
);

  int payType;
  String payIcon;
  String payName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payType': payType,
        'payIcon': payIcon,
        'payName': payName,
};

  @override
String  toString() {
    return json.encode(this);
  }
}



class TPPaymentModel {
  int createTime;
  String payMethodName;
  String imageUrl;
  String quota;
  int payId;
  int type; //
  String walletAddress;
  String account;
  String subBranch;
  String realName;
  String myPayName;
  String payIcon;

  TPPaymentModel(
      {this.createTime,
      this.payMethodName,
      this.imageUrl,
      this.quota,
      this.payId,
      this.type,
      this.walletAddress,
      this.account,
      this.subBranch,
      this.realName,
      this.myPayName,this.payIcon});

  TPPaymentModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    payMethodName = json['payMethodName'];
    imageUrl = json['imageUrl'];
    quota = json['quota'];
    payId = json['payId'];
    type = json['type'];
    walletAddress = json['walletAddress'];
    account = json['account'];
    subBranch = json['subBranch'];
    realName = json['realName'];
    myPayName = json['myPayName'];
    payIcon = json['payIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['payMethodName'] = this.payMethodName;
    data['imageUrl'] = this.imageUrl;
    data['quota'] = this.quota;
    data['payId'] = this.payId;
    data['type'] = this.type;
    data['walletAddress'] = this.walletAddress;
    data['account'] = this.account;
    data['subBranch'] = this.subBranch;
    data['realName'] = this.realName;
    data['myPayName'] = this.myPayName;
    data['payIcon'] = this.payIcon;
    return data;
  }
}

class TPPaymentManagerModelManager{
  void getPaymentInfoList(String walletAddress,int type,Function(List) success,Function(TPError)failure){
    String typeStr = type.toString();
    TPBaseRequest request = TPBaseRequest({'type':typeStr,'walletAddress':walletAddress},'pay/queryPay');
    request.postNetRequest((dynamic value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (Map item in dataList) {
        TPPaymentModel model = TPPaymentModel.fromJson(item);
        result.add(model);
      }
      success(result);
     }, (error) => failure(error));
  }

  void getPaymentTypeList(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'pay/payTypeList');
    request.postNetRequest((value) {
      List result = []; 
      for (Map item in value) {
        result.add(TPPaymentTypeModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}