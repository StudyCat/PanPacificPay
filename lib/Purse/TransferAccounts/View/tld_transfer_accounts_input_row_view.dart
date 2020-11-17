import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class TPTransferAccountsInputRowControl extends ValueNotifier<String>{
  TPTransferAccountsInputRowControl(String walletAddress) : super(walletAddress);
}

enum TPTransferAccountsInputRowViewType{
    allTransfer,
    normal,
    scanCode
}

class TPTransferAccountsInputRowView extends StatefulWidget {
  TPTransferAccountsInputRowView({Key key,this.type,this.didClickScanBtnCallBack,this.content,this.enable,this.stringEditingCallBack,this.allAmount,this.inputRowControl}) : super(key: key);

  final TPTransferAccountsInputRowControl inputRowControl;

  final TPTransferAccountsInputRowViewType type;

  final Function didClickScanBtnCallBack;

  final String content;

  final String allAmount;

  final bool enable;

  final Function(String) stringEditingCallBack;

  
  @override
  _TPTransferAccountsInputRowViewState createState() => _TPTransferAccountsInputRowViewState();
}

class _TPTransferAccountsInputRowViewState extends State<TPTransferAccountsInputRowView> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = widget.content == null ? TextEditingController() : TextEditingController(text:widget.content);

    _controller.addListener(() {
      widget.stringEditingCallBack(_controller.text);
    });

    if (widget.inputRowControl != null){
      widget.inputRowControl.addListener(() {
        _controller.text = widget.inputRowControl.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color : Color.fromARGB(255, 242, 242, 242),
      ),
      child: _getBodyContent(context), 
    );
  }

  Widget _getBodyContent(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    if (widget.type == TPTransferAccountsInputRowViewType.allTransfer) {
      return Row(
        children: <Widget>[
          Container(
                 width: screenSize.width - ScreenUtil().setWidth(300),
                 alignment: Alignment.topCenter,
                 child: _getTextField(true),
               ),
               Container(height: ScreenUtil().setHeight(40), child: VerticalDivider(color: Color.fromARGB(255, 187, 187, 187))),
               Container(
                 padding: EdgeInsets.only(left : 5),
                 width: ScreenUtil().setWidth(150),
                 height: ScreenUtil().setHeight(60),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Text('全部转出',style : TextStyle(fontSize : 14 , color : Theme.of(context).primaryColor),),
                   onPressed: (){
                     _controller.text = widget.allAmount;
                      widget.stringEditingCallBack(widget.allAmount);
                   }),
               ),
        ],
      );
    }else if (widget.type == TPTransferAccountsInputRowViewType.normal){
      return _getTextField(false);
    }else{
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
                 width: screenSize.width - ScreenUtil().setWidth(220),
                 alignment: Alignment.topCenter,
                 child: _getTextField(false),
               ),
               Container(
                 padding: EdgeInsets.only(left : 5),
                 width: ScreenUtil().setWidth(100),
                 height: ScreenUtil().setHeight(60),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Icon(IconData(0xe606,fontFamily : 'appIconFonts'),color: Theme.of(context).primaryColor,),
                   onPressed: widget.didClickScanBtnCallBack),
               ),
        ],
      );
    }
  }


  Widget _getTextField(bool isOnlyNeedNumber){
    return CupertinoTextField(
      controller: _controller,
      style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
      decoration: BoxDecoration(
        border : Border.all(
          color : Color.fromARGB(0, 0, 0, 0)
        ),
        color: Color.fromARGB(255, 242, 242, 242) 
      ),
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(24),left: ScreenUtil().setWidth(20)),
      enabled: widget.enable == null ? true : widget.enable,
      inputFormatters: isOnlyNeedNumber == true ? [TPAmountTextInputFormatter()] : [],
    );
  }
}