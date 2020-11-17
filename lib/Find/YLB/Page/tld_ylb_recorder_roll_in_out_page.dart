import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_roll_in_out_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/View/tld_ylb_recorder_roll_in_out_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPYLBRecorderRollInOutPage extends StatefulWidget {
  TPYLBRecorderRollInOutPage({Key key, this.type}) : super(key: key);

  final int type; //1为转入，2为转出

  @override
  _TPYLBRecorderRollInOutPageState createState() =>
      _TPYLBRecorderRollInOutPageState();
}

class _TPYLBRecorderRollInOutPageState
    extends State<TPYLBRecorderRollInOutPage> {
  TPYLBRecorderRollInOutModelManager _modelManager;

  RefreshController _refreshController;

  List _dataSource;

  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TPYLBRecorderRollInOutModelManager();

    _dataSource = [];
    if (widget.type == 1) {
      _getRollInList(_page);
    } else {
      _getRollOutList(_page);
    }
  }

  void _getRollInList(int page) {
    _modelManager.getRollInList(page, (List profitList) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      if (mounted) {
        setState(() {
          _dataSource.addAll(profitList);
        });
      }
      if (profitList.length > 0) {
        _page = page + 1;
      }
    }, (TPError error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _getRollOutList(int page) {
    _modelManager.getRollOutList(page, (List profitList) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      if (mounted) {
        setState(() {
          _dataSource.addAll(profitList);
        });
      }
      if (profitList.length > 0) {
        _page = page + 1;
      }
    }, (TPError error) {
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
        complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(I18n.of(context).pullUpToLoad);
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.canLoading) {
            body = Text(I18n.of(context).dropDownToLoadMoreData);
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      onRefresh: () {
        _page = 1;
        if (widget.type == 1) {
          _getRollInList(_page);
        } else {
          _getRollOutList(_page);
        }
      },
      onLoading: () {
        if (widget.type == 1) {
          _getRollInList(_page);
        } else {
          _getRollOutList(_page);
        }
      },
    );
  }

  Widget _getBodyWidget() {
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        return TPYLBRecorderRollInOutCell(type: widget.type,profitListModel: _dataSource[index],);
      },
    );
  }
}
