import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Drawer/AboutUs/Page/tld_about_us_page.dart';
import 'package:dragon_sword_purse/Drawer/IntegrationDesc/Page/tld_integration_desc_page.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_choose_wallet.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Page/tld_user_feedback_page.dart';
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
import 'package:dragon_sword_purse/Find/RootPage/View/tp_find_section_title_cell.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tp_new_find_root_page_header_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tp_new_find_root_page_other_action_cell.dart';
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

  TPfindUserModel _userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPFindRootModelManager();

    _iconDataSource = TPFindRootModelManager.uiModelList;

    _getBannerList();

    _getPlatformWeb();
  }


  void _getBannerList() {
    _modelManager.getBannerInfo((List bannerList) {
      _bannerList = [];
      if (mounted) {
        setState(() {
          _bannerList.addAll(bannerList);
        });
      }
    }, (TPError error) {
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _getPlatformWeb() {
    _modelManager.getPlatform3rdWeb((TPfindUserModel userModel) {
      setState(() {
        _userModel = userModel;
      });
    }, (error) {});
  }

  void _isMerchant() {
    setState(() {
      _isLoading = true;
    });
    _modelManager.isMerchant((bool isHave) {
      if (mounted) {}
      setState(() {
        _isLoading = false;
      });
      if (isHave) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TPMerchantInfoPage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TPMerchantJoinPage()));
      }
    }, (TPError error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: _getBodyWidget(),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '我的',
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
        ),
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
        actions : <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TPOrderListPage()));
                    }),
                MessageButton(
                  didClickCallBack: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TPMessagePage()));
                  },
                )
              ],
            ),
      );
  }

  Widget _getBodyWidget() {
    return ListView.builder(
      padding: EdgeInsets.only(top : 0),
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0){
             return TPNewFindRootPageHeaderView(userModel: _userModel,didClickItemCallBack: (TP3rdWebInfoModel infoModel){
               if (infoModel.url.length > 0) {
                  if (infoModel.url == 'BIND_INVITE_CODE') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TPBindInvitePeoplePage(),
                        )).then((value) {
                      _getPlatformWeb();
                    });
                  } else if (infoModel.url == 'INVITE') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TPPromotionPage(),
                        ));
                  } else if (infoModel.url == 'MERCHANT_JOIN') {
                    _isMerchant();
                  } else if (infoModel.url == 'TP_TASK') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PPMissionTabPage(),
                        ));
                  } else if (infoModel.url == 'RECHARGE') {
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TP3rdPartWebPage(
                                  urlStr: infoModel.url,
                                  isNeedHideNavigation:
                                      infoModel.isNeedHideNavigation,
                                )));
                  }
                }
          },);
          }else if(index == 1){
           return TPFindRootADBannerView(
              bannerList: _bannerList,
              didClickBannerViewCallBack: (TPBannerModel bannerModel) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TP3rdPartWebPage(
                              isNeedHideNavigation:
                                  !bannerModel.isNeedNavigation,
                              urlStr: bannerModel.bannerHref,
                            )));
              },
            );
          }else if (index == 2){
            return TPNewFindRootPageOtherActionCell(didClickItemCallBack: (int index){
              if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TPPaymentChooseWalletPage()));
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TPIntegrationDescPage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TPAboutUsPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TPUserFeedBackPage()));
          }else {
            // TPUserAgreementPage
            Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.tldWalletAgreement,title: I18n.of(context).userAgreement,)));
          }
            },);
          }
          // if (index == 0) {
          //   return TPFindRootADBannerView(
          //     bannerList: _bannerList,
          //     didClickBannerViewCallBack: (TPBannerModel bannerModel) {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => TP3rdPartWebPage(
          //                     isNeedHideNavigation:
          //                         !bannerModel.isNeedNavigation,
          //                     urlStr: bannerModel.bannerHref,
          //                   )));
          //     },
          //   );
          // } else {
          //   TPFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          //   return TPFindSectionTitleCell(
          //     uiModel: uiModel,
          //     didClickItemCallBack: (TPFindRootCellUIItemModel itemModel) {
          //       if (itemModel.url.length > 0) {
          //         if (itemModel.url == 'BIND_INVITE_CODE') {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => TPBindInvitePeoplePage(),
          //               )).then((value) {
          //             _iconDataSource = TPFindRootModelManager.uiModelList;
          //             _get3rdWebList();
          //             _getPlatformWeb();
          //           });
          //         } else if (itemModel.url == 'INVITE') {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => TPPromotionPage(),
          //               ));
          //         } else if (itemModel.url == 'MERCHANT_JOIN') {
          //           _isMerchant();
          //         } else if (itemModel.url == 'TP_TASK') {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => PPMissionTabPage(),
          //               ));
          //         } else if (itemModel.url == 'RECHARGE') {
          //         } else {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => TP3rdPartWebPage(
          //                         urlStr: itemModel.url,
          //                         isNeedHideNavigation:
          //                             itemModel.isNeedHideNavigation,
          //                       )));
          //         }
          //       } else if (itemModel.title.length == 0 &&
          //           itemModel.url.length == 0) {
          //         _scanPhoto();
          //       }
            //   },
            // );

            // TPFindRootCellUIModel uiModel = _iconDataSource[index - 1];
            // return TPFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TPFindRootCellUIItemModel itemModel){
            // if (itemModel.url.length > 0){
            //     if (itemModel.url == 'BIND_INVITE_CODE'){
            //       Navigator.push(context, MaterialPageRoute(builder: (context) =>  TPBindInvitePeoplePage(),)).then((value){
            //         _iconDataSource =  TPFindRootModelManager.uiModelList;
            //         _get3rdWebList();
            //         _getPlatformWeb();
            //       });
            //     }else if (itemModel.url == 'INVITE'){
            //        Navigator.push(context, MaterialPageRoute(builder: (context) =>  TPPromotionPage(),));
            //     }
            //     else if (itemModel.url == 'MERCHANT_JOIN'){
            //       _isMerchant();
            //     }else if (itemModel.url == 'TP_TASK'){
            //       Navigator.push(context, MaterialPageRoute(builder: (context) =>  PPMissionTabPage(),));
            //     }else if (itemModel.url == 'RECHARGE'){

            //     }else{
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=> TP3rdPartWebPage(urlStr: itemModel.url,isNeedHideNavigation: itemModel.isNeedHideNavigation,)));
            //     }
            // }else if (itemModel.title.length == 0 && itemModel.url.length == 0){
            //   _scanPhoto();
            // }
            // },
            // didLongClickItemCallBack: (TPFindRootCellUIItemModel itemModel){
            //   if (itemModel.url.length > 0 && itemModel.appType == 0){
            //     showDialog(context: context,builder : (context){
            //       return TPAlertView(
            //         title: I18n.of(context).warning,
            //         alertString: I18n.of(context).areYouSureToDelete + '${itemModel.title}?',
            //         didClickSureBtn: (){
            //           setState(() {
            //             uiModel.items.remove(itemModel);
            //           });
            //           _delete3rdPartWebInfo(itemModel);
            //         },
            //       );
            //     });
            //   }
            // },
            // didClickQuestionItem: (){
            //   Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.playDescUrl,title: '玩法说明',)));
            // },
            // );
          // }
        }
        );
  }

  // Future _scanPhoto() async {
  //   var status = await Permission.camera.status;
  //   if (status == PermissionStatus.denied ||
  //       status == PermissionStatus.restricted ||
  //       status == PermissionStatus.undetermined) {
  //     Map<Permission, PermissionStatus> statuses = await [
  //       Permission.camera,
  //     ].request();
  //     return;
  //   }

  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => TPScanQrCodePage(
  //                 scanCallBack: (String result) {
  //                   _modelManager.get3rdWebInfo(result,
  //                       (TP3rdWebInfoModel infoModel) {
  //                     bool isHaveSameUrl = false;
  //                     TPFindRootCellUIModel findRootCellUIModel =
  //                         _iconDataSource.first;
  //                     for (TPFindRootCellUIItemModel item
  //                         in findRootCellUIModel.items) {
  //                       if (item.url == infoModel.url) {
  //                         isHaveSameUrl = true;
  //                         break;
  //                       }
  //                     }
  //                     if (isHaveSameUrl) {
  //                       Fluttertoast.showToast(
  //                           msg: I18n.of(context).haveSameApplicationAlertDesc);
  //                     } else {
  //                       Fluttertoast.showToast(
  //                           msg: I18n.of(context)
  //                               .jointhirdPartyApplictionAlertDesc);
  //                       TPFindRootCellUIItemModel uiItemModel =
  //                           TPFindRootCellUIItemModel(
  //                               title: infoModel.name,
  //                               iconUrl: infoModel.iconUrl,
  //                               url: infoModel.url,
  //                               appType: 0,
  //                               isNeedHideNavigation:
  //                                   infoModel.isNeedHideNavigation);
  //                       setState(() {
  //                         findRootCellUIModel.items.insert(
  //                             findRootCellUIModel.items.length - 1,
  //                             uiItemModel);
  //                       });

  //                       _save3rdPartWebInfo(infoModel);
  //                     }
  //                   }, (TPError error) {
  //                     Fluttertoast.showToast(
  //                         msg: error.msg,
  //                         toastLength: Toast.LENGTH_SHORT,
  //                         timeInSecForIosWeb: 1);
  //                   });
  //                 },
  //               )));
  // }

  // void _save3rdPartWebInfo(TP3rdWebInfoModel infoModel) async {
  //   List webInfoList = TPDataManager.instance.webList;
  //   webInfoList.add(infoModel);
  //   List result = [];
  //   for (TP3rdWebInfoModel infoModel in webInfoList) {
  //     result.add(infoModel.toJson());
  //   }
  //   String jsonStr = jsonEncode(result);
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   pre.setString('3rdPartWeb', jsonStr);

  //   _save3rdPartWebInService(infoModel);
  // }

  // void _delete3rdPartWebInfo(TPFindRootCellUIItemModel infoModel) async {
  //   List webInfoList = TPDataManager.instance.webList;
  //   TP3rdWebInfoModel deleteModel;
  //   for (TP3rdWebInfoModel item in webInfoList) {
  //     if (item.url == infoModel.url) {
  //       deleteModel = item;
  //       break;
  //     }
  //   }
  //   List result = [];
  //   webInfoList.remove(deleteModel);
  //   for (TP3rdWebInfoModel infoModel in webInfoList) {
  //     result.add(infoModel.toJson());
  //   }
  //   String jsonStr = jsonEncode(result);
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   pre.setString('3rdPartWeb', jsonStr);
  // }

  // void _save3rdPartWebInService(TP3rdWebInfoModel infoModel) {
  //   _modelManager.save3rdPartWeb(infoModel, () {}, (error) {});
  // }
}
