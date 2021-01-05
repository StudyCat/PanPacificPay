import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_quick_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_quick_buy_view.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tp_new_buy_list_cell.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_buy_search_field.dart';
import '../View/tld_buy_firstpage_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Order/Page/tld_order_list_page.dart';
import '../View/tld_buy_action_sheet.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Model/tld_buy_model_manager.dart';

class TPBuyPage extends StatefulWidget {
  TPBuyPage({Key key}) : super(key: key);

  @override
  _TPBuyPageState createState() => _TPBuyPageState();
}

class _TPBuyPageState extends State<TPBuyPage> with AutomaticKeepAliveClientMixin {

  TPBuyModelManager _modelManager;

  RefreshController _refreshController;

  StreamController _streamController;

  bool _isLoading;

  int _page;

  String _keyword;

  List _dataSource;

  FocusNode _focusNode;

  String _quickBuyCount = '';
   
  // StreamSubscription _unreadSubscription;

  // StreamSubscription _systemSubscription;

  StreamSubscription _tabbatClickSubscription;

  // bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _isLoading = false;
    _modelManager = TPBuyModelManager();
    _refreshController = RefreshController(initialRefresh: true);
    _streamController = StreamController();
    _page = 1;
    _dataSource = [];
    // _haveUnreadMessage = TPIMManager.instance.unreadMessage.length > 0;
    // _registerUnreadMessageEvent();
    // _registerSystemMessageEvent();
    _registerTabbarClickEvent();
    _loadBuyList(_keyword, _page);

    _addSystemMessageCallBack();
  }

  //   void _registerUnreadMessageEvent(){
  //   _unreadSubscription = eventBus.on<TPHaveUnreadMessageEvent>().listen((event) {
  //     setState(() {
  //       _haveUnreadMessage = event.haveUnreadMessage;
  //     });
  //   });
  // }

  void _registerTabbarClickEvent(){
    _tabbatClickSubscription = eventBus.on<TPBottomTabbarClickEvent>().listen((event) {
      if(event.index != 1){
        _focusNode.unfocus();
      }
    });
  }

  void _addSystemMessageCallBack(){
    TPNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103){
        _page = 1;
        _loadBuyList(_keyword, _page);
      }
    });
  }

  // void _registerSystemMessageEvent(){
  //   _systemSubscription = eventBus.on<TPSystemMessageEvent>().listen((event) {
  //      TPMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103){
  //       _page = 1;
  //       _loadBuyList(_keyword, _page);
  //     }
  //   });
  // }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _unreadSubscription.cancel();
    // _systemSubscription.cancel();
    _tabbatClickSubscription.cancel();
    _streamController.close();

    TPNewIMManager().removeSystemMessageReceiveCallBack();
  }

  void _loadBuyList(String keyword,int page){
    _modelManager.getBuyListData(keyword, page, (List data){
      if(page == 1){
        _dataSource = [];
        if (mounted) {
          _streamController.sink.add(_dataSource);
        }
      }
      _dataSource.addAll(data);
      if (mounted) {
          _streamController.sink.add(_dataSource);
        }      
      if(data.length > 0){
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  void buyTPCoinWithPramaterModel(TPBuyPramaterModel pramaterModel){
      setState(() {
        _isLoading = true;
      });
    _modelManager.buyTPCoin(pramaterModel, (String orderNo){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).buySuccess,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _focusNode.unfocus();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPDetailOrderPage(orderNo: orderNo,))).then((value){
        _refreshController.requestRefresh();
        _page = 1;
        _loadBuyList(_keyword, _page);
      });
    }, (TPError error){
      if(mounted){
              setState(() {
        _isLoading = false;
      });
      }
      if (error.code == 1000){
        showDialog(context: context,builder : (context)=> TPAlertView(type: TPAlertViewType.normal,alertString: error.msg,title: '温馨提示',didClickSureBtn: (){},));
      }else{
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
    });
  }

  void quickBuyInputPassword(String count ,String walletAddress){
     jugeHavePassword(context, (){
       _quickBuy(count, walletAddress);
    }, TPCreatePursePageType.back, (){
      _quickBuy(count,walletAddress);
    });
  }

//type 为0普通购买  1 快捷
  void _getRate(int type,TPBuyListInfoModel model,String count,String walletAddress){
     setState(() {
        _isLoading = true;
      });
    _modelManager.getRate((double rate){
        if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      if (type == 0){
        showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TPBuyActionSheet(model: model,rate: rate,didClickBuyBtnCallBack: (TPBuyPramaterModel pramaterModel){
                buyTPCoinWithPramaterModel(pramaterModel);
              },);
            });
      }else{
        showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TPQuickBuyActionSheet(count: _quickBuyCount,rate: rate,didClickBuyCallBack: (String count,String walletAddress){
                quickBuyInputPassword(count, walletAddress);
              });
            });
      }
    }, (TPError error){
       if(mounted){
              setState(() {
        _isLoading = false;
      });
      }
      if (error.code == 1000){
        showDialog(context: context,builder : (context)=> TPAlertView(type: TPAlertViewType.normal,alertString: error.msg,title: '温馨提示',didClickSureBtn: (){},));
      }else{
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
    });
  }

  void _quickBuy(String count ,String walletAddress){
      setState(() {
        _isLoading = true;
      });
    _modelManager.quickBuy(count, walletAddress, (){
        if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).buySuccess,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _focusNode.unfocus();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPOrderListPage())).then((value){
        _refreshController.requestRefresh();
        _page = 1;
        _loadBuyList(_keyword, _page);
      });
    }, (TPError error){
       if(mounted){
              setState(() {
        _isLoading = false;
      });
      }
      if (error.code == 1000){
        showDialog(context: context,builder : (context)=> TPAlertView(type: TPAlertViewType.normal,alertString: error.msg,title: '温馨提示',didClickSureBtn: (){},));
      }else{
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(size.width)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'buy_page',
        backgroundColor: Theme.of(context).primaryColor,
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).commonPageTitle,style: TextStyle(color : Colors.white),),
        actionsForegroundColor: Colors.white,
        automaticallyImplyLeading: false,
        trailing: Container(
          width : ScreenUtil().setWidth(160),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  _focusNode.unfocus();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TPOrderListPage()));
                }),
            MessageButton(
              color: Colors.white,
              didClickCallBack: (){
                _focusNode.unfocus(); 
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPMessagePage()));
                },
            )
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(double screenWidth){
    return Column(
      children: <Widget>[
         TPQuickBuyView(focusNode: _focusNode,textDidChange: (String text){
          _quickBuyCount = text;
        },didClickDonehBtnCallBack: (){
          if (_quickBuyCount.length > 0){
            _getRate(1, null, _quickBuyCount,walletAdress);
          }else{
            Fluttertoast.showToast(msg: '请填写购买数量');
          }
        },),
        Expanded(child: TPEmptyListView(getListViewCellCallBack:(int index){
        TPBuyListInfoModel model = _dataSource[index];
          return TPNewBuyListCell(model: model,didClickBuyBtnCallBack: (){
            _getRate(0, model, null,null);
          },);
      }, getEmptyViewCallBack:(){
        return TPEmptyDataView(imageAsset: 'assetss/images/no_data.png', title: '暂无可购买的单子');
      }, streamController: _streamController,
      refreshController: _refreshController,
      refreshCallBack: (){
        _page = 1;
          _loadBuyList(_keyword, _page);
      },loadCallBack: (){
          _loadBuyList(_keyword, _page);
      },))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
