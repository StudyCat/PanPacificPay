
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPMissionHallBuyActionSheet extends StatefulWidget {
  TPMissionHallBuyActionSheet({Key key,this.walletAddress,this.buyInfoModel,this.taskWalletId,this.didClickBuyBtnCallBack}) : super(key: key);

  final TPMissionBuyInfoModel buyInfoModel;

  final Function(TPMissionBuyPramaterModel) didClickBuyBtnCallBack;

  final int taskWalletId;

  final String walletAddress;
  
  @override
  _TPMissionHallBuyActionSheetState createState() =>
      _TPMissionHallBuyActionSheetState();
}

class _TPMissionHallBuyActionSheetState
    extends State<TPMissionHallBuyActionSheet> {
  TPMissionBuyPramaterModel _pramaterModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramaterModel = TPMissionBuyPramaterModel();
    _pramaterModel.quote = widget.buyInfoModel.quote;
    _pramaterModel.taskBuyNo = widget.buyInfoModel.taskBuyNo;
    _pramaterModel.buyerWalletAddress = widget.walletAddress;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: ScreenUtil().setHeight(440),
        width: size.width,
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('购买',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51),
                    decoration: TextDecoration.none)),
            _getNormalRowView('数量', widget.buyInfoModel.quote + 'TP'),
            _getNormalRowView('应付款', widget.buyInfoModel.quote + 'CNY'),
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(isNeedFliter: false,didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                //   setState(() {
                //     _pramaterModel.buyerWalletAddress = infoModel.walletAddress;
                //   });
                // },)));
              },
              child: _getNormalRowView('接收地址', _pramaterModel.buyerWalletAddress),
            ),
            Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下单',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (_pramaterModel.buyerWalletAddress == null) {
                Fluttertoast.showToast(msg: '请选择钱包');
                return;
              }
              widget.didClickBuyBtnCallBack(_pramaterModel);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )
          ],
        ),
      ),
    );
  }

  Widget _getNormalRowView(String title, String content) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Container(
        width: size.width - ScreenUtil().setWidth(60),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Container(
                width: ScreenUtil().setWidth(450),
                child:  Text(
                content,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              )
            ]),
      ),
    );
  }

  Widget _getArrowRowView(String title, String content) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        child: Container(
          width: size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(400),
                    child: Text(
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
          ),
        ));
  }
}
