import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}     
 

class TPBillRepayingModel {
    TPBillRepayingModel({
this.ylbRule,
this.clearRule,
this.list,
    });


  factory TPBillRepayingModel.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<TPBillRepayingSonModel> list = jsonRes['list'] is List ? <TPBillRepayingSonModel>[]: null; 
    if(list!=null) {
 for (final dynamic item in jsonRes['list']) { if (item != null) { list.add(TPBillRepayingSonModel.fromJson(asT<Map<String,dynamic>>(item)));  } }
    }


return TPBillRepayingModel(ylbRule : asT<String>(jsonRes['ylbRule']),
clearRule : asT<String>(jsonRes['clearRule']),
 list:list,
);}

  String ylbRule;
  String clearRule;
  List<TPBillRepayingSonModel> list;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ylbRule': ylbRule,
        'clearRule': clearRule,
        'list': list,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class TPBillRepayingSonModel {
    TPBillRepayingSonModel({
this.value,
this.content,
    });


  factory TPBillRepayingSonModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:TPBillRepayingSonModel(value : asT<String>(jsonRes['value']),
content : asT<String>(jsonRes['content']),
);

  String value;
  String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'content': content,
};

  @override
String  toString() {
    return json.encode(this);
  }
}





class TPBillRepayingModelManager{

  void getRepayingInfo(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({}, 'acpt/user/getBillClearDetail');
    request.postNetRequest((value) {
      success(TPBillRepayingModel.fromJson(value));
    }, (error) => failure(error));
  }

  void clearUser(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({}, 'acpt/user/clearBillUser');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}