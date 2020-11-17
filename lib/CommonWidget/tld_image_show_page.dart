
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TPImageShowPage extends StatefulWidget {
  TPImageShowPage(
      {Key key, this.images, this.pageController, this.heroTag, this.index = 0,this.isShowDelete = true,this.deleteCallBack,this.imagePathList})
      : super(key: key);

  final List images;
  final int index;
  final String heroTag;
  final PageController pageController;
  final bool isShowDelete;
  final ValueChanged<int> deleteCallBack;
  final List imagePathList;
  @override
  _TPImageShowPageState createState() => _TPImageShowPageState();
}

class _TPImageShowPageState extends State<TPImageShowPage> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                ImageProvider imageProvider;
                if (widget.imagePathList != null){
                  imageProvider = CachedNetworkImageProvider(widget.imagePathList[index]);
                }else{
                  imageProvider = FileImage(widget.images[index]);
                }
                return PhotoViewGalleryPageOptions(
                  imageProvider: imageProvider,
                  heroAttributes: widget.heroTag.isNotEmpty
                      ? PhotoViewHeroAttributes(tag: widget.heroTag)
                      : null,
                );
              },
              itemCount: widget.imagePathList != null ? widget.imagePathList.length : widget.images.length,
              backgroundDecoration: null,
              pageController: widget.pageController,
              enableRotation: true,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 18,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.imagePathList != null ? widget.imagePathList.length : widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32))),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            right: 50,
            top: MediaQuery.of(context).padding.top,
            child: CupertinoButton(child: Text('保存至相册',style: TextStyle(fontSize:ScreenUtil().setSp(32),color: Colors.white),), onPressed: () async{
              if (widget.imagePathList != null){
                String file = await CachedNetworkImageProvider(widget.imagePathList[currentIndex]).cacheManager.getFilePath();
                ImageGallerySaver.saveFile(file);
              }else{
                File file = widget.images[currentIndex];
                ImageGallerySaver.saveFile(file.path);
              }
              Fluttertoast.showToast(msg: '保存成功');
            })
            ),
          widget.isShowDelete == true ? Positioned(
            //右上角删除按钮
            left: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                widget.deleteCallBack(currentIndex);
                Navigator.of(context).pop();
              },
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
