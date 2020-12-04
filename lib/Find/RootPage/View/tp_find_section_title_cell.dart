import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tp_find_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPFindSectionTitleCell extends StatefulWidget {
  TPFindSectionTitleCell({Key key,this.uiModel,this.didClickItemCallBack}) : super(key: key);

    final TPFindRootCellUIModel uiModel;

    final Function(TPFindRootCellUIItemModel) didClickItemCallBack; 

  @override
  _TPFindSectionTitleCellState createState() => _TPFindSectionTitleCellState();
}

class _TPFindSectionTitleCellState extends State<TPFindSectionTitleCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(8),right: ScreenUtil().setWidth(30)),
      child:  Column(
        children: <Widget>[
           Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children :<Widget>[
                  RichText(
                text: TextSpan(children: <InlineSpan>[
                  WidgetSpan(
                    child: Container(
                      color: Theme.of(context).hintColor,
                      height: ScreenUtil().setHeight(28),
                      width: ScreenUtil().setWidth(6),
                    ),
                  ),
                  TextSpan(
                      text: ' ' + widget.uiModel.title,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 51, 51, 51)))
                ]),
              ),
        ]
        ),
        Offstage(
          offstage: widget.uiModel.items.length == 0,
          child: _getSectionListView(),
        )
        ],
      ),
      );
  }

  Widget _getSectionListView(){
    return Container(
      height: ScreenUtil().setHeight(96) * widget.uiModel.items.length,
      child: ListView.builder(
      physics: new NeverScrollableScrollPhysics(), //增加
      itemCount: widget.uiModel.items.length,
      itemBuilder: (BuildContext context, int index) {
      TPFindRootCellUIItemModel itemModel = widget.uiModel.items[index];
      return GestureDetector(
        onTap: (){
          widget.didClickItemCallBack(itemModel);
        },
        child: TPFindCell(itemModel: itemModel,),
      );
     },
    ),
    );
  }

}