import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'dart:convert' show json;

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

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TPfindUserModel {
  TPfindUserModel({
    this.playList,
    this.iconList,
    this.nickname,
    this.avatar,
    this.otherList,
  });

  factory TPfindUserModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TP3rdWebInfoModel> playList =
        jsonRes['playList'] is List ? <TP3rdWebInfoModel>[] : null;
    if (playList != null) {
      for (final dynamic item in jsonRes['playList']) {
        if (item != null) {
          playList
              .add(TP3rdWebInfoModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<TP3rdWebInfoModel> iconList =
        jsonRes['iconList'] is List ? <TP3rdWebInfoModel>[] : null;
    if (iconList != null) {
      for (final dynamic item in jsonRes['iconList']) {
        if (item != null) {
          iconList
              .add(TP3rdWebInfoModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<TP3rdWebInfoModel> otherList =
        jsonRes['otherList'] is List ? <TP3rdWebInfoModel>[] : null;
    if (otherList != null) {
      for (final dynamic item in jsonRes['otherList']) {
        if (item != null) {
          otherList
              .add(TP3rdWebInfoModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TPfindUserModel(
      playList: playList,
      iconList: iconList,
      nickname: asT<String>(jsonRes['nickname']),
      avatar: asT<String>(jsonRes['avatar']),
      otherList: otherList,
    );
  }

  List<TP3rdWebInfoModel> playList;
  List<TP3rdWebInfoModel> iconList;
  String nickname;
  String avatar;
  List<TP3rdWebInfoModel> otherList;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'playList': playList,
        'iconList': iconList,
        'nickname': nickname,
        'avatar': avatar,
        'otherList': otherList,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TP3rdWebInfoModel {
  TP3rdWebInfoModel({
    this.appType,
    this.appId,
    this.uploadType,
    this.name,
    this.iconUrl,
    this.url,
    this.isNeedHideNavigation,
  });

  factory TP3rdWebInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TP3rdWebInfoModel(
              appType: asT<int>(jsonRes['appType']),
              appId: asT<int>(jsonRes['appId']),
              uploadType: asT<int>(jsonRes['uploadType']),
              name: asT<String>(jsonRes['name']),
              iconUrl: asT<String>(jsonRes['iconUrl']),
              url: asT<String>(jsonRes['url']),
              isNeedHideNavigation: asT<bool>(jsonRes['isNeedHideNavigation']),
            );

  int appType;
  int appId;
  int uploadType;
  String name;
  String iconUrl;
  String url;
  bool isNeedHideNavigation;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appType': appType,
        'appId': appId,
        'uploadType': uploadType,
        'name': name,
        'iconUrl': iconUrl,
        'url': url,
        'isNeedHideNavigation': isNeedHideNavigation,
      };

  @override
  String toString() {
    return json.encode(this);
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
      TPFindRootCellUIModel(title: '专栏', isHaveNotice: true, items: [
        // TPFindRootCellUIItemModel(title: '', imageAssest: '',isPlusIcon: true),
      ]),
      TPFindRootCellUIModel(title: '商务合作', isHaveNotice: false,items: [
       
      ])
    ];
  }

  void getBannerInfo(Function success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest({}, 'banner/bannerList');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TPBannerModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void get3rdWebInfo(String qrCodeStr, Function(TP3rdWebInfoModel) success,
      Function(TPError) failure) {
    try {
      if (qrCodeStr.contains('isTP=true')) {
        Uri uri = Uri.parse(qrCodeStr);
        String path = uri.path;
        String origin = uri.origin;
        if (uri.queryParameters.length == 0) {
          TPError error = TPError(400, '无效的二维码');
          failure(error);
          return;
        }
        String iconUrl = uri.queryParameters['iconUrl'];
        String name = uri.queryParameters['name'];
        String url = origin + path;
        if (iconUrl == null || name == null || url == null) {
          TPError error = TPError(400, '无效的二维码');
          failure(error);
          return;
        }
        TP3rdWebInfoModel infoModel = TP3rdWebInfoModel();
        infoModel.url = origin + path;
        infoModel.iconUrl = iconUrl;
        infoModel.isNeedHideNavigation = false;
        infoModel.appType = 0;
        if (uri.queryParameters["isNeedHideNavigation"] != null) {
          if (uri.queryParameters["isNeedHideNavigation"] == "true") {
            infoModel.isNeedHideNavigation = true;
          }
        }
        infoModel.name = name;
        success(infoModel);
      } else {
        TPError error = TPError(400, '无效的二维码');
        failure(error);
      }
    } catch (e) {
      TPError error = TPError(400, '二维码解析失败');
      failure(error);
    }
  }

  void save3rdPartWeb(TP3rdWebInfoModel infoModel, Function success,
      Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest({
      'appUrl': infoModel.url,
      'iconUrl': infoModel.iconUrl,
      "appName": infoModel.name,
      "isNeedHideNavigation": infoModel.isNeedHideNavigation
    }, "play/saveApp");
    request.postNetRequest((value) {
      success();
    }, (error) {
      failure(error);
    });
  }

  void getPlatform3rdWeb(Function success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest({}, "play/appList");
    request.postNetRequest((value) {
      TPfindUserModel userModel = TPfindUserModel.fromJson(value);
      success(userModel);
    }, (error) {
      failure(error);
    });
  }

  void isOpenMission(Function success, Function(TPError) failure) {
    TPBaseRequest request = TPBaseRequest({}, "common/isOpenTask");
    request.postNetRequest((value) {
      success(value);
    }, (error) {
      failure(error);
    });
  }

  void getGamePageInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'play/gameAppList');

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
      success(bannerList, gameList);
    }, (error) => failure(error));
  }

  void haveAcceptanceUser(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'acpt/user/existAcptAccount');
    request.postNetRequest((value) {
      String walletAddress = value['walletAddress'];
      bool isExist = value['isExist'];
      bool needBinding = false;
      bool haveSameWallet = false;
      List purseList = TPDataManager.instance.purseList;
      for (TPWallet wallet in purseList) {
        if (wallet.address == walletAddress) {
          haveSameWallet = true;
          break;
        }
      }
      if (isExist == true) {
        if (haveSameWallet == false) {
          needBinding = true;
        }
      } else {
        needBinding = true;
      }
      success(needBinding);
    }, (error) => failure(error));
  }

  void haveAAAUserInfo(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'aaa/isExistAccount');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

  void isMerchant(Function success, Function failure) {
    TPBaseRequest request = TPBaseRequest({}, 'merchant/isMerchant');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }
}
