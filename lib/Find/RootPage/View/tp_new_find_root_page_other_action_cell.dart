import 'package:dragon_sword_purse/Find/RootPage/View/tp_new_find_root_page_other_grid_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewFindRootPageOtherActionCell extends StatefulWidget {
  TPNewFindRootPageOtherActionCell({Key key,this.didClickItemCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  @override
  _TPNewFindRootPageOtherActionCellState createState() =>
      _TPNewFindRootPageOtherActionCellState();
}

class _TPNewFindRootPageOtherActionCellState
    extends State<TPNewFindRootPageOtherActionCell> {
  List iconList = [0xe641, 0xe672, 0xe8ac, 0xe665, 0xe60e];
  List titleList = [
    I18n.of(navigatorKey.currentContext).collectionMethod,
    I18n.of(navigatorKey.currentContext).tldExchangeDescription,
    I18n.of(navigatorKey.currentContext).feedBack,
    I18n.of(navigatorKey.currentContext).aboutUS,
    I18n.of(navigatorKey.currentContext).userAgreement
  ];
  List subTitleList = [
    '选择收款方式',
    'TP兑换详细说明',
    '反馈问题意见',
    '版本更新',
    '用户须知协议'
  ];

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(40)),
      child: Container(
        height: ScreenUtil().setHeight(90) * 3 + ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
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
        child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: new NeverScrollableScrollPhysics(), //增加
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width -
                        ScreenUtil().setWidth(120)) /
                    2 /
                    ScreenUtil().setHeight(100),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0),
            itemCount: iconList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    widget.didClickItemCallBack(index);
                  },
                  child: TPNewFindRootPageOtherGridCell(
                    style: index % 2 > 0 ? 0 : 1,
                    iconNum: iconList[index],
                    title: titleList[index],
                    subTitle: subTitleList[index],
                    // isLastItem: index == iconList.length - 1,
                  ));
            }),
      ),
    );
  }
}
