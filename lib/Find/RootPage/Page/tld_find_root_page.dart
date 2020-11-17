import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_change_user_info_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_person_center_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_tab_page.dart';
import 'package:dragon_sword_purse/Find/AmountUpgrade/Page/tp_amount_upgrade_page.dart';
import 'package:dragon_sword_purse/Find/BindInvitePeople/page/tp_bind_invite_people_page.dart';
import 'package:dragon_sword_purse/Find/MerchantJoin/Page/tp_merchant_info_page.dart';
import 'package:dragon_sword_purse/Find/MerchantJoin/Page/tp_merchant_join_page.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_tab_page.dart';
import 'package:dragon_sword_purse/Find/Promotion/tld_promotion_page.dart';
import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_tab_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_send_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_red_envelop_cell.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_bill_Repaying_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_game_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_ad_banner_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_cell.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_tab_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TPFindRootPage extends StatefulWidget {
  TPFindRootPage({Key key}) : super(key: key);

  @override
  _TPFindRootPageState createState() => _TPFindRootPageState();
}

class _TPFindRootPageState extends State<TPFindRootPage> {
  TPFindRootModelManager _modelManager;

  List _bannerList = [];

  List _iconDataSource = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPFindRootModelManager();
    
    _iconDataSource =  TPFindRootModelManager.uiModelList;

    _getBannerList();

    _get3rdWebList();

    _getPlatformWeb();
  }

  void _get3rdWebList() async {
    List webList = await TPDataManager.instance.get3rdPartWebList();

    _addWebAppInPage(webList,[]);
  }


  void _addWebAppInPage(List playList,List otherList){
    TPFindRootCellUIModel playFindRootCellUIModel = _iconDataSource.first;
    List newPlayWebList = [];
    for (TP3rdWebInfoModel item in playList) {
        TPFindRootCellUIItemModel uiItemModel = TPFindRootCellUIItemModel(title: item.name,iconUrl: item.iconUrl,url: item.url,isNeedHideNavigation: item.isNeedHideNavigation,appType: item.appType);
        newPlayWebList.add(uiItemModel);
    }

    TPFindRootCellUIModel otherFindRootCellUIModel = _iconDataSource[1];
    List newOtherWebList = [];
    for (TP3rdWebInfoModel item in otherList) {
        TPFindRootCellUIItemModel uiItemModel = TPFindRootCellUIItemModel(title: item.name,iconUrl: item.iconUrl,url: item.url,isNeedHideNavigation: item.isNeedHideNavigation,appType: item.appType);
        newOtherWebList.add(uiItemModel);
    }

    setState(() {
      playFindRootCellUIModel.items.insertAll(playFindRootCellUIModel.items.length - 1, newPlayWebList);

      otherFindRootCellUIModel.items.addAll(newOtherWebList);
    });
  }

  void _getBannerList(){
    _modelManager.getBannerInfo((List bannerList){
    _bannerList = [];
    if(mounted){
      setState(() {
        _bannerList.addAll(bannerList);
      });
    }
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _getPlatformWeb(){
    _modelManager.getPlatform3rdWeb((List playList,List otherList){
      _addWebAppInPage(playList,otherList);
    }, (error) {

    });
  }

   void _isMerchant(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.isMerchant((bool isHave){
      if (mounted){}
      setState(() {
      _isLoading = false;
    });
      if (isHave){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TPMerchantInfoPage()
        ));
      }else{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TPMerchantJoinPage()
        ));
      }
    }, (TPError error){
      if (mounted){
        setState(() {
      _isLoading = false;
    });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'find_root_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).findPageTitle,),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TPMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
          width : ScreenUtil().setWidth(160),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TPOrderListPage()));
                }),
            MessageButton(
              didClickCallBack: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPMessagePage()));
                },
            )
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _iconDataSource.length + 1,
      itemBuilder: (context,index){
        if (index == 0){
          return TPFindRootADBannerView(bannerList: _bannerList,didClickBannerViewCallBack: (TPBannerModel bannerModel){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TP3rdPartWebPage(isNeedHideNavigation: !bannerModel.isNeedNavigation,urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TPFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          return TPFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TPFindRootCellUIItemModel itemModel){
          if (itemModel.url.length > 0){
              if (itemModel.url == 'BIND_INVITE_CODE'){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  TPBindInvitePeoplePage(),)).then((value){
                  _iconDataSource =  TPFindRootModelManager.uiModelList;
                  _get3rdWebList();
                  _getPlatformWeb();
                });
              }else if (itemModel.url == 'INVITE'){
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  TPPromotionPage(),));
              }
              else if (itemModel.url == 'MERCHANT_JOIN'){
                _isMerchant();
              }else if (itemModel.url == 'TP_TASK'){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  PPMissionTabPage(),));
              }
              // else if (itemModel.url == 'TASK_UPGRADE'){
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => TPAccountUpgradePage()));
              // }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TP3rdPartWebPage(urlStr: itemModel.url,isNeedHideNavigation: itemModel.isNeedHideNavigation,)));
              }
          }else if (itemModel.title.length == 0 && itemModel.url.length == 0){
            _scanPhoto();
          }
          },
          didLongClickItemCallBack: (TPFindRootCellUIItemModel itemModel){
            if (itemModel.url.length > 0 && itemModel.appType == 0){
              showDialog(context: context,builder : (context){
                return TPAlertView(
                  title: I18n.of(context).warning,
                  alertString: I18n.of(context).areYouSureToDelete + '${itemModel.title}?',
                  didClickSureBtn: (){
                    setState(() {
                      uiModel.items.remove(itemModel);
                    });
                    _delete3rdPartWebInfo(itemModel);
                  },
                );
              });
            }
          },
          didClickQuestionItem: (){
            Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.playDescUrl,title: '玩法说明',)));
          },
          );
        }
      });
  }

  Future _scanPhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TPScanQrCodePage(
                  scanCallBack: (String result) {
                    _modelManager.get3rdWebInfo(result,
                        (TP3rdWebInfoModel infoModel) {
                          bool isHaveSameUrl = false;
                          TPFindRootCellUIModel findRootCellUIModel = _iconDataSource.first;
                          for (TPFindRootCellUIItemModel item in findRootCellUIModel.items) {
                            if (item.url == infoModel.url){
                              isHaveSameUrl = true;
                              break;
                            }
                          }
                          if (isHaveSameUrl){
                            Fluttertoast.showToast(msg: I18n.of(context).haveSameApplicationAlertDesc);
                          }else{
                            Fluttertoast.showToast(msg: I18n.of(context).jointhirdPartyApplictionAlertDesc);
                            TPFindRootCellUIItemModel uiItemModel = TPFindRootCellUIItemModel(title: infoModel.name,iconUrl: infoModel.iconUrl,url: infoModel.url,appType: 0,isNeedHideNavigation: infoModel.isNeedHideNavigation);
                            setState(() {
                              findRootCellUIModel.items.insert(findRootCellUIModel.items.length - 1,uiItemModel);
                            });

                            _save3rdPartWebInfo(infoModel);
                          }
                    }, (TPError error) {
                      Fluttertoast.showToast(
                          msg: error.msg,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1);
                    });
                  },
                )));
  }

  void _save3rdPartWebInfo(TP3rdWebInfoModel infoModel) async {
      List webInfoList = TPDataManager.instance.webList;
      webInfoList.add(infoModel);
      List result = [];
      for (TP3rdWebInfoModel infoModel  in webInfoList) {
        result.add(infoModel.toJson());
      }
      String jsonStr = jsonEncode(result);
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setString('3rdPartWeb', jsonStr);

      _save3rdPartWebInService(infoModel);
  }

  void _delete3rdPartWebInfo(TPFindRootCellUIItemModel infoModel) async {
     List webInfoList = TPDataManager.instance.webList;
     TP3rdWebInfoModel deleteModel;
     for (TP3rdWebInfoModel item  in webInfoList) {
       if (item.url == infoModel.url){
         deleteModel = item;
         break;
       }
     }
     List result = [];
     webInfoList.remove(deleteModel);
      for (TP3rdWebInfoModel infoModel  in webInfoList) {
        result.add(infoModel.toJson());
      }
      String jsonStr = jsonEncode(result);
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setString('3rdPartWeb', jsonStr);
  }

  void _save3rdPartWebInService(TP3rdWebInfoModel infoModel){
    _modelManager.save3rdPartWeb(infoModel, (){

    }, (error) {

    });
  }

}