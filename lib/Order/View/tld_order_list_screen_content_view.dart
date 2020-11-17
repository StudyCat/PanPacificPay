import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPOrderListScreenContentView extends StatefulWidget {
  TPOrderListScreenContentView({Key key,this.didClickSureBtnCallBack})
      : super(key: key);

  final Function(int) didClickSureBtnCallBack;

  @override
  _TPOrderListScreenContentViewState createState() =>
      _TPOrderListScreenContentViewState();
}

class _TPOrderListScreenContentViewState
    extends State<TPOrderListScreenContentView> {
  List titles = [
    I18n.of(navigatorKey.currentContext).waitPayLabel,
    I18n.of(navigatorKey.currentContext).havePaidLabel,
    I18n.of(navigatorKey.currentContext).finishedStatusLabel,
    I18n.of(navigatorKey.currentContext).canceledStatusLabel,
  ];

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        color: Color.fromARGB(255, 242, 242, 242),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(I18n.of(context).statusLabel,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51))),
            _getGridView(context),
            _getBottomButton()
          ],
        ),
      ),
    );
  }

  Widget _getGridView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num singleWidth = (size.width - ScreenUtil().setWidth(200)) / 2;
    num height = singleWidth / 5 * 4 + ScreenUtil().setHeight(40);
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      height: height,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: ScreenUtil().setWidth(70),
              crossAxisSpacing: ScreenUtil().setHeight(40),
              childAspectRatio: 2.5),
          itemCount: titles.length,
          itemBuilder: (BuildContext context, int index) {
            return _getGridViewItem(context, index);
          }),
    );
  }

  Widget _getGridViewItem(BuildContext context, int index) {
    if (index != selectedIndex || selectedIndex == null) {
      return OutlineButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        child: Text(
          titles[index],
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Theme.of(context).primaryColor),
        ),
      );
    } else {
      return CupertinoButton(
          child: Text(
            titles[index],
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Colors.white),
          ),
          padding: EdgeInsets.all(0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            
          });
    }
  }

  Widget _getBottomButton() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(100),bottom: ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(80),
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  selectedIndex = null;
                });
                widget.didClickSureBtnCallBack(null);
              },
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
              child: Text(
                I18n.of(context).resetBtnTitle,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
             width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(
          child: Text(
            I18n.of(context).sureBtnTitle,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Colors.white),
          ),
          padding: EdgeInsets.all(0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (selectedIndex != null){
              int status;
              if (selectedIndex == 3){
                status = -1;
              }else{
                status = selectedIndex;
              }
              widget.didClickSureBtnCallBack(status);
            }else{
              widget.didClickSureBtnCallBack(null);
            }
          })
          ),
        ],
      ),
    );
  }
}
