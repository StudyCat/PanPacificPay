// import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// //消息广播
// class TPMessageEvent {
//    List messageList;
//    TPMessageEvent(this.messageList);
// }

// //未读消息广播
// class TPHaveUnreadMessageEvent{
//   bool haveUnreadMessage;
//   TPHaveUnreadMessageEvent(this.haveUnreadMessage);
// }

// //系统消息广播
// class TPSystemMessageEvent{
//   TPMessageModel messageModel;
//   TPSystemMessageEvent(this.messageModel);
// }

// 进入聊天界面广播
class TPInIMPageEvent{
  
}

//更新消息列表广播
class TPRefreshMessageListEvent{
  int refreshPage; // 1为普通IM页 2位系统页 3为两者
  TPRefreshMessageListEvent(this.refreshPage);
}

//更新首页广播
class TPRefreshFirstPageEvent{
  TPRefreshFirstPageEvent();
}

//底部导航栏点击广播
class TPBottomTabbarClickEvent{
  int index;
  TPBottomTabbarClickEvent(this.index);
}

//承兑底部导航栏点击广播
class TPAcceptanceTabbarClickEvent{
  int index;
  TPAcceptanceTabbarClickEvent(this.index);
}


class TPRegisterCellPhoneChangeEvent{
  String cellPhoneNum;
  TPRegisterCellPhoneChangeEvent(this.cellPhoneNum);
}

class TPAAAUpgradeListRefreshEvent{
  TPAAAUpgradeListRefreshEvent();
}

//提现订单刷新
class TPAcceptaceWithDrawOrderListRefreshEvent{
  TPAcceptaceWithDrawOrderListRefreshEvent();
}