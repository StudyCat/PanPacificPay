import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonFunction/tld_common_function.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';


class TPMyPurseHeaderView extends StatefulWidget {
  TPMyPurseHeaderView({Key key,this.didClickTransferAccountsBtnCallBack,this.didClickQRCodeBtnCallBack,this.infoModel,this.didClickChangeBtnCallBack}) : super(key: key);

  final TPWalletInfoModel infoModel;

  final Function didClickTransferAccountsBtnCallBack;

  final Function didClickQRCodeBtnCallBack;

  final Function didClickChangeBtnCallBack;

  @override
  _TPMyPurseHeaderViewState createState() => _TPMyPurseHeaderViewState();
}

class _TPMyPurseHeaderViewState extends State<TPMyPurseHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(48),
          bottom: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getNumView(),
          getCopyAdressView(context),
          getButtonView(context)
        ],
      ),
    );
  }

  Widget getNumView() {
    return Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
                  text: TextSpan(
                    text : getMoneyStyleStr(widget.infoModel == null ? '0':widget.infoModel.value),
                    style : TextStyle(fontSize : ScreenUtil().setSp(52),color : Theme.of(context).hintColor),
                    children: <InlineSpan>[
                      TextSpan(
                        text : '  TP',
                        style: TextStyle(fontSize : ScreenUtil().setSp(24),color :Theme.of(context).hintColor)
                      )
                    ],
                  ),
                ),
            Container(
              width: ScreenUtil().setWidth(142),
              height: ScreenUtil().setHeight(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                // color: Color.fromARGB(255, 51, 114, 245)
              ),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(I18n.of(context).sell,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28), color: Colors.white)),
                onPressed: widget.didClickChangeBtnCallBack,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ));
  }


  Widget getCopyAdressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Clipboard.setData(ClipboardData(text : widget.infoModel == null ? "":widget.infoModel.walletAddress));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      },
      child: Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(255, 82, 82, 82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(190),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: Text(
              widget.infoModel == null ? "":widget.infoModel.walletAddress,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(50),
                bottom: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setWidth(32),
            width: ScreenUtil().setWidth(32),
            child: IconButton(
                icon: Icon(
                  IconData(0xe601, fontFamily: 'appIconFonts'),
                  size: ScreenUtil().setWidth(32),
                  color: Colors.white,
                ),
                onPressed: () {}),
          )
        ],
      ),
    ),
    );
  }

  Widget getButtonView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              width: (size.width - ScreenUtil().setWidth(90)) / 2,
              height: ScreenUtil().setHeight(80),
              child: OutlineButton(
                onPressed: widget.didClickQRCodeBtnCallBack,
                shape: StadiumBorder(
                 
                ),
                borderSide: BorderSide(
                    color: Theme.of(context).hintColor,
                    width: 1,
                  ),
                child: Text(
                  I18n.of(context).receivingQRCode,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Theme.of(context).hintColor),
                ),
              )),
          Container(
              width: (size.width - ScreenUtil().setWidth(90)) / 2,
              height: ScreenUtil().setHeight(80),
              child: CupertinoButton(
                onPressed: widget.didClickTransferAccountsBtnCallBack,
                child: Text(
                  I18n.of(context).transferAccounts,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28), color: Colors.white),
                ),
                color: Theme.of(context).hintColor,
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
              )),
        ],
      ),
    );
  }
}
