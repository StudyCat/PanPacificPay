import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Model/tld_deteail_recieve_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_detail_recieve_red_envelope_header_cell.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_detail_red_envelope_content_cell.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_detail_red_envelope_header_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPDetailRecieveRedEnvelopePage extends StatefulWidget {
  TPDetailRecieveRedEnvelopePage({Key key,this.receiveLogId}) : super(key: key);

  final int receiveLogId;

  @override
  _TPDetailRecieveRedEnvelopePageState createState() => _TPDetailRecieveRedEnvelopePageState();
}

class _TPDetailRecieveRedEnvelopePageState extends State<TPDetailRecieveRedEnvelopePage> {
  bool _isLoading = false;

  TPDetailRedEnvelopeModel _detailRedEnvelopeModel;

  TPDetailRecieveRedEnvelopeModelManager _modelManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPDetailRecieveRedEnvelopeModelManager();
    _getDetailInfo();
  }

  void _getDetailInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getDetailInfo(widget.receiveLogId, (TPDetailRedEnvelopeModel detailRedEnvelopeModel){
      if(mounted){
        setState(() {
          _isLoading = false;
          _detailRedEnvelopeModel = detailRedEnvelopeModel;
        });
      }
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
        heroTag: 'detail_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).detailRedEnvelope,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 243, 87, 68),
        actionsForegroundColor: Colors.white,
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 125 * 7,
          child :  Image.asset("assetss/images/detail_red_packet_bg.png",fit: BoxFit.fill,)),
        Expanded(
          child: ListView.builder(
            itemCount: _detailRedEnvelopeModel != null ? _detailRedEnvelopeModel.receiveList.length + 2 : 0,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0){
                return TPDetailRecieveRedEnvelopeHeaderCell(detailRedEnvelopeModel: _detailRedEnvelopeModel,);
              }else if (index == 1){
                return TPDetailRedEnvelopeHeaderCell(detailRedEnvelopeModel: _detailRedEnvelopeModel,);
              }else{
                TPRedEnvelopeReiceveModel reiceveModel = _detailRedEnvelopeModel.receiveList[index - 2];
                return TPDetailRedEnvelopeContentCell(reiceveModel: reiceveModel,);
              }
           },
          ),
          )
      ],
    );
  }
}