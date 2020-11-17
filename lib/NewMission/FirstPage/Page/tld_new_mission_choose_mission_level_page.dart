import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_choose_mission_level_model_manager.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_choose_mission_level_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TPNewMissionChooseMissionLevelPage extends StatefulWidget {
  TPNewMissionChooseMissionLevelPage({Key key,this.didChooseLevelCallBack}) : super(key: key);

  final Function(TPMissionLevelModel) didChooseLevelCallBack;

  @override
  _TPNewMissionChooseMissionLevelPageState createState() => _TPNewMissionChooseMissionLevelPageState();
}

class _TPNewMissionChooseMissionLevelPageState extends State<TPNewMissionChooseMissionLevelPage> {
  List _dataSource = [];

  StreamController _streamController;

  TPNewMissionChooseMissionLevelModelManager _modelManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPNewMissionChooseMissionLevelModelManager();
    
    _getMissionLevelList();

    _streamController = StreamController();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_mission_level_page',
        transitionBetweenRoutes: false,
        middle: Text('选择任务等级'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

    Widget _getBodyWidget(BuildContext context) {
    return TPEmptyListView(
      streamController: _streamController,
      getEmptyViewCallBack: (){
        return TPEmptyDataView(imageAsset: 'assetss/images/no_data.png',title: '暂无数据',);
      },
      getListViewCellCallBack: (int index){
        return _getListViewItem(context,index);
      },
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
      TPMissionLevelModel model = _dataSource[index];
      return GestureDetector(
        onTap: (){
          widget.didChooseLevelCallBack(model);
          Navigator.of(context).pop();
        },
        child: TPChooseMissionLevelCell(levelModel : model),
      );
  }

  void _getMissionLevelList(){
    _modelManager.getMissionLevelList((List infoList) {
        _dataSource = List.from(infoList);
        if(mounted){
          _streamController.sink.add(_dataSource);
        }
    }, (TPError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController.close();
  }
}