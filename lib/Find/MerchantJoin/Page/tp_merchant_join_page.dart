import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:dragon_sword_purse/Find/MerchantJoin/Model/tp_merchant_join_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPMerchantJoinPage extends StatefulWidget {
  TPMerchantJoinPage({Key key}) : super(key: key);

  @override
  _TPMerchantJoinPageState createState() => _TPMerchantJoinPageState();
}

class _TPMerchantJoinPageState extends State<TPMerchantJoinPage> {
  TPMerchantJoinParmater _pramaterModel;

  TPMerchantJoinModelManager _manager;

  bool _loading;

  String _delegateInfo;

  List titles = [
    'APP名称',
    'APP类别',
    'APP负责人',
    '联系邮箱'
  ];

  List placeholders = [
    '请输入APP名称',
    '请输入APP类别',
    '请输入APP负责人',
    '请输入联系邮箱',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _loading = false;

    _pramaterModel = TPMerchantJoinParmater();
    _pramaterModel.name = '';
    _pramaterModel.category = '';
    _pramaterModel.email = '';
    _pramaterModel.dutyOfficer = '';

    _manager = TPMerchantJoinModelManager();
    _getDelegateInfo();
  }

  void _joinMerchant(){
    if(_pramaterModel.name.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写APP名称",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.email.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写邮箱地址",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.dutyOfficer.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写负责人",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.category.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写APP类别",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.joinMerchant(_pramaterModel, (){
      if (mounted){
        setState(() {
          _loading = false;
        });
      }
      Fluttertoast.showToast(
                      msg: "商户入驻申请已提交",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TPError error){
      if (mounted){
       setState(() {
        _loading = false;
      });
      }
    });
  }

  void _getDelegateInfo(){
    setState(() {
      _loading = true;
    });
    _manager.getDelegateInfo((String delegateInfo){
      if (mounted){
        setState(() {
          _loading = false;
          _delegateInfo = delegateInfo;
        });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
          _loading = true;
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
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text('商户资料'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        trailing:  GestureDetector(
          onTap:(){
            _joinMerchant();
          },
          child : Text('加入商户',style:TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28),fontWeight: FontWeight.bold))
        ),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index < titles.length){
            String content;
          if(index == 0){
            content = _pramaterModel.name;
          }else if(index == 1){
            content = _pramaterModel.category;
          }else if(index == 2){
            content = _pramaterModel.dutyOfficer;
          }else if(index == 3){
            content = _pramaterModel.email;
          }
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TPClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
          if(index == 0){
            _pramaterModel.name = string;
          }else if(index == 1){
            _pramaterModel.category = string;
          }else if(index == 2){
            _pramaterModel.dutyOfficer = string;
          }else if(index == 3){
            _pramaterModel.email = string;
          }
        },),
        );
        }else{
          return Column(
            children :<Widget>[
              Padding(padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
              child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text(_delegateInfo != null ? _delegateInfo : '',style: TextStyle(
                  fontSize : ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)
                ),),
              ),
              ),
            ]
          ); 
        }
      }
    );
  }
}