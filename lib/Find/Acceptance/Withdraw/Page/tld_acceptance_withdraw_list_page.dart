import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_list_cell.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum TPAcceptanceProfitListPageType{
  withdrawing,
  withdrawHistory,
  waitPay,
  waitSentTP
}

class TPAcceptanceWithdrawListPage extends StatefulWidget {
  TPAcceptanceWithdrawListPage({Key key,this.type}) : super(key: key);

  final TPAcceptanceProfitListPageType type;

  @override
  _TPAcceptanceWithdrawListPageState createState() => _TPAcceptanceWithdrawListPageState();
}

class _TPAcceptanceWithdrawListPageState extends State<TPAcceptanceWithdrawListPage>{

  TPAcceptanceWithdrawListModelManager _modelManager;

  List _dataSource = [];

  int _page = 1;

  RefreshController _refreshController;

  bool _isLoading = false;

  StreamSubscription _refreshSubscription;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _modelManager = TPAcceptanceWithdrawListModelManager();
    _getOrderList(_page);

    _addSystemMessageCallBack();

    _registerEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
    _refreshSubscription.cancel();
  }

  void _registerEvent(){
    _refreshSubscription = eventBus.on<TPAcceptaceWithDrawOrderListRefreshEvent>().listen((event) {
      _refreshController.requestRefresh();
      _page = 1;
      _getOrderList(_page);
    });
  }

  void _getOrderList(int page){
    if (widget.type == TPAcceptanceProfitListPageType.withdrawing || widget.type == TPAcceptanceProfitListPageType.waitPay || widget.type == TPAcceptanceProfitListPageType.waitSentTP){
      _modelManager.getWaitPayOrderList(page,widget.type, (List result){
        _dealOrderList(result, page);
      }, (TPError error){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(msg: error.msg);
      });
    }else{
      _modelManager.getOtherStatusOrderList(page, (List result){
        _dealOrderList(result, page);
      }, (TPError error){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(msg: error.msg);
      });
    }
  }

      void _cancelWithdraw(String cashNo){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelWithdraw(cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '取消提现成功');
      _page = 1;
      _getOrderList(_page);
    }, (TPError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _surePay(String cashNo){
    setState(() {
      _isLoading = true;
    });
    _modelManager.withdrawSurePay(cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '确认我已支付成功');
     _page = 1;
      _getOrderList(_page);
    }, (TPError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _sureSentTP(String cashNo){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sentWithdrawTP(cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '确认释放TP成功');
     _page = 1;
      _getOrderList(_page);
    }, (TPError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _reminder(String cashNo){
    setState(() {
      _isLoading = true;
    });
    _modelManager.reminder(cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '催单成功');
    }, (TPError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void alertPassWord(Function function){
    jugeHavePassword(context, function, TPCreatePursePageType.back, function);
  }

   void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 200 || contentType == 201 || contentType == 203 || contentType == 204){
        _page = 1;
        _refreshController.requestRefresh();
        _getOrderList(_page);
      }
    });
  }

  void _dealOrderList(List result,int page){
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    if (page == 1){
      _dataSource = [];
    }
    if(mounted){
      setState(() {
        _dataSource.addAll(result);
      });
    }
    if (result.length > 0){
      _page = page + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: SmartRefresher(
      enablePullDown:  true,
      enablePullUp: true,
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text(I18n.of(context).pullUpToLoad);
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text(I18n.of(context).dropDownToLoadMoreData);
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _page = 1;
        _getOrderList(_page);
      },
      onLoading: () => _getOrderList(_page),
    ));
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TPAcceptanceWithdrawOrderListModel orderListModel = _dataSource[index];
      return GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TPAcceptanceDetailWithdrawPage(cashNo: orderListModel.cashNo,)));
        },
        child : TPAcceptanceWithdrawListCell(orderListModel: orderListModel,didClickIMBtnCallBack:(){
          String toUserName;
           if (orderListModel.amApply){
            toUserName = orderListModel.inviteUserName;
          }else{
            toUserName = orderListModel.applyUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TPIMPage(toUserName: toUserName,orderNo: '',))).then((value){
            _page = 1;
            _refreshController.requestRefresh();
            _getOrderList(_page);
          });
        },
        didClickActionBtn: (String title){
           if (title == I18n.of(context).iHavePaid) {
                  alertPassWord(()=> _surePay(orderListModel.cashNo));
                }else if(title == I18n.of(context).cancelWithdraw){
                  alertPassWord(()=> _cancelWithdraw(orderListModel.cashNo));
                }else if(title == I18n.of(context).sureReleaseTPBtnTitle){
                  alertPassWord(()=> _sureSentTP(orderListModel.cashNo));
                }else if (title == I18n.of(context).reminderBtnTitle){
                  _reminder(orderListModel.cashNo);
                }
        },
        )
      );
     },
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
   
}