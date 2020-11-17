import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';

enum TPRedEnvelopType { spellLuck, quota }

class TPSendRedEnvelopeInputeView extends StatefulWidget {
  TPSendRedEnvelopeInputeView(
      {Key key,
      this.amountDidChangedCallBack,
      this.numberDidChangedCallBack,
      this.descDidChangedCallBack,
      this.didChooseWalletCallBack,
      this.didChoosePolicyCallBack})
      : super(key: key);

  final Function amountDidChangedCallBack;

  final Function numberDidChangedCallBack;

  final Function descDidChangedCallBack;

  final Function didChooseWalletCallBack;

  final Function didChoosePolicyCallBack;

  @override
  _TPSendRedEnvelopeInputeViewState createState() =>
      _TPSendRedEnvelopeInputeViewState();
}

class _TPSendRedEnvelopeInputeViewState
    extends State<TPSendRedEnvelopeInputeView> {
  TPRedEnvelopType _type = TPRedEnvelopType.spellLuck;

  TPWalletInfoModel _walletInfoModel;

  String _amount;

  @override
  Widget build(BuildContext context) {
    String amount = (_amount == null || _amount == "") ? "0" : _amount;
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(10)),
      child: Container(
        //  decoration: BoxDecoration(
        //   //  color : Color.fromARGB(255, 210, 49, 67),
        //    borderRadius: BorderRadius.all(Radius.circular(4)),
        //  ),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getTotalAmountTextField(),
            _getRedEnvelopNumberTextField(),
            _getRedEnvelopeDescriptionTextField(),
            _getChooseRedEnvelopeTypeWidget(),
            Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(32),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(80),
                  child: Text(
                    amount + "TP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51), fontSize: ScreenUtil().setSp(72)),
                  ),
                )),
            _getWalletWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getTotalAmountTextField() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(children: <InlineSpan>[
                WidgetSpan(
                  child: Icon(
                    IconData(0xe6ac, fontFamily: 'appIconFonts'),
                    color: Theme.of(context).hintColor,
                    size: ScreenUtil().setSp(30),
                  ),
                ),
                TextSpan(
                  text: "  " + I18n.of(context).totalAmount,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51)),
                )
              ]),
            ),
            Expanded(
              // padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
              child: CupertinoTextField(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
                placeholder: I18n.of(context).pleaseEnterRedEnvelopeAmount,
                inputFormatters: [TPAmountTextInputFormatter()],
                placeholderStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153)),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
                onChanged: (text) {
                  widget.amountDidChangedCallBack(text);
                  setState(() {
                    _amount = text;
                  });
                },
              ),
            )
          ],
        ));
  }

  Widget _getRedEnvelopNumberTextField() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        height: ScreenUtil().setHeight(88),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              I18n.of(context).redEnvelopeNumber,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 51, 51, 51)),
            ),
            _getNumberRowTextField(),
          ],
        ),
      ),
    );
  }

  Widget _getRedEnvelopeDescriptionTextField() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        height: ScreenUtil().setHeight(136),
        child: CupertinoTextField(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
          placeholder: I18n.of(context).wishYouAProsperousLife,
          placeholderStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          onChanged: (text) => widget.descDidChangedCallBack(text),
        ),
      ),
    );
  }

  Widget _getNumberRowTextField() {
    return Row(
      children: <Widget>[
        Container(
            width: ScreenUtil().setWidth(150),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
              placeholder: I18n.of(context).enterNumber,
              placeholderStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153)),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)),
              onChanged: (text) => widget.numberDidChangedCallBack(text),
            )),
        Text(" " + I18n.of(context).entries,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 51, 51, 51))),
      ],
    );
  }

  Widget _getChooseRedEnvelopeTypeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(32), left: ScreenUtil().setWidth(20)),
      child: Row(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: _getSingleChoiceWidget(
              TPRedEnvelopType.spellLuck, I18n.of(context).spellLuck),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
          child: _getSingleChoiceWidget(
              TPRedEnvelopType.quota, I18n.of(context).quotaRedEnvelope),
        )
      ]),
    );
  }

  Widget _getSingleChoiceWidget(TPRedEnvelopType type, String title) {
    return Row(children: <Widget>[
      Container(
        height: ScreenUtil().setHeight(18),
        width: ScreenUtil().setHeight(18),
        child: Radio(
          activeColor: Color.fromARGB(255, 51, 51, 51),
          focusColor: Color.fromARGB(255, 51, 51, 51),
          hoverColor: Color.fromARGB(255, 51, 51, 51),
          value: type,
          groupValue: _type,
          onChanged: (value) {
            setState(() {
              _type = value;
            });
            if (value == TPRedEnvelopType.spellLuck) {
              widget.didChoosePolicyCallBack(1);
            } else {
              widget.didChoosePolicyCallBack(2);
            }
          },
        ),
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: Text(
            title,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(24)),
          ))
    ]);
  }

  Widget _getWalletWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TPEchangeChooseWalletPage(
                      didChooseWalletCallBack: (TPWalletInfoModel infoModel) {
                        setState(() {
                          _walletInfoModel = infoModel;
                        });
                        widget.didChooseWalletCallBack(infoModel.walletAddress);
                      },
                    )));
      },
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
        child: Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            height: ScreenUtil().setHeight(88),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _walletInfoModel == null
                      ? I18n.of(context).chooseWallet
                      : _walletInfoModel.wallet.name,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: ScreenUtil().setSp(28),
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Color.fromARGB(255, 51, 51, 51),
                )
              ],
            )),
      ),
    );
  }
}
