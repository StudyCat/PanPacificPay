import 'package:dragon_sword_purse/Purse/FirstPage/View/purse_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPPurseInfoListView extends StatefulWidget {
  TPPurseInfoListView({Key key,this.walletList,this.didClickItemCallBack,this.didClickAddPurseCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  final Function didClickAddPurseCallBack;

  final List walletList;

  @override
  _TPPurseInfoListViewState createState() => _TPPurseInfoListViewState();
}

class _TPPurseInfoListViewState extends State<TPPurseInfoListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        height: ScreenUtil().setHeight(103) + ScreenUtil().setHeight(130) * widget.walletList.length,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(100, 198, 198, 198),
                  offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  )
            ]),
        child: _getListView(),
      ),
    );
  }

  Widget _getListView() {
    return ListView.builder(
      itemCount: widget.walletList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _getHeaderCell();
        }else{
          return TPPurseFirstPageCell(walletInfo: widget.walletList[index - 1],didClickCallBack: (){
            widget.didClickItemCallBack(index - 1);
          },);
        }
      },
    );
  }

  Widget _getHeaderCell() {
    return Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getTitleView(),
                Container(
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setHeight(30),
                  child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(IconData(0xe67e,fontFamily : 'appIconFonts'),color: Color.fromARGB(255, 103, 103, 103),),
                  onPressed: (){
                    widget.didClickAddPurseCallBack();
                  },
                ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
              child: Divider(
                height: ScreenUtil().setHeight(2),
                color: Color.fromARGB(125, 208, 208, 208),
              ),
            )
          ],
        ));
  }

  Widget _getTitleView(){
     return Row(
       children: [
              Container(
                height: ScreenUtil().setHeight(30),
                width: ScreenUtil().setWidth(6),
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                child: Text('我的钱包',
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32))),
              )
            ]);
  }
}
