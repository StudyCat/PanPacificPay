import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Page/pp_mission_detail_order_page.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_list_do_mission_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PPMissionListDoMissionPage extends StatefulWidget {
  PPMissionListDoMissionPage({Key key,this.didRefreshUserInfo}) : super(key: key);

  final Function didRefreshUserInfo; 

  @override
  _PPMissionListDoMissionPageState createState() => _PPMissionListDoMissionPageState();
}

class _PPMissionListDoMissionPageState extends State<PPMissionListDoMissionPage> with AutomaticKeepAliveClientMixin {

  TPMissionListDoMissionModelManager _modelManager;

  int _page = 1;

  List _dataSource = [];

  RefreshController _refreshController;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);
    
    _modelManager =  TPMissionListDoMissionModelManager();
  }

  void _getMissionList(int page){
    _modelManager.getMissionList(page, (TPTMissionUserInfoModel userInfoModel,List missionList){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      if (_page == 1){
        _dataSource = [];
      }
      widget.didRefreshUserInfo(userInfoModel);
      setState(() {
        _dataSource.addAll(missionList);
      });
      if (missionList.length > 0){
        _page = page + 1;
      }
    }, (TPError error){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _buyTask(TPBuyPramaterModel pramaterModel){
    setState(() {
      _isLoading = true;
    });
    _modelManager.buyMission(pramaterModel, (String orderNo){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Navigator.push(context, MaterialPageRoute(builder : (context) => PPMissionDetailOrderPage(orderNo : orderNo))).then((value){
        _page = 1;
        _refreshController.requestRefresh();
        _getMissionList(_page);
      });
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
    return LoadingOverlay(isLoading: _isLoading, child: _refreshWidget());
  }

  Widget _refreshWidget(){
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getBodWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text(I18n.of(context).pullUpToLoad);
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text(I18n.of(context).dropDownToLoadMoreData);
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _page = 1;
        _getMissionList(_page);
      },
      onLoading: (){
        _getMissionList(_page);
      },
    );
  }

  Widget _getBodWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TPMissionBuyModel missionBuyModel = _dataSource[index];
      return PPMissionListDoMissionCell(
        missionModel: missionBuyModel,
        didClickBuyBtnCallBack: (){
          showModalBottomSheet(context: context,builder :(context){
            TPMissionBuyModel missionBuyModel = _dataSource[index];
            return TPBuyActionSheet(missionModel: missionBuyModel,didClickBuyBtnCallBack: (TPBuyPramaterModel pramaterModel){
              _buyTask(pramaterModel);
            },);
          });
        },
      );
     },
    );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}