import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_person_center_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_person_center_invite_person_profit.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class TPAcceptancePersonCenterInvitePersonProfitPage extends StatefulWidget {
  TPAcceptancePersonCenterInvitePersonProfitPage({Key key}) : super(key: key);

  @override
  _TPAcceptancePersonCenterInvitePersonProfitPageState createState() => _TPAcceptancePersonCenterInvitePersonProfitPageState();
}

class _TPAcceptancePersonCenterInvitePersonProfitPageState extends State<TPAcceptancePersonCenterInvitePersonProfitPage> {
  TPAcceptancePersonCenterProfitModelManager _modelManager;

  RefreshController _refreshController;

  List _dataSource = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _modelManager = TPAcceptancePersonCenterProfitModelManager();
    _getSignList();
  }

  void _getSignList(){
      _modelManager.getInviteProfit((List profitList){
        _refreshController.refreshCompleted();
        _dataSource = [];
        if (mounted){
          setState(() {
            _dataSource.addAll(profitList);
          });
        }
      }, (TPError error){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(msg: error.msg);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(context).refreshComplete),
      ),
      onRefresh: (){
        _getSignList();
      }
    );
  }

    Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      return TPAcceptancePersonCenterInvitePersonProfitCell(profitModel:  _dataSource[index]);
     },
    );
  } 
}