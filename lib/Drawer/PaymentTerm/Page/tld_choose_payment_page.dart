import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_choose_payment_cell.dart';
import 'tld_bank_card_info_page.dart';
import 'tld_wecha_alipay_info_page.dart';
import 'tld_payment_manager_page.dart';

class TPChoosePaymentPage extends StatefulWidget {
  TPChoosePaymentPage({Key key,this.walletAddress,this.isChoosePayment = false,this.didChoosePaymentCallBack}) : super(key: key);

  final String walletAddress;

  final bool isChoosePayment;

  final Function(TPPaymentModel) didChoosePaymentCallBack;

  @override
  _TPChoosePaymentPageState createState() => _TPChoosePaymentPageState();
}

class _TPChoosePaymentPageState extends State<TPChoosePaymentPage> {

  TPPaymentManagerModelManager _modelManager;

  bool _isLoading = true;

  List _dataSource = [];

  @override
  void initState() { 
    super.initState();
    
    _modelManager = TPPaymentManagerModelManager();
    _getPaymentType();
  }

  
  void _getPaymentType(){
    _modelManager.getPaymentTypeList((List paymentTypeList){
      if (mounted){
        setState(() {
          _isLoading = false;
          _dataSource.addAll(paymentTypeList);
        });
      }
    }, (TPError error){
            if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_payment_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).collectionMethod),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBodyWidget(context),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index){
        TPPaymentTypeModel typeModel = _dataSource[index];
        return TPChoosePaymentCell(title : typeModel.payName, iconUrl: typeModel.payIcon,
          didClickCallBack: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPPaymentManagerPage(typeModel : typeModel,walletAddress: widget.walletAddress,isChoosePayment: widget.isChoosePayment,didChoosePaymentCallBack: widget.didChoosePaymentCallBack,)));
          },
        );
      }
    );
  }

  void changePurseName(BuildContext context){
   
  }

}