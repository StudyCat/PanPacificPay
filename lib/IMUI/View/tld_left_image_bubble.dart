import 'dart:io';
import 'dart:typed_data';

import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TPLeftImageBubbleView extends StatefulWidget {
  TPLeftImageBubbleView({Key key,this.messageId,this.username}) : super(key: key);

  final String messageId;

  final String username;

  @override
  _TPLeftImageBubbleViewState createState() => _TPLeftImageBubbleViewState();
}

class _TPLeftImageBubbleViewState extends State<TPLeftImageBubbleView> {
 
 String _filePath;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _downloadImage();
  }

  void _downloadImage()async{
    String filePath = await TPNewIMManager().downloadImage(widget.messageId, widget.username);
    setState(() {
      _filePath = filePath;
    });
  } 

  @override
  Widget build(BuildContext context) {
    File file;
    if (_filePath != null){
      file = File(_filePath);
    }
   return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(6)),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius : BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
      child : ClipRRect(
         borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
         child: file != null ? Image.file(file) : Container(height: 200,width: 200,),
       )
    );
  }
}