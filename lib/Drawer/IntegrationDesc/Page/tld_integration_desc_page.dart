import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/IntegrationDesc/Model/tld_integration_desc_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_common_cell.dart';

class TPIntegrationDescPage extends StatefulWidget {
  TPIntegrationDescPage({Key key}) : super(key: key);

  @override
  _TPIntegrationDescPageState createState() => _TPIntegrationDescPageState();
}

class _TPIntegrationDescPageState extends State<TPIntegrationDescPage> {

  TPIntergrationDescModelManager _modelManager;

  String _rate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPIntergrationDescModelManager();
    _modelManager.getRate((String rate){
      setState(() {
        _rate = rate;
      });
    }, (TPError error){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'integration_desc_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).tldExchangeDescription),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index){
        String title = '';
        if (index == 0) {
          title = I18n.of(context).SubscriptionRatio + '：1TP=1CNY';
        }else{
          title = _rate != null ? _rate : '';
        }
       return Padding(
         padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
         child: TPClipCommonCell(type : TPClipCommonCellType.normal,title: title,titleStyle: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),content: '',contentStyle: TextStyle(),),
       ); 
      });
  }
}