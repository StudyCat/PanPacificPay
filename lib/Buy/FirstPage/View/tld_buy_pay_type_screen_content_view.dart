import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPBuyPayTypeScreenContentView extends StatefulWidget {
  TPBuyPayTypeScreenContentView({Key key,this.payTypeList,this.didClickChooseCallBack}) : super(key: key);

  final List payTypeList;

  final Function didClickChooseCallBack;

  @override
  _TPBuyPayTypeScreenContentViewState createState() => _TPBuyPayTypeScreenContentViewState();
}

class _TPBuyPayTypeScreenContentViewState extends State<TPBuyPayTypeScreenContentView> {

  TPScreenPayTypeModel selectedmModel;

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
        decoration: BoxDecoration(
             image: DecorationImage(
                    image: AssetImage('assetss/images/find_bg.png'),
                    fit: BoxFit.fill),
              color: Color.fromARGB(150, 51, 51, 51)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil.statusBarHeight + kToolbarHeight),
              child: Text('支付方式',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.white)),
            ),
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
          padding: EdgeInsets.only(top : 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: ScreenUtil().setWidth(70),
              crossAxisSpacing: ScreenUtil().setHeight(40),
              childAspectRatio: 2.5),
          itemCount: widget.payTypeList.length,
          itemBuilder: (BuildContext context, int index) {
            return _getGridViewItem(context, index);
          }),
    );
  }

  Widget _getGridViewItem(BuildContext context, int index) {
    TPScreenPayTypeModel model = widget.payTypeList[index];
    Color choiceColor = Theme.of(context).primaryColor;
    Color wordColor = Colors.white;
    if (model != selectedmModel || selectedmModel == null) {
      choiceColor = Colors.transparent;
      wordColor = Colors.white;
    } else {

      choiceColor = Colors.white;
      wordColor = Theme.of(context).primaryColor;
    }
    return Container(
        decoration: BoxDecoration(
          color: choiceColor,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color : Colors.white,width :ScreenUtil().setWidth(2))
        ),
        child: CupertinoButton(
          child: Text(
            model.payName,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: wordColor),
          ),
          padding: EdgeInsets.all(0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: choiceColor,
          onPressed: () {
            setState(() {
                selectedmModel = model;
            });
          }),
      );
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
            decoration:  BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color : Colors.white,width :ScreenUtil().setWidth(2))
        ),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  selectedmModel = null;
                });
                widget.didClickChooseCallBack(null);
              },
              child: Text(
                I18n.of(context).resetBtnTitle,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.white),
              ),
            ),
          ),
          Container(
             width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(
          child: Text(
            I18n.of(context).sureBtnTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Theme.of(context).primaryColor),
          ),
          padding: EdgeInsets.all(0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          onPressed: () {
            if (selectedmModel != null){
              
              widget.didClickChooseCallBack(selectedmModel);
            }else{
              widget.didClickChooseCallBack(null);
            }
          })
          ),
        ],
      ),
    );
  }
}