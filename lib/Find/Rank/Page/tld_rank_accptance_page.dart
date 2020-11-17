import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Rank/Model/tld_rank_accptance_model_manager.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_acceptance_cell.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_acceptance_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPRankAccptancePage extends StatefulWidget {
  TPRankAccptancePage({Key key}) : super(key: key);

  @override
  _TPRankAccptancePageState createState() => _TPRankAccptancePageState();
}

class _TPRankAccptancePageState extends State<TPRankAccptancePage> {
 TPRankAccptanceModelManager _modelManager;

  List _dataSource = [];

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPRankAccptanceModelManager();

    _getRankList();
  }

  void _getRankList(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getAcceptanceRankList((List rankList){
      _dataSource = [];
      if(mounted){
      setState(() {
        _isLoading = false;
        _dataSource.addAll(rankList);
      });
    }
    },(TPError error){
      if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
    Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget());
  }

  Widget _getBodyWidget(){
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
             return TPRankAcceptanceHeaderCell();
           }else{
             return TPRankAcceptanceCell(rankModel: _dataSource[index - 1],);
           }
          },
         ),
      ), 
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}