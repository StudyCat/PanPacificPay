import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_plus_star_model_manager.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_action_sheet.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_notice_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPAAAPlusStarPage extends StatefulWidget {
  TPAAAPlusStarPage({Key key}) : super(key: key);

  @override
  _TPAAAPlusStarPageState createState() => _TPAAAPlusStarPageState();
}

class _TPAAAPlusStarPageState extends State<TPAAAPlusStarPage> {

  RefreshController _refreshController;

  TPAAAPlusStarModelManager _modelManager;

  List _dataSource = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh:false);

    _modelManager = TPAAAPlusStarModelManager();
    _getStarList();
  }

  void _getStarList(){
    _modelManager.getStarList((List starList){
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted){
        setState(() {
          _dataSource.addAll(starList);
        });
      }
    }, (TPError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _upgrade(TPAAAPlusStarPramater pramater){
    setState(() {
      _isLoading = true;
    });
    _modelManager.upgrade(pramater, (){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '升级成功');
      _refreshController.requestRefresh();
      _getStarList();
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
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'plus_star_page',
        transitionBetweenRoutes: false,
        middle: Text('团队升星'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getRefreshWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242));
  }

  Widget _getRefreshWidget(){
    return SmartRefresher(
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(context).refreshComplete),
      ),
      onRefresh: (){
        _getStarList();
      }
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TPAAAPlusStarNoticeCell(noticeCotent: '如果您的连续签到中断，团队星级将会重置。',);
      }else{
        TPTeamStarModel model = _dataSource[index - 1];
        return TPAAAPlusStarCell(
          starModel: model,
          didClickPlusStarButton: (){
            showModalBottomSheet(
              context: context,
              builder: (context) => TPAAAPlusStarActionSheet(teamLevel: model.teamLevel,didClickUpgrade:(TPAAAPlusStarPramater pramater){
                _upgrade(pramater);
              },)
            );
          },
        );
      }
     },
    );
  }
}
