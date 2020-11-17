import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PPMissionExchargeActionSheet extends StatefulWidget {
  PPMissionExchargeActionSheet({Key key,this.didExchargeCallBack}) : super(key: key);

  final Function didExchargeCallBack;

  @override
  _PPMissionExchargeActionSheetState createState() => _PPMissionExchargeActionSheetState();
}

class _PPMissionExchargeActionSheetState extends State<PPMissionExchargeActionSheet> {
//  TPBuyPramaterModel _pramaterModel;

  String _walletAddress;

  String _amount = '0';

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  Container(
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(40)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('奖励兑换',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: Container(
              height: ScreenUtil().setHeight(80),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color.fromARGB(255, 242, 242, 242),
              ), 
             child : Row(
             children: <Widget>[
            Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(180),
            alignment: Alignment.topCenter,
             child: _getTextField(),
            ),
                    Container(
          padding : EdgeInsets.only(left : 5),
          child: Text('TP',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor, decoration: TextDecoration.none,fontWeight: FontWeight.w400,)),
            ), 
          ]))),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: GestureDetector(
              onTap:(){
                _focusNode.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                  setState(() {
                    _walletAddress = infoModel.walletAddress;
                  });
                },)));
              },
              child : getArrowView(I18n.of(context).receiveAddressLabel,_walletAddress == null ? I18n.of(context).chooseWalletLabel: _walletAddress)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('兑换',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (double.parse(_amount) == 0.0){
                Fluttertoast.showToast(msg: I18n.of(context).inputBuyAmountFieldPlaceholder,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              if (_walletAddress == null){
                Fluttertoast.showToast(msg: I18n.of(context).chooseWalletLabel,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              // if (double.parse(_pramaterModel.buyCount) < double.parse(widget.model.max) && double.parse(widget.model.max) < double.parse(widget.model.totalCount)){
              //   Fluttertoast.showToast(msg: '输入的购买数量低于最低购买额度',toastLength: Toast.LENGTH_SHORT,
              //           timeInSecForIosWeb: 1);
              //   return;
              // }
              widget.didExchargeCallBack(_amount,_walletAddress);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    )])),
    );
  }

    Widget _getTextField() {
    return CupertinoTextField(
      style: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Color.fromARGB(255, 51, 51, 51)),
      decoration:
          BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(20)),
      placeholder: '请输入奖励兑换的数量',
      placeholderStyle: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Color.fromARGB(255, 153, 153, 153),height: 1.1),
      inputFormatters: [
          TPAmountTextInputFormatter()
      ],
      onChanged: (String text){
        _amount = text;
      },
      // controller: _controller,
    );
  }

  Widget getNormalView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
      ],
    );
  }

  Widget getArrowView(String title, String content) {
    return Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60), 
      child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Container(
            width : ScreenUtil().setWidth(280),
            child : Text(
            content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          )),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    )
    );
  }
}