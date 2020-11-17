import 'dart:async';
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_alipay_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_bottom_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_diy_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_wechat_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../View/tld_detail_order_header.dart';
import '../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_detail_order_paymethod_cell.dart';

class TPDetailOrderPage extends StatefulWidget {
  TPDetailOrderPage({Key key,this.orderNo}) : super(key: key);

  final String orderNo;

  @override
  _TPDetailOrderPageState createState() => _TPDetailOrderPageState();
}

class _TPDetailOrderPageState extends State<TPDetailOrderPage> {
  List titles = [I18n.of(navigatorKey.currentContext).orderNumLabel, I18n.of(navigatorKey.currentContext).countLabel, I18n.of(navigatorKey.currentContext).shouldPayAmountLabel, I18n.of(navigatorKey.currentContext).paymentTermLabel, I18n.of(navigatorKey.currentContext).receiveAddressLabel];
  bool isOpen = true;
  TPDetailOrderModelManager _modelManager;
  TPDetailOrderModel _detailOrderModel;
  StreamController _controller;
  bool _isLoading;
  // StreamSubscription _systemSubscreption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = StreamController();
    _controller.sink.add(_detailOrderModel);

    _modelManager = TPDetailOrderModelManager();
    _isLoading = false;
    _getDetailOrderInfo();

    _addSystemMessageCallBack();
    // _registerSystemEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
    // _systemSubscreption.cancel();
  }

  void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103 || contentType == 104){
        _getDetailOrderInfo();
      }
    });
  }

  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //     TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       _getDetailOrderInfo();
  //     }
  //   });
  // }

  void _getDetailOrderInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getDetailOrderInfoWithOrderNo(widget.orderNo, (TPDetailOrderModel detailModel){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = detailModel;
      if ((_detailOrderModel.payMethodVO.type == 2 && _detailOrderModel.status == 0 && _detailOrderModel.amIBuyer)){
                      showDialog(context: context,builder: (context) => TPDetailWechatQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  }else if (_detailOrderModel.payMethodVO.type == 3  && _detailOrderModel.status == 0 && _detailOrderModel.amIBuyer){
                    showDialog(context: context,builder: (context) => TPDetailAlipayQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  }else if (_detailOrderModel.payMethodVO.type == 4 && _detailOrderModel.status == 0 && _detailOrderModel.amIBuyer){
                    if (_detailOrderModel.payMethodVO.imageUrl.length > 0) {
                      showDialog(context: context,builder: (context) => TPDetailDiyQrcodeShowView(paymentName: _detailOrderModel.payMethodVO.myPayName,qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,)); 
                    }
          }
      _controller.sink.add(detailModel);
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

  void _cancelOrder(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelOrderWithOrderNo(widget.orderNo, (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '取消订单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _confirmPaid(){
    jugeHavePassword(context, (){
      _surePaid();
    }, TPCreatePursePageType.back, (){
      _surePaid();
    });
  }

  void _uploadPayProofInService(File image){
       setState(() {
      _isLoading = true;
    });
    _modelManager.uploadPayProof(image,  _detailOrderModel.buyerAddress,widget.orderNo, (){
       if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '上传付款凭证成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
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

  void _uploadPayProof(){
   showCupertinoModalPopup(context: context,builder : (BuildContext context){
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoButton(child: Text('拍摄'), onPressed: (){
                          _takePhoto();
                          Navigator.of(context).pop();
                        }),
                        CupertinoButton(child: Text('从相册选择'), onPressed: (){
                          _openGallery();
                          Navigator.of(context).pop();
                        }),
                      ],
                      cancelButton: CupertinoButton(child: Text('取消'), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    );
                  });
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

    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    _uploadPayProofInService(image);  
  }

  /*相册*/
void  _openGallery() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadPayProofInService(image);   
}

  void _surePaid(){
      setState(() {
      _isLoading = true;
    });
    _modelManager.confirmPaid(widget.orderNo, _detailOrderModel.buyerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认我已付款成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _sureSentCoin(){
    jugeHavePassword(context, (){
      _sentCoin();
    }, TPCreatePursePageType.back, (){
      _sentCoin();
    });
  }

  void _sentCoin(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.sureSentCoin(widget.orderNo, _detailOrderModel.sellerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认释放TP成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _remindOrder(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.remindOrder(widget.orderNo, (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '催单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
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
      body: LoadingOverlay(isLoading:_isLoading, child: StreamBuilder(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          TPDetailOrderModel model = snapshot.data;
          if (model == null){
            return LoadingOverlay(isLoading: true, child: Container());
          }else{
            return  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          );
          }
        },
      )),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getAppBar() {
    return SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        Padding(padding: EdgeInsets.only(right : ScreenUtil().setWidth(30)),
        child : IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.orderDescUrl,title: '转账指引',)));
        }))
      ],
      leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floating: true, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      title: Text(I18n.of(context).detailOrderPageTitle),
      flexibleSpace: FlexibleSpaceBar(
        background: TPDetailOrderHeaderView(detailOrderModel: _detailOrderModel,isBuyer: _detailOrderModel.amIBuyer,
        didClickChatBtnCallBack: (){
          String toUserName = '';
          if (_detailOrderModel.amIBuyer){
            toUserName = _detailOrderModel.sellerUserName;
          }else{
            toUserName = _detailOrderModel.buyerUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPIMPage(toUserName: toUserName,orderNo: _detailOrderModel.orderNo,))).then((value){
            _getDetailOrderInfo();
          });
        },
        timeIsOverRefreshUICallBack: (){
          _detailOrderModel = null;
          _controller.sink.add(_detailOrderModel);
          _getDetailOrderInfo();
        },didClickAppealBtnCallBack: (){
         _jumpToOrderAppeal();
        },
        ),
      ),
    );
  }

  void _jumpToOrderAppeal(){
     if (_detailOrderModel.appealId == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TPOrderAppealPage(orderModel: _detailOrderModel,))).then((value) => _getDetailOrderInfo());
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TPJustNoticePage(appealId: _detailOrderModel.appealId,type: TPJustNoticePageType.appealWatching,))).then((value) => _getDetailOrderInfo());
          }
  }

  Widget _getBodyWidget(BuildContext context) {
   bool isNeedAppeal = false;
    String appealTitle = '';
    _getAppealStatusAndAppealTitle((bool isNeed, String title){
      isNeedAppeal = isNeed;
      appealTitle = title;
    });
    return ListView.builder(
        itemCount: isNeedAppeal ? 8 : 7,
        itemBuilder: (BuildContext context, int index) {
          num top;
          if (index == 2) {
            top = ScreenUtil().setHeight(20);
          } else {
            top = ScreenUtil().setHeight(2);
          }
          if (index == 3) {
            return Padding(
              padding: EdgeInsets.only(
                  top: top,
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TPDetailOrderPayMethodCell(
                title: titles[index],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
                isOpen: true,
                paymentModel: _detailOrderModel.payMethodVO,
                didClickCallBack: (){
                  // setState(() {
                  //   isOpen = !isOpen;
                  // });
                  // if (_detailOrderModel.payMethodVO.type == 2 && isOpen == true){
                  //     showDialog(context: context,builder: (context) => TPDetailWechatQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  // }else if (_detailOrderModel.payMethodVO.type == 3 && isOpen == true){
                  //     showDialog(context: context,builder: (context) => TPDetailAlipayQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));                    
                  // }else if (_detailOrderModel.payMethodVO.type == 4 && isOpen == true){
                  //   if (_detailOrderModel.payMethodVO.imageUrl.length > 0) {
                  //     showDialog(context: context,builder: (context) => TPDetailDiyQrcodeShowView(paymentName: _detailOrderModel.payMethodVO.myPayName,qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,)); 
                  //   }else{
                  //     // Fluttertoast.showToast(msg: '未设置二维码');
                  //   }
                  // }
                },
                didClickQrCodeCallBack: (){
                  if (_detailOrderModel.payMethodVO.type == 2){
                      showDialog(context: context,builder: (context) => TPDetailWechatQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  }else if (_detailOrderModel.payMethodVO.type == 3){
                      showDialog(context: context,builder: (context) => TPDetailAlipayQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));                    
                  }else if (_detailOrderModel.payMethodVO.type == 4){
                    if (_detailOrderModel.payMethodVO.imageUrl.length > 0) {
                      showDialog(context: context,builder: (context) => TPDetailDiyQrcodeShowView(paymentName: _detailOrderModel.payMethodVO.myPayName,qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,)); 
                    }else{
                      Fluttertoast.showToast(msg: '未设置二维码');
                    }
                  }
                },
              ),
            );
          }else if(index == 5){
            return _getIMCell();
          }else if(index == 6){
            return isNeedAppeal ? _getAppealCell(appealTitle) : TPDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: _detailOrderModel.amIBuyer,didClickActionBtnCallBack: (String buttonTitle){
              if (buttonTitle == I18n.of(context).cancelOrderBtnTitle){
                _cancelOrder();
              }else if(buttonTitle == '上传付款凭证'){
                _uploadPayProof();
              }else if(buttonTitle == I18n.of(context).sureReleaseTPBtnTitle){
                _sureSentCoin();
              }else if (buttonTitle == I18n.of(context).reminderBtnTitle){
                _remindOrder();
              }
            },);
          }else if(index == 7){
            return TPDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: _detailOrderModel.amIBuyer,didClickActionBtnCallBack: (String buttonTitle){
              if (buttonTitle == I18n.of(context).cancelOrderBtnTitle){
                _cancelOrder();
              }else if(buttonTitle == I18n.of(context).surePaymentBtnTitle){
                _confirmPaid();
              }else if(buttonTitle == I18n.of(context).sureReleaseTPBtnTitle){
                _sureSentCoin();
              }else if (buttonTitle == I18n.of(context).reminderBtnTitle){
                _remindOrder();
              }
            },);
          }else {
            return _getNormalCell(context, top, index);
          }
        });
  }

  void _getAppealStatusAndAppealTitle(Function(bool,String) callBack){
     bool isNeedAppeal = false;
     String appealTitle = '';
    if (_detailOrderModel != null){
      switch (_detailOrderModel.status) {
        case 1 :{
          isNeedAppeal = true;
          appealTitle = I18n.of(context).appealOrderLabel;
        }
        break;
        default :{         
        }
        break;
        }
      }
    if (_detailOrderModel.appealStatus > -1){
      isNeedAppeal = true;
      if (_detailOrderModel.appealStatus == 0) {
        appealTitle = I18n.of(context).orderIsAppealingLabel;
      }else if(_detailOrderModel.appealStatus == 1){
        appealTitle = I18n.of(context).appealOrderSuccessLabel;
      }else if(_detailOrderModel.appealStatus == 2){
        appealTitle = I18n.of(context).appealOrderFailureLabel;
      }else {
        appealTitle = I18n.of(context).appealOrderLabel;
      }
    }
    callBack(isNeedAppeal,appealTitle);
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    String content;
    if(index == 0){
      content = _detailOrderModel.orderNo;
    }else if(index == 1){
      content = _detailOrderModel.txCount + 'TP';
    }else if(index == 2){
      content = '¥'+_detailOrderModel.txCount;
    }else{
      content = _detailOrderModel.buyerAddress;
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
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    );
  }

  Widget _getIMCell(){
    String title = _detailOrderModel.amIBuyer == true ? I18n.of(context).contactSellerLabel : I18n.of(context).contactBuyerLabel;
    return GestureDetector(
      onTap: () { 
        String toUserName = '';
          if (_detailOrderModel.amIBuyer){
            toUserName = _detailOrderModel.sellerUserName;
          }else{
            toUserName = _detailOrderModel.buyerUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPIMPage(toUserName: toUserName,orderNo: _detailOrderModel.orderNo,))).then((value){
            _getDetailOrderInfo();
          });
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TPClipCommonCell(
          type: TPClipCommonCellType.normalArrow,
          title: title,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }

  Widget _getAppealCell(String appealTitle){
    return GestureDetector(
      onTap: () {
        _jumpToOrderAppeal();
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TPClipCommonCell(
          type: TPClipCommonCellType.normalArrow,
          title: appealTitle,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }

}
