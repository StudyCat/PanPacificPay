import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAddPurseActionSheet extends StatefulWidget {
  TPAddPurseActionSheet({Key key,this.didClickCreatePurseCallBack,this.didClickImportPurseCallBack}) : super(key: key);

  final Function didClickCreatePurseCallBack;

  final Function didClickImportPurseCallBack;

  @override
  _TPAddPurseActionSheetState createState() => _TPAddPurseActionSheetState();
}

class _TPAddPurseActionSheetState extends State<TPAddPurseActionSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
          color: Color.fromARGB(255, 245, 245, 245),
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90.w, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(
      //     top: ScreenUtil().setHeight(40),
      //     left: ScreenUtil().setWidth(30),
      //     right: ScreenUtil().setWidth(30),
      //     bottom: ScreenUtil().setHeight(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getTitleView(),
          _getActionButton(),
          _getCancelButton()
        ],
      ),
    )])),
    );
  }

  Widget _getTitleView(){
    return  Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(22)),
          child: Text('添加钱包',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
        ),
        Padding( 
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(22)),
          child: Divider(
            height: ScreenUtil().setHeight(2),
            indent: 0,
            endIndent: 0,
            color: Color.fromARGB(255, 208, 208, 208),
          ),
        )
      ],
    );
  }

  Widget _getActionButton(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(44),left: ScreenUtil().setWidth(60),right: ScreenUtil().setWidth(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Container(
            height : ScreenUtil().setHeight(90),
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(192)) / 2,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Theme.of(context).primaryColor,
              child: Text('创建钱包',style: TextStyle(color : Colors.white,fontSize: ScreenUtil().setSp(24)),), 
              onPressed: (){
                widget.didClickCreatePurseCallBack();
                Navigator.of(context).pop();
              }),
          ),
          Container(
            height : ScreenUtil().setHeight(90),
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(192)) / 2,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Colors.white,
              child: Text('导入钱包',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)),), 
              onPressed: (){
                widget.didClickImportPurseCallBack();
                Navigator.of(context).pop();
              }),
          )
        ]
      ),
      );
  }

  Widget _getCancelButton(){
     return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(60)),
      child:   Container(
            height : ScreenUtil().setHeight(84),
            width : MediaQuery.of(context).size.width,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Colors.white,
              child: Text('取消',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)),), 
              onPressed: (){
                Navigator.of(context).pop();
              }),
          ),
    );
  }

}