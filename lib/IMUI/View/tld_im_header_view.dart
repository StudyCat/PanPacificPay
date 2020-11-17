import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPIMHeaderView extends StatefulWidget {
  TPIMHeaderView({Key key,this.orderNo}) : super(key: key);

  final String orderNo;

  @override
  _TPIMHeaderViewState createState() => _TPIMHeaderViewState();
}

class _TPIMHeaderViewState extends State<TPIMHeaderView> {

  TPDetailOrderModelManager _modelManager;

  TPDetailOrderModel _detailOrderModel;

  List _actionBtnTitleList;

  bool _isBuyer = false;

  bool _buttonEnable = true;

  // bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPDetailOrderModelManager();

    _actionBtnTitleList = [];

    getOrderInfo();
  }

  void getOrderInfo(){
    //  setState(() {
    //   _isLoading = true;
    // });
    _modelManager.getDetailOrderInfoWithOrderNo(widget.orderNo, (TPDetailOrderModel detailOrderModel){
      _jugeIsBuyer(detailOrderModel);
      if (mounted){
              setState(() {
        // _isLoading = false;
        _detailOrderModel = detailOrderModel;
      });
      }
    }, (TPError error){
      // setState(() {
      //   _isLoading = false;
      // });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _confirmPaid(){
    // setState(() {
      _buttonEnable = false;
    // });
    _modelManager.confirmPaid(widget.orderNo, _detailOrderModel.buyerAddress,  (){
      // setState(() {
        _buttonEnable = true;
      // });
      getOrderInfo();
      Fluttertoast.showToast(msg: '确认我已付款成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      // setState(() {
        _buttonEnable = true;
      // });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _sureSentCoin(){
      // setState(() {
        _buttonEnable = false;
      // });
    _modelManager.sureSentCoin(widget.orderNo, _detailOrderModel.sellerAddress,  (){
      // setState(() {
        _buttonEnable = true;
      // });
      _detailOrderModel = null;
      getOrderInfo();
      Fluttertoast.showToast(msg: '确认释放TP成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      // setState(() {
        _buttonEnable = true;
      // });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

    void _remindOrder(){
      // setState(() {
        _buttonEnable = false;
      // });
    _modelManager.remindOrder(widget.orderNo, (){
      // setState(() {
        _buttonEnable = true;
      // });
      Fluttertoast.showToast(msg: '催单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TPError error){
      // setState(() {
        _buttonEnable = true;
      // });
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _jugeIsBuyer(TPDetailOrderModel detailOrderModel){
    List purseList = TPDataManager.instance.purseList;
    List addressList = [];
    for (TPWallet item in purseList) {
      addressList.add(item.address);
    }
    if (addressList.contains(detailOrderModel.buyerAddress)){
      _isBuyer = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_detailOrderModel != null){
      TPOrderStatusInfoModel infoModel = TPDataManager.iMOrderListStatusMap[_detailOrderModel.status];
      if (_isBuyer == true) {
        _actionBtnTitleList = infoModel.buyerActionButtonTitle;
      } else {
        _actionBtnTitleList = infoModel.sellerActionButtonTitle;
      }
    }
    return  Container(
       child: Padding(
         padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
         child: Column(
           children : <Widget>[
             _getOrderInfoActionBtnView(),
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
               child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(300),
               height: ScreenUtil().setHeight(48),
               decoration: BoxDecoration(
                 borderRadius : BorderRadius.all(Radius.circular(24)),
                 color : Color.fromARGB(255, 216, 216, 216)
               ),
               child: Text('季度信用分：100',style : TextStyle(fontSize: ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51))),
             ),
             )
           ]
         )
       )
    );
  }

  Widget _getOrderInfoActionBtnView(){
    return Container(
           decoration: BoxDecoration(
             color : Colors.white,
             borderRadius : BorderRadius.all(Radius.circular(4))
           ),
           child: Padding(
             padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(30),right : ScreenUtil().setWidth(30),bottom : ScreenUtil().setHeight(30)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               children : <Widget>[
                 _getOrderInfoView(),
                _getActionBtn(context),
               ])
           ),
         );
  }

  

  Widget _getOrderInfoView(){
    String amount = _detailOrderModel != null ? _detailOrderModel.txCount : '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : 0),
          child: Text('订单号：'+ widget.orderNo,style : TextStyle(fontSize : ScreenUtil().setSp(22),color : Color.fromARGB(255, 153, 153, 153))),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
          child: Text('总量：'+ amount + 'TP',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor)),
        )
      ],
    );
  }

    Widget _getActionBtn(BuildContext context) {
    if (_actionBtnTitleList.length == 0) {
      return Container();
    } else{
      return _getOnlyOneActionBtnView();
    }
  }

  Widget _getOnlyOneActionBtnView(){
    return Container(
                   height : ScreenUtil().setHeight(60),
                   width : ScreenUtil().setWidth(190),
                   child: CupertinoButton(
                      color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(0),
                    child: Text(_actionBtnTitleList.first,style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(24))),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    onPressed: () {
                      if (_buttonEnable == true){
                        if (_actionBtnTitleList.first == '我已付款'){
                          _confirmPaid();
                        }else if(_actionBtnTitleList.first == '确认释放TP'){
                          _sureSentCoin();
                        }else if (_actionBtnTitleList.first == '催单'){
                          _remindOrder();
                        }
                      }
                    }),
            );
  }

}