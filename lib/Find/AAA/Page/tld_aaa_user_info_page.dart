import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_user_info_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPAAAUserInfoPage extends StatefulWidget {
  TPAAAUserInfoPage({Key key,this.userId}) : super(key: key);

  final int userId;

  @override
  _TPAAAUserInfoPageState createState() => _TPAAAUserInfoPageState();
}

class _TPAAAUserInfoPageState extends State<TPAAAUserInfoPage> {

  TPAAAUserInfoModelManager _modelManager;

  bool _isLoading = false;

  TPAAAUserInfo _userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPAAAUserInfoModelManager();
    _getUserInfo();
  }

  void _getUserInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getUserInfo(widget.userId, (TPAAAUserInfo userInfo){
      if (mounted){
        setState(() {
          _isLoading = false;
          _userInfo = userInfo;
        });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'order_list_page',
        transitionBetweenRoutes: false,
        middle: Text('个人信息'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return _userInfo != null ? ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return Padding(
            padding:  EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
            child: _nickNameWidget(_userInfo.nickName, _userInfo.levelIcon),
          );
        }else{
          String title;
          String content;
          if (index == 1){
            title = '微信账号';
            content = _userInfo.wechat;
          }else{
            title = '手机号码';
            content = _userInfo.tel;
          }
          return Padding(
            padding:  EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
            child: TPClipCommonCell(type: TPClipCommonCellType.normal,title: title,content:content,titleStyle:  TextStyle(
                    fontSize: ScreenUtil().setSp(24) ,
                    color: Color.fromARGB(255, 51, 51, 51)),contentStyle: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24)),),
            );
        }
     },
    ) : Container();
  }


  Widget _nickNameWidget(String title, String iconUrl){
    return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: ListTile(
            leading: Text(
              title,
              style: TextStyle(
                    fontSize: ScreenUtil().setSp(24)),
            ),
            trailing:Container(
                child: CachedNetworkImage(
                    imageUrl:
                        iconUrl,
                    width: ScreenUtil().setSp(58),
                    height: ScreenUtil().setSp(58),
                    fit: BoxFit.fill,
                  ),
              )),
      );
  }

}