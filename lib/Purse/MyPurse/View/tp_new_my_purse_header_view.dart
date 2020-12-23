import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/View/tp_new_my_purse_action_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewMyPurseHeaderView extends StatefulWidget {
  TPNewMyPurseHeaderView({Key key,this.infoModel,this.didClickActionCallBack}) : super(key: key);

  final TPWalletInfoModel infoModel;

  final Function didClickActionCallBack;

  @override
  _TPNewMyPurseHeaderViewState createState() => _TPNewMyPurseHeaderViewState();
}

class _TPNewMyPurseHeaderViewState extends State<TPNewMyPurseHeaderView> {

  List images = ['assetss/images/my_purse_scan.png','assetss/images/my_purse_get_money.png','assetss/images/my_purse_exchange.png'];
  List titles = ['出售','收款码','转账'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(100, 198, 198, 198),
                  offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  )
            ]),
        padding : EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
        child: Column(
          children: <Widget>[
            _getPurseInfoView(),
            _getActionView()
          ],

        ),
      )
    );
  }

  Widget _getPurseInfoView(){
    String intString = '0';
    String doubleString = '';
    if (widget.infoModel != null){
          List moneyList = widget.infoModel.value.split('.');
          intString = moneyList.first;
          if (moneyList.length > 1){
              doubleString = moneyList.last;
          }
    }
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      height: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(100)) / 650 * 314,
      decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            image: DecorationImage(image: AssetImage('assetss/images/purse_detail_bg.png'),fit: BoxFit.fill),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(44),left: ScreenUtil().setWidth(28)),
            child: Text('总资产（TP）',style : TextStyle(color : Color.fromARGB(255, 234, 234, 234),fontSize : ScreenUtil().setSp(36))),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(14),left: ScreenUtil().setWidth(28)),
            child: RichText(
              text: TextSpan(text:'=' + intString,style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(52)),children: [
                TextSpan(text:doubleString.length > 0 ? '.' + doubleString : '',style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(40)))
            ])),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),left: ScreenUtil().setWidth(28)),
            child: Text('1.00TP=1.00USD',style : TextStyle(color : Color.fromARGB(255, 234, 234, 234),fontSize : ScreenUtil().setSp(32))),
          )
        ],
      ),
    );
  }

  Widget _getActionView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
      child: GridView.builder(
                      physics: new NeverScrollableScrollPhysics(), //增加
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: ScreenUtil().setWidth(60),),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap : (){
                            widget.didClickActionCallBack(index);
                          },
                          child : TPNewMyPurseActionView(imageAssest : images[index],title: titles[index],)
                        );
                      }));
  }

}