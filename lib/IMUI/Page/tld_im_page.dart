import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_image_show_page.dart';
import 'package:dragon_sword_purse/IMUI/Model/tld_im_model_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_im_input_view.dart';
import '../View/tld_im_header_view.dart';
import '../View/tld_im_other_user_word_message_cell.dart';
import '../View/tld_im_user_word_message_cell.dart';
import '../View/tld_im_user_time_word_message_cell.dart';
import '../View/tld_im_other_user_time_word_message_cell.dart';
import '../View/tld_im_other_user_image_message_cell.dart';
import '../View/tld_im_user_image_message_cell.dart';
import '../View/tld_im_other_user_time_image_message_cell.dart';
import '../View/tld_im_user_time_image_message_cell.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

class TPIMPage extends StatefulWidget {
  TPIMPage({Key key,  this.toUserName,this.orderNo})
      : super(key: key);

  final String orderNo;

  final String toUserName;
  @override
  _TPIMPageState createState() => _TPIMPageState();
}

class _TPIMPageState extends State<TPIMPage> {
  List _dataSource = [];

  int _page;

  TPNewIMManager _manager;

  ScrollController _controller;

  TPIMModelManager _modelManager;

  RefreshController _refreshController;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _page = 0;

    _controller = ScrollController();

    _modelManager = TPIMModelManager();

    _manager = TPNewIMManager();

    getMessageList();

    _manager.getReciveeMessageCallBack(widget.toUserName, (dynamic message){
      if (mounted){
        setState(() {
          _dataSource.add(message);
        });
      }
    });

    _refreshController = RefreshController(initialRefresh: false);
  }

  

  void getMessageList() async {
    await _manager.getConversation(widget.toUserName);
    int page = _dataSource.length ;
    _manager.getHistoryMessage(widget.toUserName,page,
        (List messages) {
      if (page == 0) {
        if (mounted){
        setState(() {
          _dataSource = [];
          _dataSource.addAll(messages);
        });
        }
        Timer(Duration(milliseconds: 500),
              () => _controller.jumpTo(_controller.position.maxScrollExtent));
      } else {
        if (mounted){
                  setState(() {
          _dataSource.insertAll(0, messages);
        });
        }
      }
      _refreshController.refreshCompleted();
    });
  }

  @override
  void dispose() {
    
    _manager.removeRecieveMessageCallBack(widget.toUserName);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'im_page',
        transitionBetweenRoutes: false,
        middle: Text('联系卖家'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
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
    var saveStatus = await Permission.storage.status;
     if (saveStatus == PermissionStatus.denied || saveStatus == PermissionStatus.restricted|| saveStatus == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      sendImageMessage(image);
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
    var saveStatus = await Permission.storage.status;
     if (saveStatus == PermissionStatus.denied || saveStatus == PermissionStatus.restricted|| saveStatus == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    // var saveStatus = await Permission.

    if (image != null) {
      setState(() {
        sendImageMessage(image);
      });
    }
  }

  void sendImageMessage(File image) async {
      TPNewMessageModel messageModel = TPNewMessageModel();
      messageModel.contentType = 2;
      messageModel.imageFile = image;
      messageModel.toUserName = widget.toUserName;
      JMImageMessage imageMessage = await _manager.sendMessage(messageModel);
      if (mounted && imageMessage.state == JMMessageState.send_succeed){
          setState(() {
            _dataSource.add(imageMessage); 
          }); 
      }
       Timer(Duration(milliseconds: 500),
              () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }

  Widget _getFreshWidget(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(complete: Container()),
      onRefresh: () => getMessageList(),
      child: _getMessageListView(context),
    );
  }

  Widget _getMessageListView(BuildContext context) {
    return ListView.builder(
      itemCount: _dataSource.length,
      controller: _controller,
      dragStartBehavior: DragStartBehavior.down,
      itemBuilder: (BuildContext context, int index) {
        var message = _dataSource[index];
        if (message.runtimeType.toString() == 'JMTextMessage') {
          JMTextMessage textMessage = message;
          if (_isNeedToshowTimeLabel(index)) {
            if (textMessage.isSend == true) {
              return TPIMUserTimeWordMessageCell(
                content: textMessage.text,
                createTime: textMessage.createTime,
              );
            } else {
              return TPIMOtherUserTimeWordMessageCell(
                content: textMessage.text,
                createTime: textMessage.createTime,
              );
            }
          } else {
            if (textMessage.isSend == true) {
              return TPIMUserWordMessageCell(
                content: textMessage.text
              );
            } else {
              return TPIMOtherUserWordMessageCell(
                content: textMessage.text,
              );
            }
          }
        } else {
          JMImageMessage imageMessage = message;
          if (_isNeedToshowTimeLabel(index)) {
            if (imageMessage.isSend == true) {
              return GestureDetector(
                onTap : ()=> _openImage(imageMessage.id),
                child : TPIMUserTimeImageMessageCell(
                imageUrl: imageMessage.thumbPath,
                createTime: imageMessage.createTime,
              )
              );
            } else {
              return GestureDetector(
                onTap :()=> _openImage(imageMessage.id),
                child : TPIMOtherUserTimeImageMessageCell(
                message: imageMessage,
                createTime: imageMessage.createTime,
              )
              );
            }
          } else {
            if (imageMessage.isSend == true) {
              return GestureDetector(
                onTap:()=> _openImage(imageMessage.id),
                child : TPIMUserImageMessageCell(
                imageUrl: imageMessage.thumbPath,
              )
              );
            } else {
             return GestureDetector(
               onTap : ()=> _openImage(imageMessage.id),
               child : TPIMOtherUserImageMessageCell(
                message: imageMessage,
              )
             );
            }
          }
        }
      },
    );
  }

  void _openImage(String messageId) async{
    setState(() {
      _isLoading = true;
    });
    String filePath = await _manager.downloadOrignImage(widget.toUserName, messageId);
    setState(() {
      _isLoading = false;
    });
    PageController pageController = PageController();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TPImageShowPage(images: [File(filePath)],isShowDelete: false,pageController:pageController ,index: 0,heroTag: 'IMImage',);
    }));
  }

//判断是否需要展示时间标签
  bool _isNeedToshowTimeLabel(int index) {
    if (index == 0) {
      return true;
    } else {
      JMNormalMessage lastModel = _dataSource[index - 1];
      JMNormalMessage currentModel = _dataSource[index];
      return currentModel.createTime - lastModel.createTime > 30000;
    }
  }

  Widget _getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        // TPIMHeaderView(orderNo: widget.orderNo,),
        Expanded(
          child: _getFreshWidget(context),
        ),
        TPInputView(
          orderNo: widget.orderNo,
          toUserName: widget.toUserName,
          beginEditingCallBack: () {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          },
          didClickCameraBtnCallBack: () {
            _takePhoto();
          },
          didClickPhotoBtnCallBack: () {
            _openGallery();
          },
          didSencMessageCallBack: (TPNewMessageModel messageModel) async {
           JMTextMessage textMessage =  await _manager.sendMessage(messageModel);
           if (mounted && textMessage.state == JMMessageState.send_succeed){
               setState(() {
                 _dataSource.add(textMessage);
               });
           }
           Timer(Duration(milliseconds: 500),
              () => _controller.jumpTo(_controller.position.maxScrollExtent));
          },
        ),
      ],
    );
  }
}
