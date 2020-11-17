import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_earnings_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_detail_earning_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_search_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_unopen_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPAcceptanceInvitationEarningsPage extends StatefulWidget {
  TPAcceptanceInvitationEarningsPage({Key key}) : super(key: key);

  @override
  _TPAcceptanceInvitationEarningsPageState createState() => _TPAcceptanceInvitationEarningsPageState();
}

class _TPAcceptanceInvitationEarningsPageState extends State<TPAcceptanceInvitationEarningsPage> {
  TPAcceptanceEarningsModelManager _modelManager;

  RefreshController _refreshController;

  List _dataSource = [];

  String _tel = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPAcceptanceEarningsModelManager();
    _getInviteTeamInfo(_tel);
  }

  void _getInviteTeamInfo(String tel){
    _modelManager.getInviteTeamInfo(tel,(List result){
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted){
        setState(() {
          _dataSource.addAll(result);
        });
      }
    }, (TPError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      child: _getListView(),
      header: WaterDropHeader(
        complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      onRefresh: ()=> _getInviteTeamInfo(_tel),
    );
  }

  Widget _getListView(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TPAcceptanceInvitationEarningsSearchCell(
          didClickSearchCallBack: (String tel){
            _getInviteTeamInfo(tel);
          },
          textDidChangeCallBack: (String text){
            _tel = text;
          },
        );
      }else{
        TPInviteTeamModel teamModel = _dataSource[index - 1];
        if (teamModel.isOpen){
          return TPAcceptanceInvitationOpenCell(
          inviteTeamModel: teamModel,
          didClickItemCallBack: (String userName){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TPAcceptanceInvitationDetailEarningPage(userName: userName,)));
          },
          didClickOpenItem: (){
            setState(() {
              teamModel.isOpen = !teamModel.isOpen;
            });
          },
        );
        }else{
           return TPAcceptanceInvitationEarningsUnopenCell(
             inviteTeamModel: teamModel,
             didClickOpenItem: (){
                setState(() {
                 teamModel.isOpen = !teamModel.isOpen;
              });
             },
           );
        }
      }
     },
    );
  }
}