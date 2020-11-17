import 'dart:async';

import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageButton extends StatefulWidget {
  final Function didClickCallBack;

  final Color color;

  MessageButton({Key key,this.color,this.didClickCallBack}) : super(key: key);

  @override
  _MessageButtonState createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {

  bool _isHaveUnReadMessage = false;

  StreamSubscription _inIMPageSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUnreadStatus();

    TPNewIMManager().conversationRecieveMessageCallBack((dynamic message){
      _getUnreadStatus();
    });

    _registerEvent();
  }

  _registerEvent(){
    _inIMPageSubscription = eventBus.on<TPInIMPageEvent>().listen((event) {
      _getUnreadStatus();
    });
  }

  _getUnreadStatus() async {
    num unreadCount = await TPNewIMManager().getUnreadMessageCount();
    bool haveUnRead = false;
    if (unreadCount > 0){
      haveUnRead = true;
    }
    if(mounted){
      setState(() {
        _isHaveUnReadMessage = haveUnRead;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TPNewIMManager().conversationRemoveRecieveMessageCallBack();
    _inIMPageSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
       child: Stack(
         alignment : FractionalOffset(0.8,0.3),
         children: <Widget>[
           CupertinoButton(
             child: Icon(IconData(0xe63f,fontFamily: 'appIconFonts'),color: widget.color != null ? widget.color : Color.fromARGB(255, 51, 51, 51),),
             onPressed: () => widget.didClickCallBack(),
              padding: EdgeInsets.all(0),
            ),
           Offstage(
             offstage: !_isHaveUnReadMessage,
             child: ClipRRect(
             borderRadius: BorderRadius.all(Radius.circular(3.5)),
             child : Container(
              height: 7,
              width: 7,
              color: Colors.red, 
             ),
           ),
           )
         ],
       ),
    );
  }
}