import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_grid_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPFindRootPageCell extends StatefulWidget {
  TPFindRootPageCell({Key key, this.uiModel,this.didClickItemCallBack,this.didLongClickItemCallBack,this.didClickQuestionItem}) : super(key: key);

  final TPFindRootCellUIModel uiModel;

  final Function(TPFindRootCellUIItemModel) didClickItemCallBack;

  final Function(TPFindRootCellUIItemModel) didLongClickItemCallBack;

  final Function() didClickQuestionItem;

  @override
  _TPFindRootPageCellState createState() => _TPFindRootPageCellState();
}

class _TPFindRootPageCellState extends State<TPFindRootPageCell> {
  @override
  Widget build(BuildContext context) {
    int cloumnNum = widget.uiModel.items.length ~/ 4 + (widget.uiModel.items.length % 4 > 0 ? 1 : 0);
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Offstage(
                offstage : !widget.uiModel.isHaveNotice,
                child : IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
                  widget.didClickQuestionItem();
              })
              )
                ]
              ),
              Container(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                height: ScreenUtil().setHeight(50 + 160 * cloumnNum),
                  child: GridView.builder(
                      physics: new NeverScrollableScrollPhysics(), //增加
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: ScreenUtil().setWidth(60),
                          mainAxisSpacing: ScreenUtil().setHeight(10)),
                      itemCount: widget.uiModel.items.length,
                      itemBuilder: (context, index) {
                        TPFindRootCellUIItemModel itemModel =
                            widget.uiModel.items[index];
                        return GestureDetector(
                          onTap : (){
                            widget.didClickItemCallBack(itemModel);
                          },
                          onLongPress: (){
                            widget.didLongClickItemCallBack(itemModel);
                          },
                          child : TPFindRootPageGridCell(itemUIModel: itemModel)
                        );
                      })),
            ]),
      ),
    );
  }
}
