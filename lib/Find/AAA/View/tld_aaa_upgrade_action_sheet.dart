import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_person_center_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_choose_type_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_choose_type_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPAAAUpgradeActionSheet extends StatefulWidget {
  TPAAAUpgradeActionSheet(
      {Key key, this.didClickUpgrade, this.upgradeInfoModel})
      : super(key: key);

  final TPAAAUpgradeInfoModel upgradeInfoModel;

  final Function didClickUpgrade;

  @override
  _TPAAAUpgradeActionSheetState createState() =>
      _TPAAAUpgradeActionSheetState();
}

class _TPAAAUpgradeActionSheetState extends State<TPAAAUpgradeActionSheet> {
  int _type = 2;

  String _walletAddress;

  int _paymentType = 1;

  TPYLBTypeModel _typeModel;

  @override
  Widget build(BuildContext context) {
    String content = "";
    if (_paymentType == 1){
      content = _walletAddress == null ? '请选择钱包' : _walletAddress;
    }else{
      content = _typeModel == null ? '请选择支付方式' : _typeModel.typeName;
    }
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90.w, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      color: Color.fromARGB(255, 242, 242, 242),
                      height: ScreenUtil().setHeight(80),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('升级',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Color.fromARGB(255, 51, 51, 51))),
                      ),
                    ),
                    _levelWidget(),
                    _getTitleWidget('选择升级类型'),
                    _getChooseUpgradeTypeWidget(),
                    _getTitleWidget('选择支付方式'),
                    _getChoosePaymentTypeWidget(),
                    GestureDetector(
                      onTap: () {
                        if (_paymentType == 1){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TPEchangeChooseWalletPage(
                                      didChooseWalletCallBack:
                                          (TPWalletInfoModel infoModel) {
                                        setState(() {
                                          _walletAddress =
                                              infoModel.walletAddress;
                                        });
                                      },
                                    )));
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TPYLBChooseTypePage(
                                      didChooseTypeCallBack:
                                          (TPYLBTypeModel typeModel) {
                                        setState(() {
                                          _typeModel =
                                              typeModel;
                                        });
                                      },
                                    )));
                        }
                      },
                      child: _walletAddressWidget(
                          content),
                    ),
                    _bottomWidget()
                  ])
                ])));
  }

  Widget _levelWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
      child: Container(
        width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60), 
        child : RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '恭喜您即将升级为V${widget.upgradeInfoModel.nextLevel}  ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 74, 74, 74)),
            children: [
              WidgetSpan(
                  child: Container(
                width: ScreenUtil().setHeight(60),
                height: ScreenUtil().setHeight(60),
                child: CachedNetworkImage(
                  imageUrl: widget.upgradeInfoModel.nextLevelIcon,
                  fit: BoxFit.fill,
                ),
              ))
            ]),
      )
      ),
    );
  }

  Widget _getTitleWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40),left : ScreenUtil().setWidth(30)),
      child: Text(title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 51, 51, 51))),
    );
  }

   Widget _getChoosePaymentTypeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30), left: ScreenUtil().setWidth(30)),
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _getSingleChoiceWidget(
              1,
              '钱包支付',
              2
            )),
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: _getSingleChoiceWidget(
              2,
              '余利宝支付',
              2
            ))
      ]),
    );
  }

  Widget _walletAddressWidget(String content) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _paymentType == 1 ?  '支付钱包' :  '余利宝支付方式',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(280),
                    child: Text(
                      content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )),
                Icon(Icons.keyboard_arrow_right)
              ])
            ],
          )),
    );
  }

  Widget _getChooseUpgradeTypeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30), left: ScreenUtil().setWidth(30)),
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _getSingleChoiceWidget(
              1,
              '普通升级',
              1
            )),
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: _getSingleChoiceWidget(
              2,
              '全部升级',
              1
            ))
      ]),
    );
  }

//selectedType 为1 选择升级方式 ，2 为选择支付方式
  Widget _getSingleChoiceWidget(int type, String title,int selectedType) {
    return Row(children: <Widget>[
      Container(
        height: ScreenUtil().setHeight(18),
        width: ScreenUtil().setHeight(18),
        child: Radio(
          activeColor: Color.fromARGB(255, 51, 51, 51),
          focusColor: Color.fromARGB(255, 51, 51, 51),
          hoverColor: Color.fromARGB(255, 51, 51, 51),
          value: type,
          groupValue: selectedType == 1 ? _type : _paymentType,
          onChanged: (value) {
            setState(() {
              if (selectedType == 1){
                _type = value;
              }else{
                _paymentType = value;
              }
            });
          },
        ),
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: GestureDetector(
              onTap: () {
                setState(() {
              if (selectedType == 1){
                _type = type;
              }else{
                _paymentType = type;
              }
            });
              },
              child: Text(
                title,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
              )))
    ]);
  }

  Widget _bottomWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        height: ScreenUtil().setHeight(80),
        color: Color.fromARGB(255, 242, 242, 242),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: RichText(
                text: TextSpan(
                    text: _type == 1
                        ? widget.upgradeInfoModel.nextTldCount
                        : widget.upgradeInfoModel.fullTldCount,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                        color: Color.fromARGB(255, 74, 74, 74),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'TP',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(260),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).hintColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Text('确认升级',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                  onPressed: () {
                    if (_paymentType == 1 && _walletAddress == null) {
                      Fluttertoast.showToast(msg: '请先选择钱包');
                      return;
                    }
                    if (_paymentType == 2 && _typeModel == null){
                      Fluttertoast.showToast(msg: '请先选择余利宝支付方式');
                      return;
                    }
                    int type = _type;
                    String walletAddress =  _walletAddress == null ? '' : _walletAddress;
                    int ylbType = _typeModel == null ? 0 : _typeModel.type;
                    widget.didClickUpgrade(type, walletAddress,_paymentType,ylbType);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
