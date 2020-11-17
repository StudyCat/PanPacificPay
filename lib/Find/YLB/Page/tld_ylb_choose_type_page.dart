import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_choose_type_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/View/tld_ylb_choose_type_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';


class TPYLBChooseTypePage extends StatefulWidget {
  TPYLBChooseTypePage({Key key,this.didChooseTypeCallBack}) : super(key: key);

  final Function didChooseTypeCallBack;

  @override
  _TPYLBChooseTypePageState createState() => _TPYLBChooseTypePageState();
}

class _TPYLBChooseTypePageState extends State<TPYLBChooseTypePage> {

  bool _isLoading = false;

  List _dataSource = [];

  TPYLBChooseTypeModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPYLBChooseTypeModelManager();
    _getTypeList();
  }


  void _getTypeList(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getTypeList((List typeList){
      if (mounted){
        setState(() {
          _isLoading = false;
          _dataSource = typeList;
        });
      }
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
        heroTag: 'exchange_choose_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('余利宝支付方式'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: (){
          TPYLBTypeModel model = _dataSource[index];
          widget.didChooseTypeCallBack(model);
          Navigator.of(context).pop();
        },
        child: TPYLBChooseTypeCell(typeModel: _dataSource[index],),
      );
     },
    );
  }
}