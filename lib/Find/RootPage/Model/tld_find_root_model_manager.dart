import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';

class TPBannerModel {
  int bannerId;
  String bannerUrl;
  String bannerHref;
  int bannerSort;
  int createTime;
  bool valid;
  bool isNeedNavigation;

  TPBannerModel(
      {this.bannerId,
      this.bannerUrl,
      this.bannerHref,
      this.bannerSort,
      this.createTime,
      this.valid,
      this.isNeedNavigation});

  TPBannerModel.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerUrl = json['bannerUrl'];
    bannerHref = json['bannerHref'];
    bannerSort = json['bannerSort'];
    createTime = json['createTime'];
    valid = json['valid'];
    isNeedNavigation = json['isNeedNavigation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerUrl'] = this.bannerUrl;
    data['bannerHref'] = this.bannerHref;
    data['bannerSort'] = this.bannerSort;
    data['createTime'] = this.createTime;
    data['valid'] = this.valid;
    data['isNeedNavigation'] = this.isNeedNavigation;
    return data;
  }
}

class TP3rdWebInfoModel{
  String url;
  String iconUrl;
  String name;
  bool isNeedHideNavigation;
  int appType;

   TP3rdWebInfoModel(
      {this.url,
      this.iconUrl,
      this.name,
      this.isNeedHideNavigation,
      this.appType
      });

  TP3rdWebInfoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    iconUrl = json['iconUrl'];
    name = json['name'];
    isNeedHideNavigation = json["isNeedHideNavigation"];
    appType = json["appType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['iconUrl'] = this.iconUrl;
    data['name'] = this.name;
    data["isNeedHideNavigation"] = this.isNeedHideNavigation;
    data["appType"] = this.appType;
    return data;
  }
}

class TPFindRootCellUIModel {
  String title;
  List items;
  bool isHaveNotice;
  TPFindRootCellUIModel({this.title, this.items,this.isHaveNotice});
}

class TPFindRootCellUIItemModel {
  String title;
  String imageAssest;
  bool isPlusIcon;
  String url; //第三方应用地址
  bool isNeedHideNavigation; //第三方应用是否需要导航栏
  String iconUrl;
  int appType;
  TPFindRootCellUIItemModel({this.imageAssest='', this.title='', this.isPlusIcon=false,this.url='',this.iconUrl='',this.isNeedHideNavigation = false,this.appType = 1});
}

class TPFindRootModelManager {
  static List get uiModelList {
    return [
      TPFindRootCellUIModel(title: I18n.of(navigatorKey.currentContext).playingMethodLabel, isHaveNotice: true, items: [
        // TPFindRootCellUIItemModel(title: '', imageAssest: '',isPlusIcon: true),
      ]),
      TPFindRootCellUIModel(title: I18n.of(navigatorKey.currentContext).otherLabel, isHaveNotice: false,items: [
       
      ])
    ];
  }

  void getBannerInfo(Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},'banner/bannerList');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TPBannerModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void get3rdWebInfo(String qrCodeStr,Function(TP3rdWebInfoModel) success,Function(TPError) failure){
     try {
       if (qrCodeStr.contains('isTP=true')){
        Uri uri = Uri.parse(qrCodeStr);
       String path = uri.path;
       String origin = uri.origin;
       if (uri.queryParameters.length == 0){
          TPError error = TPError(400,'无效的二维码');
          failure(error);
          return;
       }
       String iconUrl = uri.queryParameters['iconUrl'];
       String name = uri.queryParameters['name'];
       String url = origin + path;
       if (iconUrl == null || name == null || url == null){
         TPError error = TPError(400,'无效的二维码');
        failure(error);
        return;
       }
       TP3rdWebInfoModel infoModel = TP3rdWebInfoModel();
       infoModel.url = origin + path;
       infoModel.iconUrl = iconUrl;
       infoModel.isNeedHideNavigation = false;
       infoModel.appType = 0;
       if (uri.queryParameters["isNeedHideNavigation"] != null){
         if (uri.queryParameters["isNeedHideNavigation"] == "true"){
           infoModel.isNeedHideNavigation = true;
         }
       }
       infoModel.name = name;
       success(infoModel);
       }else{
         TPError error = TPError(400,'无效的二维码');
        failure(error);
       }
     }catch(e){
       TPError error = TPError(400,'二维码解析失败');
       failure(error);
     }
  }
  

  void save3rdPartWeb(TP3rdWebInfoModel infoModel ,Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({'appUrl':infoModel.url,'iconUrl':infoModel.iconUrl,"appName":infoModel.name,"isNeedHideNavigation":infoModel.isNeedHideNavigation},"play/saveApp");
    request.postNetRequest((value) {
      success();
    }, (error){
      failure(error);
    } );
  }


  void getPlatform3rdWeb(Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},"play/appList");
    request.postNetRequest((value) {
      List playList = value['playList'];
      List otherList = value['otherList'];
      List playResult = [];
      List otherResult = [];
      for (var item in playList) {
        TP3rdWebInfoModel infoModel = TP3rdWebInfoModel.fromJson(item);
        infoModel.appType = 1;
        playResult.add(infoModel);
      }
      for (var item in otherList) {
        TP3rdWebInfoModel infoModel = TP3rdWebInfoModel.fromJson(item);
        infoModel.appType = 1;
        otherResult.add(infoModel);
      }
      success(playResult,otherResult);
    }, (error){
      failure(error);
    } );
  }


  void isOpenMission(Function success,Function(TPError) failure){
    TPBaseRequest request = TPBaseRequest({},"common/isOpenTask");
    request.postNetRequest((value) {
      success(value);
    }, (error){
      failure(error);
    } );
  }



  void getGamePageInfo(Function success,Function failure){
    TPBaseRequest request = TPBaseRequest({},'play/gameAppList');

    request.postNetRequest((value) {
      List bannerStrList = value['gameBannerList'];
      List gameStrList = value['gameList'];
      List bannerList = [];
      List gameList = [];
      for (var item in bannerStrList) {
        bannerList.add(TPBannerModel.fromJson(item));
      }
      for (var item in gameStrList) {
        gameList.add(TP3rdWebInfoModel.fromJson(item));
      }
      success(bannerList,gameList);
    }, (error) => failure(error));
  }

  void haveAcceptanceUser(Function success,Function failure){
     TPBaseRequest request = TPBaseRequest({},'acpt/user/existAcptAccount');
    request.postNetRequest((value) {
      String walletAddress = value['walletAddress'];
      bool isExist = value['isExist'];
      bool needBinding = false;
      bool haveSameWallet = false;
      List purseList = TPDataManager.instance.purseList;
      for (TPWallet wallet in purseList) {
        if (wallet.address == walletAddress){
          haveSameWallet = true;
          break;
        }
      }
      if (isExist == true ){
        if (haveSameWallet == false){
          needBinding = true;
        }
      }else{
        needBinding = true;
      }
      success(needBinding);
    }, (error) => failure(error));
  }


  void haveAAAUserInfo(Function success,Function failure){
      TPBaseRequest request = TPBaseRequest({},'aaa/isExistAccount');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }


  void isMerchant(Function success,Function failure){
      TPBaseRequest request = TPBaseRequest({},'merchant/isMerchant');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }
}
