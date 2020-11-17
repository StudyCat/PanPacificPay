import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_purse_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'purse_sideslip_header_cell.dart';


class TPPurseSideslipView extends StatefulWidget {
  TPPurseSideslipView({Key key,this.didClickCallBack}) : super(key: key);

  final ValueChanged<int> didClickCallBack;

  @override
  _TPPurseSideslipViewState createState() => _TPPurseSideslipViewState();
}

class _TPPurseSideslipViewState extends State<TPPurseSideslipView> {

  List iconList = [0xe641,0xe672,0xe8ac,0xe665,0xe60e];
  List titleList = [I18n.of(navigatorKey.currentContext).collectionMethod,I18n.of(navigatorKey.currentContext).tldExchangeDescription,I18n.of(navigatorKey.currentContext).feedBack,I18n.of(navigatorKey.currentContext).aboutUS,I18n.of(navigatorKey.currentContext).userAgreement];

  String _totalAmount;

  TPPurseModelManager _manager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _manager = TPPurseModelManager();

    _totalAmount = '0.0';
    
    getTotalAmount();
  }

  void getTotalAmount(){
    _manager.getAllAmount((String total){
      if (mounted){
              setState(() {
        _totalAmount = total;
      });
      }
    }, (TPError error){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: ListView.builder(
      itemCount: iconList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TPPurseSideSlipHeaderCell(totalAmount: _totalAmount);
        }else{
          return ListTile(
            leading : Container(
              padding : EdgeInsets.only(left: 35),
              child: Icon(IconData(iconList[index - 1],fontFamily: 'appIconFonts'),color: Theme.of(context).hintColor,),
            ),
            title: Text(titleList[index - 1],style : TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: 14),textAlign: TextAlign.left,),
            onTap: (){
              widget.didClickCallBack(index);
            },
          );
        }
     },
      ),
    ),
    );
  }
}

