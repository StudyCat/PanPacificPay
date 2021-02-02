import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_grid_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewFindRootPageHeaderView extends StatefulWidget {
  TPNewFindRootPageHeaderView({Key key,this.userModel,this.didClickItemCallBack,this.didClickHeaderCallBack}) : super(key: key);

  final Function didClickHeaderCallBack;

  final TPfindUserModel userModel;

  final Function didClickItemCallBack;

  @override
  _TPNewFindRootPageHeaderViewState createState() =>
      _TPNewFindRootPageHeaderViewState();
}

class _TPNewFindRootPageHeaderViewState
    extends State<TPNewFindRootPageHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
      ),
      child: Stack(
       children: [_getUserInfoView(),Padding(padding : EdgeInsets.only(top:MediaQuery.of(context).size.width / 750 * 398 - ScreenUtil().setHeight(30) + ScreenUtil.statusBarHeight,left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),child: widget.userModel == null ? Container() : _getActionButtonView(),)]),
    );
  }

  Widget _getUserInfoView() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil.statusBarHeight,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 750 * 398,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assetss/images/find_bg.png'),
                  fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  widget.didClickHeaderCallBack();
                },
                child: Padding(
                padding: EdgeInsets.only(
                    top: kToolbarHeight + ScreenUtil().setHeight(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(44)),
                  child:  Container(
                  height: ScreenUtil().setHeight(88),
                  width: ScreenUtil().setHeight(88),
                  child: widget.userModel == null ? Container(): CachedNetworkImage(
                      imageUrl:
                          widget.userModel.avatar,fit: BoxFit.fitWidth,),
                ),
                )
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: Text(widget.userModel == null ? '' : widget.userModel.nickname,
                    style: TextStyle(
                      color: Colors.white,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getActionButtonView(){
     int cloumnNum = widget.userModel.iconList.length ~/ 5 + (widget.userModel.iconList.length % 5 > 0 ? 1 : 0);
    double height = cloumnNum + ScreenUtil().setHeight(100) + ScreenUtil().setHeight(40); 
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white
      ),
      child:  GridView.builder(
                      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(30)),
                      physics: new NeverScrollableScrollPhysics(), //增加
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.userModel.iconList.length > 5 ? 5 : widget.userModel.iconList.length,
                          childAspectRatio: 0.5,
                          mainAxisSpacing: ScreenUtil().setHeight(20)
                          ),
                      itemCount: widget.userModel.iconList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap : (){
                            widget.didClickItemCallBack(widget.userModel.iconList[index]);
                          },
                          child : TPFindRootPageGridCell(webInfoModel :widget.userModel.iconList[index],)
                        );
                      })
    );
  }

}
