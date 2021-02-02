import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_pay_type_screen_content_view.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_mission_recorder_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TPBuyPayTypeScreenViewController extends ValueNotifier<bool>{
    TPBuyPayTypeScreenViewController(bool isShow) : super(isShow);


}

class TPBuyPayTypeScreenView extends StatefulWidget {
  TPBuyPayTypeScreenView({Key key,this.controller,this.payTypeList,this.didClickSureBtnCallBack}) : super(key: key);

  final TPBuyPayTypeScreenViewController controller;

  final Function didClickSureBtnCallBack;

  final List payTypeList;

  @override
  _TPBuyPayTypeScreenViewState createState() => _TPBuyPayTypeScreenViewState();
}

class _TPBuyPayTypeScreenViewState extends State<TPBuyPayTypeScreenView>  with TickerProviderStateMixin {
  // AnimationController _controller;
  bool isShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener((){
       setState(() {
         isShow = widget.controller.value;
       });
    });
    isShow = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Offstage(
      offstage: !isShow,
      child: Column(
        children: <Widget>[
          TPBuyPayTypeScreenContentView(
            payTypeList: widget.payTypeList,
            didClickChooseCallBack: (TPScreenPayTypeModel payTypeModel){
              widget.didClickSureBtnCallBack(payTypeModel);
            },
          ),
          Expanded(
             child: GestureDetector(
               onTap:(){
                 widget.controller.value = !widget.controller.value;
               },
               child : Container(
            color: Color.fromARGB(150, 51, 51, 51),
            width: size.width,
             ),
          ))
        ],
      ),
    );
  }
}