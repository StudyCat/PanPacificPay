import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_notice_cell.dart';
import 'package:dragon_sword_purse/Find/AmountUpgrade/Model/tp_account_upgrade_model_manager.dart';
import 'package:dragon_sword_purse/Find/AmountUpgrade/View/tp_account_upgrade_action_sheet.dart';
import 'package:dragon_sword_purse/Find/AmountUpgrade/View/tp_amount_upgrade_profit_desc_cell.dart';
import 'package:dragon_sword_purse/Find/AmountUpgrade/View/tp_amount_upgrade_profit_header_cell.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPAccountUpgradePage extends StatefulWidget {
  TPAccountUpgradePage({Key key}) : super(key: key);

  @override
  _TPAccountUpgradePageState createState() => _TPAccountUpgradePageState();
}

class _TPAccountUpgradePageState extends State<TPAccountUpgradePage> {
  TPAccountUpgradeModelManager _modelManager;

  TPTMissionUserInfoModel _userInfoModel;

  List _dataSource = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _modelManager = TPAccountUpgradeModelManager();
    _getAccountUpgradeInfo();
  }

  void _getAccountUpgradeInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getAccountInfo((TPTMissionUserInfoModel userInfoModel,List levelDescList){
      _dataSource = [];
      if (mounted){
        setState(() {
        _isLoading = false;
        _userInfoModel = userInfoModel;
        _dataSource = levelDescList;
      });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }


  void _getUpgradeCondition(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getUpgradeCondition((String payCount,String content,String levelIcon){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      showModalBottomSheet(context: context, builder: (contex) => TPAccountUpgradeActionSheet(
        content: content,
        payAmount: payCount,
        levelIcon: levelIcon,
        didClickUpgrade: (String walletAddress){
          _upgrade(walletAddress);
        },
      ));
    }, (TPError error){
      if (mounted){
        setState(() {
        _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _upgrade(String walletAddress){
      setState(() {
      _isLoading = true;
    });
    _modelManager.upgrade(walletAddress,(){
      if (mounted){
        setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '升级成功');
      _getAccountUpgradeInfo();
    }, (TPError error){
      if (mounted){
        setState(() {
        _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
          backgroundColor: Color.fromARGB(255, 242, 242, 242),
          border: Border.all(
            color: Color.fromARGB(0, 0, 0, 0),
          ),
          heroTag: 'mission_root_page',
          transitionBetweenRoutes: false,
          middle: Text('任务'),
         ),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          TPAAAPlusStarNoticeCell(noticeCotent: '提升等级将提高您的每日额度！'),
        _getUserLevelWidget(),
         Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10),),
          child: Text('权益说明',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Expanded(child: _profitDescListView())
      ],
    );
  }

   Widget _getUserLevelWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: RichText(
                text: TextSpan(
                    children: <InlineSpan>[
                    WidgetSpan(
                       child: _userInfoModel != null ? CachedNetworkImage(
                          imageUrl: _userInfoModel.userLevelIcon,
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setHeight(30),
                        ) : Container()
                    ),
                      TextSpan(
                    text: ' (',
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: ScreenUtil().setSp(32)),),
                      TextSpan(
                        text:  _userInfoModel != null ? _userInfoModel.curQuota : '0',
                        style: TextStyle(
                            color: Color.fromARGB(255, 153, 153, 153),
                            fontSize: ScreenUtil().setSp(32)),
                      ),
                      TextSpan(
                        text: _userInfoModel != null ? '/${_userInfoModel.totalQuota})' : '/0)',
                        style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: ScreenUtil().setSp(32)),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(20)),
              child: Container(
                height : ScreenUtil().setHeight(80),
                width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                child : CupertinoButton(
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).primaryColor,
                  child: Text('升级',style : TextStyle(color : Colors.white,fontSize:ScreenUtil().setSp(36))), onPressed: (){
                    _getUpgradeCondition();
                })
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profitDescListView(){
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(20), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
      child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white
         ),
         child: ListView.builder(
           itemCount: _dataSource.length + 1,
           itemBuilder: (BuildContext context, int index) {
           if (index == 0){
             return TPAmountUpgradeProfitHeaderCell();
           }else{
             return TPAccountUpgradeProfitDescCell(levelDescModel: _dataSource[index - 1],);
           }
          },
         ),
      ), 
      );
  }

}