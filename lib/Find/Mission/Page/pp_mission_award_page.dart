import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_award_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/Model/tp_mission_list_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_deal_details_cell.dart';
import 'package:dragon_sword_purse/Find/Mission/View/pp_mission_excharge_action_sheet.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';

class PPMissionAwardPage extends StatefulWidget {
  PPMissionAwardPage({Key key}) : super(key: key);

  @override
  _PPMissionAwardPageState createState() => _PPMissionAwardPageState();
}

class _PPMissionAwardPageState extends State<PPMissionAwardPage> {

  TPMissionAwardModelManager _modelManager;

  int _page = 1;

  RefreshController _refreshController;

  TPTMissionUserInfoModel _userInfoModel;

  TPMissionAwardPoolInfoModel _awardPoolInfoModel;

  List _dataSource = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPMissionAwardModelManager();
  }

  void _getAwardPoolInfo(int page){
    _modelManager.getAwardPoolInfo(page, (TPTMissionUserInfoModel userInfoModel,TPMissionAwardPoolInfoModel awardPoolInfoModel,List detailsList){
       _refreshController.loadComplete();
      _refreshController.refreshCompleted();
      if (_page == 1){
        _dataSource = [];
      }
      setState(() {
        _userInfoModel = userInfoModel;
        _awardPoolInfoModel = awardPoolInfoModel;
        _dataSource.addAll(detailsList);
      });
      if (detailsList.length > 0){
        _page = page + 1;
      }
    }, (TPError error){

    });
  }

  void _excharge(String amount,String walletAddress){
    setState(() {
      _isLoading = true;
    });
    _modelManager.exCharge(amount, walletAddress, (){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '兑换成功');
      _page = 1;
      _refreshController.requestRefresh();
      // _getAwardPoolInfo(_page);
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
          trailing: GestureDetector(
            child: Text('更高奖励'),
           onTap : (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TPWebPage(type: TPWebPageType.upgradeDesc,title: '升级说明',)));
        }),
          ),
    );
  }

  Widget _getBodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _getUserLevelWidget(),
        _getAwardPoolWidget(),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10),),
          child: Text('交易明细',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10),),
          child: _refreshWidget(),
        ))
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
        height: ScreenUtil().setHeight(88),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child:  RichText(
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
            )
          ],
        ),
      ),
    );
  }

    Widget _refreshWidget(){
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getDealDetailsListView(),
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
        _getAwardPoolInfo(_page);
      },
      onLoading: (){
        _getAwardPoolInfo(_page);
      },
    );
  }

  Widget _getAwardPoolWidget() {
    return  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getColumnAwardPoolWidget(),
            Padding(
              padding: EdgeInsets.only(right : ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
              child: Container(
                height : ScreenUtil().setHeight(60),
                width : ScreenUtil().setWidth(150),
                child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(30))),
                  padding: EdgeInsets.zero,
                  child: Text('兑换',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),), 
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (context) => PPMissionExchargeActionSheet(
                      didExchargeCallBack: (String amount,String walletAddress){
                        _excharge(amount, walletAddress);
                      },
                    ));
                  }),
              ),
            )
          ],
        ),
      ));
  }

  Widget _getColumnAwardPoolWidget(){
    return Column(
      children : [
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
          child:RichText(
                text: TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                       child: _awardPoolInfoModel != null ? CachedNetworkImage(
                          imageUrl: _awardPoolInfoModel.levelIcon,
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setHeight(30),
                        ) : Container()
                    ),
                      TextSpan(
                        text: _awardPoolInfoModel != null ? ' ${_awardPoolInfoModel.profitPoolCount} ' : ' 0 ',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: ScreenUtil().setSp(32)),
                      ),
                       WidgetSpan(
                        child: Icon(
                          IconData(
                          0xe622,
                          fontFamily: 'appIconFonts'
                        ),
                        color: Theme.of(context).hintColor,
                        size: ScreenUtil().setHeight(30),
                        )
                )]),
        )
        ),
        Padding(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          child: Text(_awardPoolInfoModel != null ? '奖励比例 ${_awardPoolInfoModel.profitRate}%' : '奖励比例 0%',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)),),
        )
        ]
    );
  }

  Widget _getDealDetailsListView(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      return PPMissionDealDetailsCell(detailsModel: _dataSource[index],);
     },
    );
  }


}
