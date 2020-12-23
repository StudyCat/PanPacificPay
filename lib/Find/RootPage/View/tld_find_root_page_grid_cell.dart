import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPFindRootPageGridCell extends StatefulWidget {
  TPFindRootPageGridCell({Key key,this.itemUIModel,this.webInfoModel}) : super(key: key);

  final TPFindRootCellUIItemModel itemUIModel;

  final TP3rdWebInfoModel webInfoModel;

  @override
  _TPFindRootPageGridCellState createState() => _TPFindRootPageGridCellState();
}

class _TPFindRootPageGridCellState extends State<TPFindRootPageGridCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children : <Widget>[
        _getImageWidget(),
       Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(5)),
            child: Text(widget.webInfoModel.name,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)),textAlign: TextAlign.center,maxLines: 2,),
          ),
      ]
    );
  }

  Widget _getImageWidget(){
        return ClipRRect(
          child: CachedNetworkImage(imageUrl: widget.webInfoModel.iconUrl,width:ScreenUtil().setHeight(66),height:ScreenUtil().setHeight(66),fit: BoxFit.fill,),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(48))),
        );
  }

}