import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_action_sheet.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
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

class TPMissionChoosePayTypeController extends ValueNotifier<int>{
    TPMissionChoosePayTypeController(int payType) : super(payType);
}

class PPMissionListDoMissionPage extends StatefulWidget {
  PPMissionListDoMissionPage({Key key,this.didRefreshUserInfo,this.payTypeController}) : super(key: key);

  final Function didRefreshUserInfo;

  final TPMissionChoosePayTypeController payTypeController;

  @override
  _PPMissionListDoMissionPageState createState() => _PPMissionListDoMissionPageState();
}

class _PPMissionListDoMissionPageState extends State<PPMissionListDoMissionPage> with AutomaticKeepAliveClientMixin {

  int _payType = 0;

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

    _payType = 7;

    widget.payTypeController.addListener(() {
      _page = 1; 
      _payType = widget.payTypeController.value;
      _refreshController.requestRefresh();
    });
  }

  void _getMissionList(int page){
    _modelManager.getMissionList(page, _payType , (TPTMissionUserInfoModel userInfoModel,List missionList,List payTypeList){
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      if (page == 1){
        _dataSource = [];
      }
      widget.didRefreshUserInfo(userInfoModel,payTypeList);
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



  void _getRate(TPMissionBuyModel model){
     setState(() {
        _isLoading = true;
      });
    _modelManager.getRate((double rate){
        if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
        showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TPBuyActionSheet(missionModel: model,rate: rate,didClickBuyBtnCallBack: (TPBuyPramaterModel pramaterModel){
                _buyTask(pramaterModel);
              },);
            });
    
    }, (TPError error){
       if(mounted){
              setState(() {
        _isLoading = false;
      });
      }
      if (error.code == 1000){
        showDialog(context: context,builder : (context)=> TPAlertView(type: TPAlertViewType.normal,alertString: error.msg,title: '温馨提示',didClickSureBtn: (){},));
      }else{
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
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
        _refreshController.requestRefresh();
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
    if (_dataSource.length > 0){
        return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TPMissionBuyModel missionBuyModel = _dataSource[index];
      return PPMissionListDoMissionCell(
        missionModel: missionBuyModel,
        didClickBuyBtnCallBack: (){
          _getRate(missionBuyModel);
        },
      );
     },
      );
    }else {
      return TPEmptyDataView(
        imageAsset: 'assetss/images/no_mission.png',
        title: '暂无任务单',
      );
    }
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}