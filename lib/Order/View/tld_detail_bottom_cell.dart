import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_image_show_page.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPDetailOrderBottomCell extends StatefulWidget {
  TPDetailOrderBottomCell({Key key, this.detailOrderModel, this.isBuyer,this.didClickActionBtnCallBack})
      : super(key: key);

  final TPDetailOrderModel detailOrderModel;

  final bool isBuyer;

  final Function(String) didClickActionBtnCallBack;

  @override
  _TPDetailOrderBottomCellState createState() =>
      _TPDetailOrderBottomCellState();
}

class _TPDetailOrderBottomCellState extends State<TPDetailOrderBottomCell> {
  List _actionBtnTitleList;

  PageController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    TPOrderStatusInfoModel infoModel =
    TPDataManager.orderListStatusMap[widget.detailOrderModel.status];
    if (widget.isBuyer == true) {
      _actionBtnTitleList = infoModel.buyerActionButtonTitle;
    } else {
      _actionBtnTitleList = infoModel.sellerActionButtonTitle;
    }
     return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
      child: Column(
        children: <Widget>[
        Offstage(
          offstage: !(widget.detailOrderModel.payImage.length > 0),
          child:_getPicWidget(),
        ),
           Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20)),
        child: _getActionBtn(context))
        ],  
      ),
    );
  }

  Widget _getActionBtn(BuildContext context) {
    if (_actionBtnTitleList.length == 0) {
      return Container();
    } else if (_actionBtnTitleList.length == 1) {
      return _getOnlyOneActionBtnView();
    } else {
      return _getTwoActionBtnView(context);
    }
  }

  Widget _getOnlyOneActionBtnView() {
    return Container(
        height: ScreenUtil().setHeight(80),
        child: OutlineButton(
          onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList.first),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
            width: 1,
          ),
          child: Text(
            _actionBtnTitleList.first,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Theme.of(context).hintColor),
          ),
        ));
  }

  Widget _getTwoActionBtnView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(80),
          width: size.width / 2.0 - ScreenUtil().setWidth(40),
          child: OutlineButton(
            onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[0]),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
              width: 1,
            ),
            child: Text(
              _actionBtnTitleList[0],
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Theme.of(context).hintColor),
            ),
          ),
        ),
        Container(
            width: size.width / 2.0 - ScreenUtil().setWidth(40),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(
                child: Text(
                  _actionBtnTitleList[1],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28), color: Colors.white),
                ),
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).hintColor,
                onPressed: () => widget.didClickActionBtnCallBack(_actionBtnTitleList[1]))),
      ],
    );
  }

    Widget _getPicWidget(){
    double width = MediaQuery.of(context).size.width - ScreenUtil().setWidth(100);
    return  Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(2)),
          child: Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Padding(
                  padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top :ScreenUtil().setHeight(20),bottom:ScreenUtil().setHeight(20) ),
                  child: Text('买家支付凭证',style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),),
                ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TPImageShowPage(imagePathList: [widget.detailOrderModel.payImage],isShowDelete: false,index: 0,pageController: _controller,heroTag: 'detail_order_bottom',)));
                },
                child:   Padding(
                  padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top :ScreenUtil().setHeight(20)),
                  child: CachedNetworkImage(imageUrl: widget.detailOrderModel.payImage,width: ScreenUtil().setWidth(300),height: ScreenUtil().setWidth(500),fit: BoxFit.cover,),
                ),
              )
              ]
            ),
          ),
        );
  }
}
