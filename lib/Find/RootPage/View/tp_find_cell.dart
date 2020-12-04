import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPFindCell extends StatefulWidget {
  TPFindCell({Key key, this.itemModel}) : super(key: key);

  final TPFindRootCellUIItemModel itemModel;

  @override
  _TPFindCellState createState() => _TPFindCellState();
}

class _TPFindCellState extends State<TPFindCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(8)),
      child: Container(
        height: ScreenUtil().setHeight(88),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(30)),
            child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: widget.itemModel.iconUrl,
              width: ScreenUtil().setHeight(60),
              height: ScreenUtil().setHeight(60),
              fit: BoxFit.fill,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setHeight(48))),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
            child: Text(
              widget.itemModel.title,
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: ScreenUtil().setSp(28)),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ]),
      ),
    );
  }
}
