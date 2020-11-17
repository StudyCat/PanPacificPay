import 'dart:async';

import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Model/tld_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import '../View/tld_im_message_cell.dart';

class TPIMMessageContentPage extends StatefulWidget {
  TPIMMessageContentPage({Key key}) : super(key: key);

  @override
  _TPIMMessageContentPageState createState() => _TPIMMessageContentPageState();
}

class _TPIMMessageContentPageState extends State<TPIMMessageContentPage> with AutomaticKeepAliveClientMixin {
  TPMessageModelManager _modelManager;

  List _dataSource = [];

  StreamSubscription _refreshSubscription;
  @override
  void initState() { 
    super.initState();
    _modelManager = TPMessageModelManager();

    _searchIMChatGroup();

    TPNewIMManager().conversationRecieveMessageCallBack((dynamic message){
      if (message != null){
        _searchIMChatGroup();
      }
    });
  }

  _searchIMChatGroup(){
    _modelManager.searchChatGroup((List groupList){
      _dataSource = [];
      if (mounted){
      setState(() {
        _dataSource.addAll(groupList);
      });
      }
    });
  }

    void registerEvent(){
      _refreshSubscription = eventBus.on<TPRefreshMessageListEvent>().listen((event) {
        if(event.refreshPage == 2 || event.refreshPage == 3){
          _searchIMChatGroup();
        }else{
          TPNewIMManager().exitSystemConversation();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      JMConversationInfo conversationInfo = _dataSource[index];
      return GestureDetector(
        onTap: (){
          _jumpToChatPage(conversationInfo);
        },
        child: TPIMMessageCell(conversationInfo : conversationInfo),
      );
     },
    );
  }

  void _jumpToChatPage(JMConversationInfo conversationInfo){
    JMUserInfo userInfo = conversationInfo.target;
    Navigator.push(context, MaterialPageRoute(builder: (context) => TPIMPage(toUserName: userInfo.username))).then((value) => _searchIMChatGroup());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().conversationRemoveRecieveMessageCallBack();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}