import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPGetMissionActionSheet extends StatefulWidget {
  TPGetMissionActionSheet({Key key,this.taskNo,this.didClickSureGetBtnCallBack}) : super(key: key);

  final String taskNo;

  final Function(TPGetTaskPramaterModel) didClickSureGetBtnCallBack;

  @override
  _TPGetMissionActionSheetState createState() => _TPGetMissionActionSheetState();
}

class _TPGetMissionActionSheetState extends State<TPGetMissionActionSheet> {

  TPGetTaskPramaterModel _pramaterModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pramaterModel = TPGetTaskPramaterModel();
    _pramaterModel.taskNo = widget.taskNo;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      height: ScreenUtil().setHeight(340),
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
          Text('领取任务',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                  setState(() {
                    _pramaterModel.walletAddress = infoModel.walletAddress;
                  });
                },)));
            },
            child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: _getWalletAddressRowView(),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('确认领取',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              widget.didClickSureGetBtnCallBack(_pramaterModel);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    ),
    );
  }

  Widget _getWalletAddressRowView(){
    return Container(
      height: ScreenUtil().setHeight(88),
      padding: EdgeInsets.only(left :ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        color : Color.fromARGB(255, 242, 242, 242),
        borderRadius:BorderRadius.all(Radius.circular(4))
      ),
      child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '钱包地址',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Container(width : ScreenUtil().setWidth(400),child : Text(
            _pramaterModel.walletAddress != null ? _pramaterModel.walletAddress : '请选择钱包',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          )),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    ),
    );
  }

}