import 'dart:async';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Message/Model/tld_system_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_system_message_cell.dart';

class TPSystemMessageContentPage extends StatefulWidget {
  TPSystemMessageContentPage({Key key}) : super(key: key);

  @override
  _TPSystemMessageContentPageState createState() => _TPSystemMessageContentPageState();
}

class _TPSystemMessageContentPageState extends State<TPSystemMessageContentPage> with AutomaticKeepAliveClientMixin {

  // TPIMManager _manager;

  List _dataSource = [];

  RefreshController _refreshController;

  StreamSubscription _tabbarClickSubscription;

  TPSystemMessageModelManager _modelManager;

  bool _isLoading = false;

  StreamSubscription _refreshSubscription;

  TPNewIMManager _imManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _manager = TPIMManager.instance;
    // _manager.isOnChatPage = true;

    _modelManager = TPSystemMessageModelManager();

    _imManager = TPNewIMManager();

    _refreshController = RefreshController();

    _getSystemList(true);

    registerEvent();

    
    _imManager.addSystemMessageReceiveCallBack((dynamic message){
       if (mounted){
         setState(() {
           _dataSource.insert(0, message);
         });
       }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _imManager.exitSystemConversation();
    _imManager.removeSystemMessageReceiveCallBack();
    // _messageSubscription.cancel();
    _refreshSubscription.cancel();
    _tabbarClickSubscription.cancel();
  }


  void _getSystemList(bool refresh){
    int page = _dataSource.length;
    _modelManager.getSystemMessageList(page, (List messageList){
      if (refresh) {
        _dataSource = [];
      }
        if (mounted){
        setState(() {
          _dataSource.addAll(messageList);
        });
        }
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
    });
  }

   //注册广播
  void registerEvent(){
      _refreshSubscription = eventBus.on<TPRefreshMessageListEvent>().listen((event) {
        if(event.refreshPage == 2 || event.refreshPage == 3){
          _refreshController.requestRefresh();
          _dataSource = [];
          _getSystemList(true); 
        }else{
          TPNewIMManager().exitSystemConversation();
        }
    });

    _tabbarClickSubscription = eventBus.on<TPBottomTabbarClickEvent>().listen((event) {
      if (event.index != 2){
        TPNewIMManager().exitSystemConversation();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
      controller: _refreshController,
      header: WaterDropHeader(
      complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete)
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
                body = Text("放下加载更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _dataSource = [];
        _getSystemList(true);
      },
      onLoading: () => _getSystemList(false),
      child: ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        JMTextMessage textMessage = _dataSource[index];
        return Dismissible(
          key: Key(UniqueKey().toString()), 
          child: _getCellWidget(textMessage),
          onDismissed: (DismissDirection direction){
            setState(() {
              _isLoading = true;
            });
            _modelManager.deleteSystemMessage(textMessage.id, (){
              setState(() {
              _isLoading = false;
              });
              _dataSource.remove(textMessage);
            });
          },
          );
     },
    ),
    ),
    );
  }

  Widget _getCellWidget(JMTextMessage textMessage){
    return GestureDetector(
          onTap:(){
            Map attrMap = textMessage.extras;
            int contentType = int.parse(attrMap['contentType']);
            if ((contentType > 99 && contentType < 105) ||contentType == 107 || contentType == 108){
              String orderNo = attrMap['orderNo'];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TPDetailOrderPage(orderNo: orderNo)));
            }else if ((contentType > 199 && contentType < 205) ||contentType == 207 || contentType == 208){
              String cashNo = attrMap['cashNo'];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TPAcceptanceDetailWithdrawPage(cashNo:cashNo,)));
            }else if(contentType == 105){
              String address = attrMap['toAddress'];
              List purseList = TPDataManager.instance.purseList;
                TPWallet wallet;
                for (TPWallet item in purseList) {
                  if (item.address == address){
                    wallet = item;
                    break;
                  }
                }
             Navigator.push(context,MaterialPageRoute(builder: (context) => TPMyPursePage(wallet: wallet,changeNameSuccessCallBack: (str){},)));
            }else if (contentType == 106){
              int appealId = int.parse(attrMap['appealId']);
              Navigator.push(context, MaterialPageRoute(builder: (context) => TPJustNoticePage(appealId: appealId,)));
            }
          },
          child : TPSystemMessageCell(textMessage: textMessage,)
        );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}