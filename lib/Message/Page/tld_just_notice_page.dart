import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_image_show_page.dart';
import 'package:dragon_sword_purse/Message/Model/tld_just_notice_vote_model_manager.dart';
import 'package:dragon_sword_purse/Message/View/tld_just_appeal_bottom_cell.dart';
import 'package:dragon_sword_purse/Message/View/tld_just_notice_show_desc_cell.dart';
import 'package:dragon_sword_purse/Message/View/tld_just_notice_show_image_cell.dart';
import 'package:dragon_sword_purse/Message/View/tld_just_notice_vote_cell.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_order_paymethod_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_order_appeal_bottom_cell.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

enum TPJustNoticePageType{
  normal,//普通状态作投票用途
  appealWatching//查看申诉进度用途
}

class TPJustNoticePage extends StatefulWidget {
  TPJustNoticePage({Key key,this.appealId,this.type = TPJustNoticePageType.normal}) : super(key: key);

  final TPJustNoticePageType type;

  final int appealId;

  @override
  _TPJustNoticePageState createState() => _TPJustNoticePageState();
}

class _TPJustNoticePageState extends State<TPJustNoticePage> {

  List titles;

  bool isOpen = false;

  List images = [];

  bool _isLoading = false;

  String appealDesc = '';

  int _voteValue = 0;

  PageController _controller;

  TPJustVoteModelManager _manager;

  TPOrderAppealModel _orderAppealModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.type == TPJustNoticePageType.normal) {
      titles = [I18n.of(navigatorKey.currentContext).orderNumLabel, I18n.of(navigatorKey.currentContext).sellerCollectionMethod, I18n.of(navigatorKey.currentContext).sellerAddress, I18n.of(navigatorKey.currentContext).buyerAddress, I18n.of(navigatorKey.currentContext).description200Words, I18n.of(navigatorKey.currentContext).shareCapture,I18n.of(navigatorKey.currentContext).vote];
    }else{
      titles = [I18n.of(navigatorKey.currentContext).orderNumLabel, I18n.of(navigatorKey.currentContext).sellerCollectionMethod, I18n.of(navigatorKey.currentContext).sellerAddress, I18n.of(navigatorKey.currentContext).buyerAddress, I18n.of(navigatorKey.currentContext).description200Words, I18n.of(navigatorKey.currentContext).shareCapture];
    }

    _controller = PageController();

    _manager = TPJustVoteModelManager();

    _getOrderAppealInfo();
  }

  void _getOrderAppealInfo(){
    setState(() {
      _isLoading = true;
    });
    _manager.getOrderAppealInfoWithAppealId(widget.appealId, (TPOrderAppealModel model){
      if (mounted){
              setState(() {
        _isLoading = false;
        _orderAppealModel = model;
      });
      }
    }, (TPError error) {
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _voteOrderAppeal(){
    if (_voteValue == 0){
      Fluttertoast.showToast(msg: '请先选择您的观点');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _manager.voteOrderAppeal(_voteValue,widget.appealId, ()async{
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '投票成功');
      // await TPDataBaseManager.instance.openDataBase();
      // await TPDataBaseManager.instance.deleteVoteSystemMessage(widget.appealId);
      // await TPDataBaseManager.instance.closeDataBase(); 
      Navigator.of(context).pop();
    }, (TPError error) {
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _cancelAppeal(){
    setState(() {
      _isLoading = true;
    });
    _manager.cancelAppeal(widget.appealId, (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '取消申诉成功'); 
      Navigator.of(context).pop();
    }, (TPError error) {
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
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'just_notice_page',
        transitionBetweenRoutes: false,
        middle: Text(widget.type == TPJustNoticePageType.normal ? I18n.of(context).justNotice : I18n.of(context).DetailAppeal),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
         if (widget.type == TPJustNoticePageType.normal) {
           return _getNormalTypeCellBuild(context, index);
         }else {
           return _getAppealTypeCellBuild(context, index);
         }
      });
  }

  Widget _getAppealTypeCellBuild(BuildContext context, int index){
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
                paymentModel: _orderAppealModel == null ? null : _orderAppealModel.payMethodVO,
                didClickCallBack: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
              ),
            );
          } else if (index == 4) {
            return _getPadding(TPJustNoticeShowDescCell(
              title: titles[index],
              description: _orderAppealModel == null ? '':_orderAppealModel.appealDesc,
            ));
          } else if (index == 5) {
            return _getPadding(TPJustNoticeShowImageCell(
                title: titles[index],
                images: _orderAppealModel == null ? [] : jsonDecode(_orderAppealModel.appealImgList),
                didClickImageItemCallBack: (int index){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TPImageShowPage(
                                imagePathList: jsonDecode(_orderAppealModel.appealImgList),
                                pageController: _controller,
                                index: index,
                                heroTag: 'just_notice',
                                isShowDelete: false,
                              )));
                }
               ));
          }else if(index == 6){
            return  _getPadding(TPJustAppealBottomCell(appealStatus : _orderAppealModel != null ? _orderAppealModel.appealStatus : 0,finishTime: _orderAppealModel != null ? _orderAppealModel.finishTime : 0,didClickItemCallBack: (String title){
              if (title == I18n.of(context).repeal) {
                _cancelAppeal();
              }else if(title == I18n.of(context).reapply){
                TPDetailOrderModel orderModel = TPDetailOrderModel();
                orderModel.orderNo = _orderAppealModel.orderNo;
                orderModel.payMethodVO = _orderAppealModel.payMethodVO;
                orderModel.sellerAddress = _orderAppealModel.sellerWalletAddress;
                orderModel.buyerAddress = _orderAppealModel.buyerWalletAddress;
                orderModel.createTime = _orderAppealModel.createTime;
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TPOrderAppealPage(orderModel: orderModel,isReAppeal: true,)));
              }
            },));
          }
          return _getNormalCell(context, ScreenUtil().setHeight(2), index);
  }

  Widget _getNormalTypeCellBuild(BuildContext context, int index){
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
                paymentModel: _orderAppealModel == null ? null : _orderAppealModel.payMethodVO,
                didClickCallBack: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
              ),
            );
          } else if (index == 4) {
            return _getPadding(TPJustNoticeShowDescCell(
              title: titles[index],
              description: _orderAppealModel == null ? '':_orderAppealModel.appealDesc,
            ));
          } else if (index == 5) {
            return _getPadding(TPJustNoticeShowImageCell(
                title: titles[index],
                images: _orderAppealModel == null ? [] : jsonDecode(_orderAppealModel.appealImgList),
                didClickImageItemCallBack: (int index){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TPImageShowPage(
                                imagePathList: jsonDecode(_orderAppealModel.appealImgList),
                                pageController: _controller,
                                index: index,
                                heroTag: 'just_notice',
                                isShowDelete: false,
                              )));
                },
               ));
          }else if(index == 6){
            return  _getPadding( TPJustNoticeVoteCell(title: titles[index],didVoteCallBack: (int voteValue){
              _voteValue = voteValue;
            },));
          }else if(index == 7){
            return TPOrderAppealBottomCell(didClickSureBtnCallBack: (){
              _voteOrderAppeal();
            },);
          }

          return _getNormalCell(context, ScreenUtil().setHeight(2), index);
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    String content = '';
    if (_orderAppealModel != null){
       if(index == 0){
        content = _orderAppealModel.orderNo;
       }else if (index == 2){
        content = _orderAppealModel.sellerWalletAddress;
       }else if (index == 3){
      content = _orderAppealModel.buyerWalletAddress;
    }
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
}