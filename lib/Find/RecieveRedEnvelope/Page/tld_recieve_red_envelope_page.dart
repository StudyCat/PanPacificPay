import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonModelManager/tld_qr_code_model_manager.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Model/tld_revieve_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_deteail_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_revieve_red_envelope_cell.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_unopen_red_envelope_alert_view.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TPRecieveRedEnvelopePage extends StatefulWidget {
  TPRecieveRedEnvelopePage({Key key}) : super(key: key);

  @override
  _TPRecieveRedEnvelopePageState createState() => _TPRecieveRedEnvelopePageState();
}

class _TPRecieveRedEnvelopePageState extends State<TPRecieveRedEnvelopePage> {

  TPQRCodeModelManager _qrCodeModelManager;

  TPRecieveRedEnvelopeModelManager _modelManager;

  bool _isLoading = false;

  RefreshController _refreshController;

  int _page = 1;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _qrCodeModelManager = TPQRCodeModelManager();

    _modelManager = TPRecieveRedEnvelopeModelManager();

    _refreshController = RefreshController(initialRefresh: true);

    _getRecieveList(_page);
  }

    void _getRecieveList(int page){
    _modelManager.getRecieveRedEnvelopeList(page, (List result){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
      }
      if(mounted){
        setState(() {
          _dataSource.addAll(result);
        });
      }
      if(result.length > 0){
        _page = page + 1;
      }
    }, (TPError error){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _getRedEnvelopeInfo(String redEnvelopeId){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getRedEnvelopeInfo(redEnvelopeId, (TPDetailRedEnvelopeModel redEnvelopeModel){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      showDialog(context: context,builder:(context) => TPUnopenRedEnvelopeAlertView(
        redEnvelopeModel: redEnvelopeModel,
        didClickOpenButtonCallBack: (String walletAddress){
          _recieveRedEnvelope(walletAddress, redEnvelopeId);
        },
        ));
    }, (TPError error){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.msg);
      }
    });
  }


  void _recieveRedEnvelope(String walletAddress,String redEnvelopeId){
    setState(() {
      _isLoading = true;
    });
    _modelManager.recieveRedEnvelope(redEnvelopeId, walletAddress, (int recieveLogId){
       if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPDetailRecieveRedEnvelopePage(receiveLogId: recieveLogId,))).then((value){
        _refreshController.requestRefresh();
        _page = 1;
        _getRecieveList(_page);
      });
    }, (TPError error){
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
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'recieve_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).recieveRedEnvelope,
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getRefreshWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getRefreshWidget(){
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
        _getRecieveList(_page);
      },
      onLoading: (){
        _getRecieveList(_page);
      },
    );
  }


  Widget _getBodyWidget(){
     return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
         return Padding(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(10),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            bottom: ScreenUtil().setHeight(20)
          ),
          child: Container(
            height : ScreenUtil().setHeight(96),
            child :CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).recieve,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Theme.of(context).hintColor
              )),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (contenxt) => TPScanQrCodePage(
                  scanCallBack: (String qrCode){
                    _qrCodeModelManager.scanQRCodeResult(qrCode, (TPQRcodeCallBackModel callBackModel){
                      if (callBackModel.type == QRCodeType.redEnvelope){
                        _getRedEnvelopeInfo(callBackModel.data);
                      }
                    }, (TPError error){
                      Fluttertoast.showToast(msg: error.msg);
                    });
                  },
                )));
              }),
          )
        );
        }else{
          TPRedEnvelopeReiceveModel reiceveModel = _dataSource[index - 1];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TPDetailRecieveRedEnvelopePage(receiveLogId: reiceveModel.receiveLogId,)));
            },
            child: TPRecieveRedEnvelopeCell(reiceveModel : reiceveModel),
          );
        }
     },
    );
  }
}