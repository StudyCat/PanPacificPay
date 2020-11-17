import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_invitation_detail_earning_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_header_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TPAcceptanceInvitationDetailEarningPage extends StatefulWidget {
  TPAcceptanceInvitationDetailEarningPage({Key key,this.userName}) : super(key: key);

  final String userName;

  @override
  _TPAcceptanceInvitationDetailEarningPageState createState() => _TPAcceptanceInvitationDetailEarningPageState();
}

class _TPAcceptanceInvitationDetailEarningPageState extends State<TPAcceptanceInvitationDetailEarningPage> {

  TPAcceptanceInvitationDetailEarningModelManager _modelManager;

  bool _isLoading = true;

  TPInviteDetailEarningModel _detailEarningModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TPAcceptanceInvitationDetailEarningModelManager();
    _getDetailInfo();
  }

  void _getDetailInfo(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getDetailEarningInfo(widget.userName, (TPInviteDetailEarningModel detailEarningModel){
     if(mounted){
      setState(() {
        _isLoading = false;
        _detailEarningModel = detailEarningModel;
      });
    } 
    }, (TPError error){
      if(mounted){
      setState(() {
        _isLoading = false;
      });
    } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          
        }),
        heroTag: 'detail_earning_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).detailProfit),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    if (_detailEarningModel != null){
      return ListView.builder(
      itemCount: _detailEarningModel.list.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if(index == 0){
          return TPAcceptanceInvitationDetailHeaderCell(detailEarningModel: _detailEarningModel,);
        }else if(index == _detailEarningModel.list.length + 1){
          return _getBottomCell();
        }else{
          TPEarningBillModel earningBillModel = _detailEarningModel.list[index - 1];
          return TPAcceptanceInvitationDetailEarningCell(earningBillModel: earningBillModel,);
        }
     },
    );
    }else{
      return Container();
    }
  }


  Widget _getBottomCell(){
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
        child: Row(
          children: <Widget>[
            Text(I18n.of(context).TotalPromotionRevenue,style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),),
        Text('${_detailEarningModel.totalProfit}TP',style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,)
          ],
        ),
       ),
    );
  }

}