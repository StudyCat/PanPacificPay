import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_diy_info_page.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tp_new_payment_info_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_payment_manager_add_payment_cell.dart';
import '../Model/tld_payment_manager_model_manager.dart';
import '../View/tld_payment_manager_cell.dart';
import 'tld_bank_card_info_page.dart';
import 'tld_wecha_alipay_info_page.dart';



class TPPaymentManagerPage extends StatefulWidget {
  TPPaymentManagerPage({Key key,this.typeModel,this.walletAddress,this.isChoosePayment,this.didChoosePaymentCallBack}) : super(key: key);

  final TPPaymentTypeModel typeModel;

  final bool isChoosePayment;

  final String walletAddress;

  final Function(TPPaymentModel) didChoosePaymentCallBack;

  @override
  _TPPaymentManagerPageState createState() => _TPPaymentManagerPageState();
}

class _TPPaymentManagerPageState extends State<TPPaymentManagerPage> {
  RefreshController _refreshController;

  List _dataSource;

  TPPaymentManagerModelManager _manager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh:true);

    _manager = TPPaymentManagerModelManager();

    _dataSource = [];

    _getPaymentList();
  }



  void _getPaymentList(){
    _manager.getPaymentInfoList(widget.walletAddress, widget.typeModel.payType, (List dataList){
      _dataSource = [];
      _refreshController.refreshCompleted();
      if (mounted){
      setState(() {
        _dataSource.addAll(dataList);
      });
      }
    }, (TPError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }


  void refreshPaymentList(){
    _refreshController.requestRefresh();
    _getPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'payment_manager_page',
        transitionBetweenRoutes: false,
        middle: Text(_getPageTitle()),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getRefreshWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getRefreshWidget(){
    return SmartRefresher(
      controller:_refreshController,
      header: WaterDropHeader(
        complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete)
      ),
      onRefresh:()=> _getPaymentList(),
      child: _getBodyWidget(),
      );
  }

  String _getPageTitle(){
    return widget.typeModel.payName + '管理';
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context,int index){
        if(index == _dataSource.length){
          return TPPaymentManagerAddPaymentCell(typeModel: widget.typeModel,didClickItemCallBack: (){
            if (widget.typeModel.payType == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPBankCardInfoPage(walletAddress: widget.walletAddress,))).then((value) => refreshPaymentList());
            }else if(widget.typeModel.payType == 4){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPaymentDiyInfoPage(walletAddress: widget.walletAddress,))).then((value) => refreshPaymentList());
            }else if (widget.typeModel.payType > 4){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPNewPaymentInfoPage(typeModel: widget.typeModel,walletAddress: widget.walletAddress,))).then((value) => refreshPaymentList());
            }else{
              TPWechatAliPayInfoPageType pageType;
              if (widget.typeModel.payType == 2){
                pageType = TPWechatAliPayInfoPageType.weChat;
              }else{
                pageType = TPWechatAliPayInfoPageType.aliPay;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPWechatAliPayInfoPage(walletAddress : widget.walletAddress,type : pageType))).then((value) => refreshPaymentList());
            }
          },);
        }else{
          TPPaymentModel paymentModel = _dataSource[index];
          return TPPaymentManagerCell(paymentModel: paymentModel,didClickItemCallBack: (){
            if (widget.isChoosePayment == true){
              widget.didChoosePaymentCallBack(paymentModel);
              Navigator.of(context)..pop()..pop();
            }else{
              if (paymentModel.type == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPBankCardInfoPage(walletAddress: widget.walletAddress,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }else if(paymentModel.type == 4){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPaymentDiyInfoPage(walletAddress: widget.walletAddress,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }else if (widget.typeModel.payType > 4){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPNewPaymentInfoPage(typeModel: widget.typeModel,walletAddress: widget.walletAddress,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }else{
              TPWechatAliPayInfoPageType pageType;
              if (widget.typeModel.payType == 2){
                pageType = TPWechatAliPayInfoPageType.weChat;
              }else{
                pageType = TPWechatAliPayInfoPageType.aliPay;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPWechatAliPayInfoPage(walletAddress : widget.walletAddress,type : pageType,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }
            }
          },);
        }
      } 
      );
  }

}