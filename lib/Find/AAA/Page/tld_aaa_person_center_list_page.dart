import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_person_center_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_person_center_list_cell.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPAAAPersonCenterListPage extends StatefulWidget {
  TPAAAPersonCenterListPage({Key key,this.type}) : super(key: key);

  final int type;

  @override
  _TPAAAPersonCenterListPageState createState() => _TPAAAPersonCenterListPageState();
}

class _TPAAAPersonCenterListPageState extends State<TPAAAPersonCenterListPage> {

  TPAAAPersonCenterListModelManager _modelManager;

  List _dataSource;

  int _page = 1;

  RefreshController _refreshController;

  StreamSubscription _refreshSubscription;

  @override
  void initState() { 
    super.initState();

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh: false);

    _refreshSubscription = eventBus.on<TPAAAUpgradeListRefreshEvent>().listen((event) {
        _page = 1;
        _getUpgradeList(_page); 
    });

    _modelManager = TPAAAPersonCenterListModelManager();
    _getUpgradeList(_page);  
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _refreshSubscription.cancel();
    _refreshSubscription = null;
  }

  void _getUpgradeList(int page){
    _modelManager.getUpgradeList(widget.type, page, (List upgradeList){
       _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
      }
      if(mounted){
        setState(() {
          _dataSource.addAll(upgradeList);
        });
      }
      if(upgradeList.length > 0){
        _page = page + 1;
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
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      child: _getBodyWidget(),
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
        _getUpgradeList(_page);
      },
      onLoading: (){
        _getUpgradeList(_page);
      },
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TPAAAUpgradeListModel model = _dataSource[index];
      return TPAAAPersonCenterListCell(index: index,listModel: model,);
     },
    );
  }

}