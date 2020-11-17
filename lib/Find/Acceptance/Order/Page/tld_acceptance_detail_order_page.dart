import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_detail_order_amount_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_detail_order_header_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPAcceptanceDetailOrderPage extends StatefulWidget {
  TPAcceptanceDetailOrderPage({Key key,this.orderNo}) : super(key: key);

  final String orderNo;

  @override
  _TPAcceptanceDetailOrderPageState createState() => _TPAcceptanceDetailOrderPageState();
}

class _TPAcceptanceDetailOrderPageState extends State<TPAcceptanceDetailOrderPage> {
  bool _isLoading = true;

  TPAcceptanceDetailOrderModelManager _modelManager;

  TPAcceptanceDetailOrderInfoModel _detailOrderInfoModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPAcceptanceDetailOrderModelManager();
    
    _getDetailInfo();
  }

  void _getDetailInfo(){
    if(mounted){
      setState(() {
      _isLoading = true;
    });
    }
    _modelManager.getDetailOrderInfo(widget.orderNo, (TPAcceptanceDetailOrderInfoModel infoModel){
      if(mounted){
      setState(() {
      _isLoading = false;
      _detailOrderInfoModel = infoModel;
    });
    }
    }, (TPError error){
      if(mounted){
      setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(msg: error.msg);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body:  LoadingOverlay(isLoading: _isLoading, child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          )),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }



  Widget _getAppBar() {
    return SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Theme.of(context).primaryColor,
      leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floating: true, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      title: Text(I18n.of(context).detailOrderPageTitle),
      flexibleSpace: FlexibleSpaceBar(
        background: TPAcceptanceDetailOrderHeaderCell(detailOrderInfoModel: _detailOrderInfoModel,),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: _detailOrderInfoModel != null ? 3 : 0,
        itemBuilder: (BuildContext context, int index) {
          if (index == 1){
            return TPAcceptanceDetailOrderAmountCell(orderInfoModel: _detailOrderInfoModel,);
          }else{
            double top = 0.0;
            if(index == 2){
              top = ScreenUtil().setHeight(10);
            }else{
              top = ScreenUtil().setHeight(2);
            }
            return _getNormalCell( top, index);
          }
        });
  }

    Widget _getNormalCell( num top, int index) {
    String content = '';
    String title = '';
    if(index == 0){
      title = I18n.of(context).orderNumLabel;
      content = _detailOrderInfoModel.acptOrderNo;
    }else if(index == 2){
      title = I18n.of(context).dailyStaticProfitAdd;
      content = '${_detailOrderInfoModel.staticProfit}TP';
    }
    // else if(index == 3){
    //   title = '收益倍率';
    //   content = _detailOrderInfoModel.billProfitRate;
    // }else{
    //   title = '预计承兑累积收益';
    //   content = '${_detailOrderInfoModel.expectProfit}TP';
    // }
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TPClipCommonCell(
          type: TPClipCommonCellType.normal,
          title: title,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    );
  }

}