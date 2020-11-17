import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_balance_son_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPYLBRollInActionSheet extends StatefulWidget {
  TPYLBRollInActionSheet({Key key,this.didClickRollIn,this.profitRateList,this.typeList}) : super(key: key);

  final Function didClickRollIn;

  final List profitRateList;

  final List typeList;

  @override
  _TPYLBRollInActionSheetState createState() => _TPYLBRollInActionSheetState();
}

class _TPYLBRollInActionSheetState extends State<TPYLBRollInActionSheet> {

  int _type = 1;

  TPWalletInfoModel _infoModel;

  TextEditingController _editingController;

  String _rollInAmount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
   String rate = '';
   for (TPYLBProfitRateModel rateModel in widget.profitRateList) {
     if (_type == rateModel.type){
       rate = rateModel.rate;
       break;
     }
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
                children: <Widget>[ Container(
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
            Text('转入',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51),
                    decoration: TextDecoration.none)),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: GestureDetector(
                onTap : (){
                  Navigator.push(context, MaterialPageRoute(builder : (context) => TPEchangeChooseWalletPage(didChooseWalletCallBack: (TPWalletInfoModel infoModel){
                    setState(() {
                      _infoModel = infoModel;
                    });
                  },)));
                },
                child : _getArrowView('选择钱包',_infoModel != null ? _infoModel.wallet.name : '请选择钱包')
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getNormalView('钱包余额',_infoModel != null ? '${_infoModel.value}TP' : '0TP'),
            ),
             Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getInputRowWidget(),
            ),
             Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getChoiceWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: _getNormalView('收益率','$rate%'),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
              child: Container(
                width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                height : ScreenUtil().setHeight(80),
                child : CupertinoButton(child: Text('确认转入',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
                  if (_infoModel == null){
                    Fluttertoast.showToast(msg: '请选择钱包');
                    return;
                  }
                  if (_rollInAmount == null){
                    Fluttertoast.showToast(msg: '请输入转入金额');
                    return;
                  }
                  widget.didClickRollIn(_type,_infoModel.walletAddress,_rollInAmount);
                  Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),)
              ),
            )
          ],
        ),
      )]),
    ));
  }

  Widget _getInputRowWidget(){
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '转入金额',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        _getInputField()
      ],
    );
  }

   Widget _getInputField() {
    return Container(
      width: ScreenUtil().setWidth(420),
      height: ScreenUtil().setHeight(72),
      decoration: BoxDecoration(
        color : Color.fromARGB(255, 216, 216, 216),
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(36)))
      ),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(200),
            child: CupertinoTextField(
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51)),
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
            onChanged: (String text){
              _rollInAmount = text;
            },
            controller: _editingController,
            placeholderStyle: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 153, 153, 153),
                height: 1.1),
            inputFormatters: [TPAmountTextInputFormatter()],
          ),
          ),
          Container(
            width : ScreenUtil().setWidth(186),
            height : ScreenUtil().setHeight(72),
            child: CupertinoButton(child: Text('全部转入',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)),),
            color: Theme.of(context).hintColor,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(36))), 
            onPressed: (){
              if (_infoModel == null){
                Fluttertoast.showToast(msg: '请先选择钱包');
              }else{
                setState(() {
                _editingController.text = _infoModel.value;
                _rollInAmount = _infoModel.value; 
                });
              }
            },
            ),
          )
        ],
      ),
    );
  }

    Widget _getNormalView(String title, String content) {
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

  Widget _getArrowView(String title, String content) {
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

  Widget _getChoiceWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _singleChoiceButton(1, '日结算'),
        _singleChoiceButton(2, '7天结算'),
        _singleChoiceButton(3, '30天结算'),
        _singleChoiceButton(4, '60天结算')
      ],
    );
  }

  Widget _singleChoiceButton(int type,String title){
    return GestureDetector(
      onTap: (){
        setState(() {
          _type = type;
        });
      },
      child: Container(
        width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(140)) / 4,
        height: ScreenUtil().setHeight(72),
        decoration: BoxDecoration(
          border : Border.all(color : Theme.of(context).hintColor,width : ScreenUtil().setHeight(2)),
          borderRadius : BorderRadius.all(Radius.circular(4)),
          color : type != _type ? Colors.white :Theme.of(context).hintColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,textAlign: TextAlign.center,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : type == _type ? Color.fromARGB(255, 51, 51, 51):Theme.of(context).hintColor))
          ],
        ),
      ),
    );
  }

}