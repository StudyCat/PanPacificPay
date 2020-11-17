import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceSignHeaderView extends StatefulWidget {
  TPAcceptanceSignHeaderView(
      {Key key,
      this.didClickLoginCallBack,
      this.userInfoModel,
      this.didClickWithdrawButtonCallBack,
      this.didClickProfitCallBack,
      this.didClickRollOutCallBack})
      : super(key: key);

  final Function(bool) didClickLoginCallBack; //回调是否为签到true为签到，false为登记

  final TPAcceptanceUserInfoModel userInfoModel;

  final Function didClickWithdrawButtonCallBack;

  final Function(String) didClickProfitCallBack;

  final Function didClickRollOutCallBack;

  @override
  _TPAcceptanceSignHeaderViewState createState() =>
      _TPAcceptanceSignHeaderViewState();
}

class _TPAcceptanceSignHeaderViewState
    extends State<TPAcceptanceSignHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                child: _getTopRowWidget(),
              ),
              _getAmountWidget(),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: Divider(
                    height: ScreenUtil().setHeight(2),
                    color: Color.fromARGB(255, 219, 218, 216)),
              ),
              _getInfoRowWedget(),
              _getProfitWidget()
            ]),
      ),
    );
  }

  Widget _getTopRowWidget() {
    String token = TPDataManager.instance.acceptanceToken;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getTopLeftRowWidget(),
        Offstage(
          offstage:  token != null,
          child: Container(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(130),
          child: CupertinoButton(
            child: Text( I18n.of(context).signIn,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Theme.of(context).hintColor)),
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
            onPressed: () => widget.didClickLoginCallBack(token != null),
          ),
        ),
        )
      ],
    );
  }

  Widget _getTopLeftRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'assetss/images/icon_sale.png',
          width: ScreenUtil().setHeight(60),
          height: ScreenUtil().setHeight(60),
          fit: BoxFit.cover,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          _getUserInfoWidget(
              0xe6b3,
              widget.userInfoModel != null
                  ? widget.userInfoModel.userName
                  : I18n.of(context).notLogin),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(4),
            ),
            child: _getUserInfoWidget(
                0xe605,
                widget.userInfoModel != null
                    ? widget.userInfoModel.tel
                    : I18n.of(context).notLogin),
          ),
        ])
      ],
    );
  }

  Widget _getUserInfoWidget(int iconCode, String content) {
    return RichText(
        text: TextSpan(children: <InlineSpan>[
      WidgetSpan(
          child: Icon(
        IconData(iconCode, fontFamily: 'appIconFonts'),
        size: ScreenUtil().setHeight(24),
        color: Color.fromARGB(255, 153, 153, 153),
      )),
      TextSpan(
          text: '  ' + content,
          style: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: ScreenUtil().setSp(24)))
    ]));
  }

  Widget _getAmountWidget() {
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: widget.userInfoModel != null
                      ? widget.userInfoModel.totalWithdraw + 'TP'
                      : '0.0TP',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51)),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '\n' + I18n.of(context).withdrawLimit,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )
                  ]),
            ),
            // Container(
            //       height : ScreenUtil().setHeight(60),
            //       width : ScreenUtil().setWidth(130),
            //       child: CupertinoButton(
            //         onPressed: widget.didClickWithdrawButtonCallBack,
            //         padding: EdgeInsets.zero,
            //         color: Theme.of(context).primaryColor,
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         child: Text(I18n.of(context).withdraw,style: TextStyle(color : Theme.of(context).hintColor,fontSize:ScreenUtil().setSp(24)),),
            //       ),
            //   )
            _getRollOutAndWithdrawWidget()
          ],
        ));
  }

  Widget _getRollOutAndWithdrawWidget() {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setHeight(40),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).hintColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              I18n.of(context).rollOut,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Theme.of(context).hintColor),
            ),
            onPressed: () {
              widget.didClickRollOutCallBack();
            },
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
        //   child: Container(
        //     width: ScreenUtil().setWidth(80),
        //     height: ScreenUtil().setHeight(40),
        //     decoration: BoxDecoration(
        //         border:
        //             Border.all(color: Theme.of(context).hintColor, width: 1),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: CupertinoButton(
        //       padding: EdgeInsets.zero,
        //       child: Text(
        //         I18n.of(context).withdraw,
        //         style: TextStyle(
        //             fontSize: ScreenUtil().setSp(24),
        //             color: Theme.of(context).hintColor),
        //       ),
        //       onPressed: () {
        //         widget.didClickWithdrawButtonCallBack();
        //       },
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget _getInfoRowWedget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getDayProfitLabel(),
            _getStaticProfitLabel(),
            _getInviteProfitLabel(),
          ]),
    );
  }

  Widget _getDayProfitLabel() {
    return RichText(
        text: TextSpan(
            text: I18n.of(context).everydayProfit,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(24),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: 'TP',
            style: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: ScreenUtil().setSp(20),
            ),
          ),
          TextSpan(
            text: '  =  ',
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          TextSpan(
            text: '\n' +
                (widget.userInfoModel != null
                    ? widget.userInfoModel.todayProfit
                    : '0'),
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ]));
  }

  Widget _getStaticProfitLabel() {
    return RichText(
        text: TextSpan(
            text: I18n.of(context).staticProfit,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(24),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: '  +  ',
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          TextSpan(
            text: '\n' +
                (widget.userInfoModel != null
                    ? widget.userInfoModel.staticProfit
                    : '0'),
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ]));
  }

  Widget _getInviteProfitLabel() {
    return RichText(
        text: TextSpan(
            text: I18n.of(context).promotionProfit,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(24),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: '\n' +
                (widget.userInfoModel != null
                    ? widget.userInfoModel.inviteProfit
                    : '0'),
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ]));
  }

  Widget _getProfitWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Container(
        height: ScreenUtil().setHeight(96),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setHeight(48))),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          _getSingleProfitWidget(
              I18n.of(context).profitOverflowPool,
              widget.userInfoModel != null
                  ? '${widget.userInfoModel.overflowProfit}TP'
                  : '0.0TP'),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            child: VerticalDivider(
              width: ScreenUtil().setWidth(2),
              color: Colors.white,
            ),
          ),
          _getSingleProfitWidget(
              I18n.of(context).accumulativeProfit,
              widget.userInfoModel != null
                  ? '${widget.userInfoModel.totalBillProfit}TP'
                  : '0.0TP')
        ]),
      ),
    );
  }

  Widget _getSingleProfitWidget(String title, String content) {
    double width =
        ((MediaQuery.of(context).size.width - ScreenUtil().setWidth(100)) / 2) -
            ScreenUtil().setWidth(2) -
            ScreenUtil().setWidth(80);
    return GestureDetector(
        onTap: () => widget.didClickProfitCallBack(title),
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
          child: Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: width - ScreenUtil().setWidth(50),
                    child: Text(
                      title + '\n' + content,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: Color.fromARGB(255, 57, 57, 57),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Icon(IconData(0xe610, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 57, 57, 57),
                      size: ScreenUtil().setHeight(36))
                ],
              )),
        ));
  }
}
