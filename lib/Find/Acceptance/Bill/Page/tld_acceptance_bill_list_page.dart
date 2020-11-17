
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_lock_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_bill_list_unopen_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_profit_list_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPAcceptanceBillListPage extends StatefulWidget {
  TPAcceptanceBillListPage({Key key}) : super(key: key);

  @override
  _TPAcceptanceBillListPageState createState() =>
      _TPAcceptanceBillListPageState();
}

class _TPAcceptanceBillListPageState extends State<TPAcceptanceBillListPage> {
  TPAcceptanceBillListModelManager _modelManager;

  TPBillBuyPramaterModel _pramaterModel;

  RefreshController _refreshController;

  List _dataSource;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPAcceptanceBillListModelManager();

    _getListInfo();
  }

  void _getListInfo() {
    _modelManager.getBillList((List billList) {
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted) {
        setState(() {
          _dataSource.addAll(billList);
        });
      }
    }, (TPError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _buyBill(TPBillBuyPramaterModel pramaterModel){
    setState(() {
      _isLoading = true;
    });
    _modelManager.buyBill(pramaterModel, (String orderNo){
      setState(() {
      _isLoading = false;
    });
    _refreshController.requestRefresh();
    Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).buySuccess);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TPAcceptanceDetailBillPage(orderNo: orderNo,))).then((value) => _getListInfo());
    }, (TPError error){
      setState(() {
      _isLoading = false;
    });
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
        heroTag: 'acceptance_bill_list_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).tldBill,
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.billDescUrl,title: '票据说明',)));
        }),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBody(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget() {
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TPBillInfoListModel listModel = _dataSource[index];
        if (listModel.lock == true){
          return GestureDetector(
            onTap:(){
              showDialog(context: context,builder:(context){
                return TPAlertView(
                  title: '提示',
                  type: TPAlertViewType.normal,
                  alertString: listModel.tip,
                  didClickSureBtn: (){},
                );
              }); 
            },
            child : TPAcceptanceBillListLockCell(infoListModel: listModel,)
          );
        }else{
          if (listModel.isOpen){
             return _getOpenCell(listModel);
          }else{
            return GestureDetector(
                onTap: () {
                  setState(() {
                    listModel.isOpen = !listModel.isOpen;
                  });
                },
                child: TPAcceptanceBillListUnOpenCell(infoListModel: listModel,));
          }
        }
      },
    );
  }

  Widget _getOpenCell(TPBillInfoListModel billModel){
    return TPAcceptanceBillListOpenCell(
      infoListModel: billModel,
            didClickOpenItemCallBack: (){
              setState(() {
                billModel.isOpen = !billModel.isOpen;
              });
            },
            didClickCheckButtonCallBack: (int index){
              TPApptanceOrderListModel orderListModel = billModel.orderList[index];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TPAcceptanceDetailBillPage(orderNo: orderListModel.acptOrderNo,)));
            },
            didClickBuyButtonCallBack: () {
              if (billModel.totalBuyCount == billModel.alreadyBuyCount){
                Fluttertoast.showToast(msg: '无法再购买了,请购买下一级票据');
                return;
              }
              _pramaterModel = TPBillBuyPramaterModel();
              _pramaterModel.billId = billModel.billId;
              _pramaterModel.payType = 1;
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return TPAcceptanceBillBuyActionSheet(
                      infoListModel: billModel,
                      didChooseCountCallBack: (int count) {
                        _pramaterModel.count = count;
                      },
                      didChoosePaymentType: (int paymentType){
                        _pramaterModel.payType = paymentType;
                      },
                      didChooseYLBType: (int ylbType){
                        _pramaterModel.ylbType = ylbType;
                      },
                      didClickBuyButtonCallBack: (){
                        _buyBill(_pramaterModel);
                      },
                      didClickChooseWallet: (String walletAddress) {
                        _pramaterModel.walletAddress = walletAddress;
                      },
                    );
                  });
            },
    );
  }

  Widget _getBody() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        SmartRefresher(
        controller: _refreshController,
        child: _getBodyWidget(),
        header: WaterDropHeader(
          complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete),
        ),
        onRefresh: () {
          _getListInfo();
        },
      )
      ],
    );
  }
}
