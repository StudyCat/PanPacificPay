import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_sign_list_member_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_sign_list_member_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPSignListMemberPage extends StatefulWidget {
  TPSignListMemberPage({Key key}) : super(key: key);

  @override
  _TPSignListMemberPageState createState() => _TPSignListMemberPageState();
}

class _TPSignListMemberPageState extends State<TPSignListMemberPage> {

  TPSignListMemberModelManager _modelManager;

  int _page = 1;

  RefreshController _refreshController;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh : true);

    _modelManager = TPSignListMemberModelManager();
    _getSignList(_page);
  }

    void _getSignList(int page){
      _modelManager.getSignList(page, (List signList){
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        if (page == 1){
          _dataSource = [];
        }
        if (mounted){
          setState(() {
            _dataSource.addAll(signList);
          });
        }
        if (signList.length > 0){
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
        complete : Text(I18n.of(context).refreshComplete),
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
        _getSignList(_page);
      },
      onLoading: (){
        _getSignList(_page);
      },
    );
  }


  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      return TPSignListMemberCell(model: _dataSource[index],);
     },
    );
  }

}