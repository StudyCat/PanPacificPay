

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}     
 

class TPRedEnevelopeListModel {
    TPRedEnevelopeListModel({
this.redEnvelopeId,
this.type,
this.policy,
this.redEnvelopeNum,
this.expireNum,
this.walletAddress,
this.tldCount,
this.expireTldCount,
this.createTime,
this.expireTime,
this.status,
this.receiveList,
this.qrCode,
this.rdesc,
    });


  factory TPRedEnevelopeListModel.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<Object> receiveList = jsonRes['receiveList'] is List ? <Object>[]: null; 
    if(receiveList!=null) {
 for (final dynamic item in jsonRes['receiveList']) { if (item != null) { receiveList.add(asT<Object>(item));  } }
    }


return TPRedEnevelopeListModel(redEnvelopeId : asT<String>(jsonRes['redEnvelopeId']),
type : asT<int>(jsonRes['type']),
policy : asT<int>(jsonRes['policy']),
redEnvelopeNum : asT<int>(jsonRes['redEnvelopeNum']),
expireNum : asT<int>(jsonRes['expireNum']),
walletAddress : asT<String>(jsonRes['walletAddress']),
tldCount : asT<String>(jsonRes['tldCount']),
expireTldCount : asT<String>(jsonRes['expireTldCount']),
createTime : asT<int>(jsonRes['createTime']),
expireTime : asT<int>(jsonRes['expireTime']),
status : asT<int>(jsonRes['status']),
 receiveList:receiveList,
qrCode : asT<Object>(jsonRes['qrCode']),
rdesc : asT<String>(jsonRes['rdesc']),
);}

  String redEnvelopeId;
  int type;
  int policy;
  int redEnvelopeNum;
  int expireNum;
  String walletAddress;
  String tldCount;
  String expireTldCount;
  int createTime;
  int expireTime;
  int status;
  List<Object> receiveList;
  Object qrCode;
  String rdesc;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'redEnvelopeId': redEnvelopeId,
        'type': type,
        'policy': policy,
        'redEnvelopeNum': redEnvelopeNum,
        'expireNum': expireNum,
        'walletAddress': walletAddress,
        'tldCount': tldCount,
        'expireTldCount': expireTldCount,
        'createTime': createTime,
        'expireTime': expireTime,
        'status': status,
        'receiveList': receiveList,
        'qrCode': qrCode,
        'rdesc': rdesc,
};

  @override
String  toString() {
    return json.encode(this);
  }
}



class TPRedEnvelopeModelManager{

  void getRedEnvelopeList(int page,Function(List) success,Function(TPError) failure){
    List purseList = TPDataManager.instance.purseList;
    List addressList = [];
    for (TPWallet item in purseList) {
      addressList.add(item.address);
    }
    String addressListJson = jsonEncode(addressList);
    TPBaseRequest request = TPBaseRequest({'list':addressListJson,'pageNo':page,'pageSize': '10'},'redEnvelope/redEnvelopeList');
    request.postNetRequest((value) {
       List list = value['list'];
       List result = [];
       for (var item in list) {
         result.add(TPRedEnevelopeListModel.fromJson(item));
       }
       success(result);
     }, (error) => failure(error));

  }

}