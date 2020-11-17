
import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TPCreatePaymentPramaterModel{
  String account = '';
  String imageUrl = '';
  String quota = '';
  String realName = '';
  String subBranch = '';
  int type;
  String walletAddress = '';
  String payId = "";
  String myPayName = '';
}

class TPCreatePaymentModelManager{
   void createPayment(TPCreatePaymentPramaterModel pramaterModel,Function success,Function(TPError) failure){
     Map pramaterMap;
     if (pramaterModel.type == 1){
       pramaterMap = {'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'subBranch':pramaterModel.subBranch};
     }else if(pramaterModel.type == 4){
        pramaterMap = {'account':pramaterModel.account,'myPayName':pramaterModel.myPayName,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'imageUrl':pramaterModel.imageUrl};
     }else{
        pramaterMap = {'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'imageUrl':pramaterModel.imageUrl};
     }
     TPBaseRequest request = TPBaseRequest(pramaterMap, 'pay/addPay');
     request.postNetRequest((dynamic value) {
        success();
     }, (error) => failure(error));
   }

   void updatePayment(TPCreatePaymentPramaterModel pramaterModel,Function success,Function(TPError) failure){
     Map pramaterMap;
     if (pramaterModel.type == 1){
       pramaterMap = {'payId':pramaterModel.payId,'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'subBranch':pramaterModel.subBranch};
     }else if(pramaterModel.type == 4){
        pramaterMap = {'payId':pramaterModel.payId,'account':pramaterModel.account,'myPayName':pramaterModel.myPayName,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'imageUrl':pramaterModel.imageUrl};
     }else{
       pramaterMap = {'payId':pramaterModel.payId,'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'imageUrl':pramaterModel.imageUrl};
     }
     TPBaseRequest request = TPBaseRequest(pramaterMap, 'pay/resetPay');
     request.postNetRequest((dynamic value) {
        success();
     }, (error) => failure(error));
   }
}