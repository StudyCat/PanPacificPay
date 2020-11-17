import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Rank/Model/tld_normal_rank_model_manager.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_normal_cell.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_normal_header_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

enum TPRankNormalPageType{
  month,
  week
}


class TPRankNormalPage extends StatefulWidget {
  TPRankNormalPage({Key key,this.type}) : super(key: key);

  final TPRankNormalPageType type;

  @override
  _TPRankNormalPageState createState() => _TPRankNormalPageState();
}

class _TPRankNormalPageState extends State<TPRankNormalPage>  {

  TPNormalRankModelManager _modelManager;

  bool _isLoading = true;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPNormalRankModelManager();

    if (widget.type == TPRankNormalPageType.month){
      _getMonthRankList();
    }else{
      _getWeekRankList();
    }
  }

  void _getMonthRankList(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getMonthRankList((List rankList){
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

    void _getWeekRankList(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getWeekRankList((List rankList){
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
             return TPRankNormalHeaderCell();
           }else{
             return TPRankNormalCell(rank : index,rankModel: _dataSource[index - 1],);
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