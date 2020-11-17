
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_appeal_model_manager.dart';
import 'package:dragon_sword_purse/Order/View/tld_order_appeal_bottom_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_detail_order_paymethod_cell.dart';
import '../../Drawer/UserFeedback/View/tld_user_feedback_question_desc_cell.dart';
import '../../Drawer/UserFeedback/View/tld_user_feedback_pick_pic_cell.dart';
import 'package:image_picker/image_picker.dart';
import '../../CommonWidget/tld_image_show_page.dart';

class TPOrderAppealPage extends StatefulWidget {
  TPOrderAppealPage({Key key,this.orderModel,this.detailWithDrawModel,this.isReAppeal = false}) : super(key: key);

  final TPDetailOrderModel orderModel;

  final TPAcceptanceWithdrawOrderListModel detailWithDrawModel;

  final bool isReAppeal;

  @override
  _TPOrderAppealPageState createState() => _TPOrderAppealPageState();
}

class _TPOrderAppealPageState extends State<TPOrderAppealPage> {
  List titles = [I18n.of(navigatorKey.currentContext).orderNumLabel, I18n.of(navigatorKey.currentContext).sellerCollectionMethod, I18n.of(navigatorKey.currentContext).sellerAddress, I18n.of(navigatorKey.currentContext).buyerAddress, I18n.of(navigatorKey.currentContext).description200Words, I18n.of(navigatorKey.currentContext).shareCapture];

  bool isOpen;

  List images = [];

  bool _isLoading = false;

  String appealDesc = '';

  PageController _controller;

  TPOrderAppealModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isOpen = false;

    _controller = PageController();

    _manager = TPOrderAppealModelManager();
  }

  void _uploadOrderAppealInfo(){
    setState(() {
      _isLoading = true;
    });
    int appealType;
    if (widget.orderModel != null) {
      appealType = 1;
    }else{
      appealType = 2;
    }
    _manager.uploadImageToService(images, (List urlList){
      _manager.orderAppealToService(urlList, appealDesc, widget.orderModel.orderNo,appealType, (){
        if (mounted){
                  setState(() {
        _isLoading = false;
        });
        }
        Fluttertoast.showToast(msg: '提交申请成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
        if (widget.isReAppeal == true) {
          Navigator.of(context)..pop()..pop();
        }else{
          Navigator.of(context).pop();
        }
      }, (TPError error){
        if (mounted){
                  setState(() {
        _isLoading = false;
        });
        }
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      });
    }, (TPError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'order_appeal_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).appealOrderLabel),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          if (index == 1) {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TPDetailOrderPayMethodCell(
                title: titles[index],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
                isOpen: isOpen,
                paymentModel: widget.orderModel != null ? widget.orderModel.payMethodVO : widget.detailWithDrawModel.payMethodVO,
                didClickCallBack: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
              ),
            );
          } else if (index == 4) {
            return _getPadding(TPUserFeedbackQuestionDescCell(
              title: titles[index],
              placeholder: I18n.of(context).pleaseDescription,
              stringDidChangeCallBack: (String text){
                appealDesc = text;
              },
            ));
          } else if (index == 5) {
            return _getPadding(TPUserFeedbackPickPicCell(
                title: titles[index],
                subTitle: I18n.of(context).singlePicture2M,
                images: images,
                didClickCallBack: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoButton(
                                child: Text('拍摄'),
                                onPressed: () {
                                  _takePhoto();
                                  Navigator.of(context).pop();
                                }),
                            CupertinoButton(
                                child: Text('从相册选择'),
                                onPressed: () {
                                  _openGallery();
                                  Navigator.of(context).pop();
                                }),
                          ],
                          cancelButton: CupertinoButton(
                              child: Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        );
                      });
                },
                didClickImageCallBack: (int index) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TPImageShowPage(
                                images: images,
                                pageController: _controller,
                                index: index,
                                heroTag: 'user_feedback',
                                isShowDelete: true,
                                deleteCallBack: (int index) {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                              )));
                }));
          }else if(index == 6){
            return TPOrderAppealBottomCell(didClickSureBtnCallBack: (){
              if (appealDesc.length == 0){
                Fluttertoast.showToast(msg: '请先填好问题描述',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              if (images.length == 0){
                Fluttertoast.showToast(msg: '请先选择图片',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              _uploadOrderAppealInfo();
            },);
          }

          return _getNormalCell(context, ScreenUtil().setHeight(2), index);
        });
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    String content;
    if(index == 0){
      content = widget.orderModel != null ? widget.orderModel.orderNo : widget.detailWithDrawModel.cashNo;
    }else if (index == 2){
      content = widget.orderModel != null ? widget.orderModel.sellerAddress : widget.detailWithDrawModel.applyWalletAddress;
    }else if (index == 3){
      content = widget.orderModel != null ? widget.orderModel.buyerAddress :widget.detailWithDrawModel.inviteWalletAddress;
    }
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TPClipCommonCell(
          type: TPClipCommonCellType.normal,
          title: titles[index],
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)),
        ),
      ),
    );
  }

  Widget _getPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(2)),
      child: child,
    );
  }

  /*拍照*/
  void _takePhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }

  /*相册*/
  void _openGallery() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }
}
