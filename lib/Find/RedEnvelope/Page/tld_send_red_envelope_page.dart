import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_send_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_detail_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_send_red_envelope_inpute_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPSendRedEnvelopePage extends StatefulWidget {
  TPSendRedEnvelopePage({Key key,this.type}) : super(key: key);

  final int type;

  @override
  _TPSendRedEnvelopePageState createState() => _TPSendRedEnvelopePageState();
}

class _TPSendRedEnvelopePageState extends State<TPSendRedEnvelopePage> {

  bool _isLoading = false;

  TPSendRedEnvelopeModelManager _modelManager;

  TPSendRedEnvelopePramater _pramater;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramater = TPSendRedEnvelopePramater();
    _pramater.tldCount = '0';
    _pramater.redEnvelopeNum = 0;
    _pramater.policy = 1;
    _pramater.desc = '恭喜发财，大吉大利';
    _pramater.type = widget.type;

    _modelManager = TPSendRedEnvelopeModelManager();
  }

  void _sendRedEnvelope(){
    if(double.parse(_pramater.tldCount) == 0.0){
      Fluttertoast.showToast(msg: '请输入红包金额');
      return;
    }
    if(_pramater.redEnvelopeNum == 0){
      Fluttertoast.showToast(msg: '请输入红包数量');
      return;
    }
    if (_pramater.walletAddress == null){
      Fluttertoast.showToast(msg: '请选择钱包');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.sendRedEnvelope(_pramater, (){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '生成红包成功');
      Navigator.of(context).pop();
    }, (TPError error){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'send_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).promotionRedEnvelope,
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    Widget bottomWidget = widget.type == 1 ? _getNormalBottomView() : _getPromotionBottomView();
    return SingleChildScrollView(
      child: Column(
      children : <Widget>[
        TPSendRedEnvelopeInputeView(
          amountDidChangedCallBack: (String amount){
            _pramater.tldCount = amount;
          },
          numberDidChangedCallBack: (String number){
            _pramater.redEnvelopeNum = int.parse(number);
          },
          descDidChangedCallBack: (String desc){
            _pramater.desc = desc;
          },
          didChooseWalletCallBack: (String walletAddress){
            _pramater.walletAddress = walletAddress;
          },
          didChoosePolicyCallBack: (int policy){
            _pramater.policy = policy;
          },
        ),
       bottomWidget
      ] 
    ),
    );
  }

  Widget _getNormalBottomView(){
    return Padding(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(100),
          ),
          child: Container(
            width : ScreenUtil().setWidth(360),
            height : ScreenUtil().setHeight(96),
            child :CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).createRedEnvelope,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Colors.white
              )),
              color: Color.fromARGB(255, 210, 49, 67),
              onPressed: (){
                _sendRedEnvelope();
              }),
          )
        );
  }

  Widget _getPromotionBottomView(){
    return  Column(
            children :<Widget>[
              Padding(padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
              child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text('声明：\n  推广红包只能新用户才可以领取。',style: TextStyle(
                  fontSize : ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)
                ),),
              ),
              ),
              Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(100),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            width : ScreenUtil().setWidth(360),
            height : ScreenUtil().setHeight(96),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).createRedEnvelope,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Colors.white
              )),
              color: Color.fromARGB(255, 210, 49, 67),
              onPressed: (){
                _sendRedEnvelope();
              }),
            )
            ]
          );
  }

}