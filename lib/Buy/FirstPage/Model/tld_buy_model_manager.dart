
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TPBuyPramaterModel{
  String buyCount;
  String buyerAddress;
  String sellNo;
}

class TPBuyListInfoModel {
  String sellId;
  String sellNo;
  String totalCount;
  String currentCount;
  String max;
  String payMethod;
  String sellerWalletAddress;
  String createTime;
  TPPaymentModel payMethodVO;
  bool isMine = false;
  String maxAmount;

  TPBuyListInfoModel(
      {this.sellId,
      this.sellNo,
      this.totalCount,
      this.currentCount,
      this.max,
      this.payMethod,
      this.sellerWalletAddress,
      this.createTime,
      this.isMine,
      this.payMethodVO,this.maxAmount});

  TPBuyListInfoModel.fromJson(Map<String, dynamic> json) {
    sellId = json['sellId'];
    sellNo = json['sellNo'];
    totalCount = json['totalCount'];
    currentCount = json['currentCount'];
    max = json['max'];
    payMethod = json['payMethod'];
    sellerWalletAddress = json['sellerWalletAddress'];
    createTime = json['createTime'];
    payMethodVO = TPPaymentModel.fromJson(json['payMethodVO']);
    maxAmount = json['maxAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellId'] = this.sellId;
    data['sellNo'] = this.sellNo;
    data['totalCount'] = this.totalCount;
    data['currentCount'] = this.currentCount;
    data['max'] = this.max;
    data['payMethod'] = this.payMethod;
    data['sellerWalletAddress'] = this.sellerWalletAddress;
    data['createTime'] = this.createTime;
    data['payMethodVO'] = this.payMethodVO.toJson();
    data['maxAmount'] = this.maxAmount;
    return data;
  }
}


class TPBuyModelManager{

  void getBuyListData(String keywords,int page,Function(List) success,Function(TPError) failure){
    Map pramaters;
    if(keywords != null && keywords.length > 0){
      pramaters = {'keywords':keywords,'pageNo':page,'pageSize':10};
    }else{
      pramaters = {'pageNo':page,'pageSize':10};
    }
    TPBaseRequest request = TPBaseRequest(pramaters, 'sell/buyList');
    request.postNetRequest((dynamic value) {
      Map data = value;
      List dataList = data['list'];
      List resultData = [];
      for (Map item in dataList) {
        TPBuyListInfoModel model = TPBuyListInfoModel.fromJson(item);
        resultData.add(model);
      }
      List purseList = TPDataManager.instance.purseList;
      for (TPWallet wallet in purseList) {
        for (TPBuyListInfoModel model in resultData) {
          if(wallet.address == model.sellerWalletAddress){
            model.isMine = true;
            break;
          }
        }
      }
      success(resultData);
    }, (error) => failure(error));
  }

  void buyTPCoin(TPBuyPramaterModel pramaterModel,Function(String) success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'buyCount':pramaterModel.buyCount,'buyerAddress':pramaterModel.buyerAddress,'sellNo':pramaterModel.sellNo}, 'order/create');
    request.postNetRequest((dynamic value) {
      Map data = value;
      String orderNo = data['orderNo'];     
      success(orderNo);
     }, (error) => failure(error));
  }

  void quickBuy(String count,String walletAddress,Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({'buyCount':count,'buyerAddress':walletAddress},'order/quickBuy');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void getRate(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'order/getUsdRate');
    request.postNetRequest((value) {
      success(double.parse(value));
    }, (error) => failure(error));
  }
}