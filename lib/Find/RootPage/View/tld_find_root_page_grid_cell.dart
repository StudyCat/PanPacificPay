import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPFindRootPageGridCell extends StatefulWidget {
  TPFindRootPageGridCell({Key key,this.itemUIModel}) : super(key: key);

  final TPFindRootCellUIItemModel itemUIModel;

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
        Offstage(
          offstage: widget.itemUIModel.isPlusIcon,
          child: Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(5)),
            child: Text(widget.itemUIModel.title,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)),textAlign: TextAlign.center,maxLines: 2,),
          ),
        )
      ]
    );
  }

  Widget _getImageWidget(){
    if (widget.itemUIModel.isPlusIcon == false){
      if (widget.itemUIModel.iconUrl.length > 0){
        return ClipRRect(
          child: CachedNetworkImage(imageUrl: widget.itemUIModel.iconUrl,width:ScreenUtil().setHeight(96),height:ScreenUtil().setHeight(96),fit: BoxFit.fill,),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(48))),
        );
      }else{
      return Image.asset(widget.itemUIModel.imageAssest,width:ScreenUtil().setHeight(96),height:ScreenUtil().setHeight(96),fit: BoxFit.fill,);
      }
    }else{
      return Icon(IconData(0xe67e,fontFamily:'appIconFonts'),size: ScreenUtil().setHeight(96), color: Color.fromARGB(255, 153, 153, 153),);
    }
  }

}