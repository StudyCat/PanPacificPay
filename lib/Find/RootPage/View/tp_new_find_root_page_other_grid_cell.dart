import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPNewFindRootPageOtherGridCell extends StatefulWidget {
  TPNewFindRootPageOtherGridCell(
      {Key key, this.style, this.iconNum, this.title, this.subTitle})
      : super(key: key);

  final int style;

  final int iconNum;

  final String title;

  final String subTitle;

  @override
  _TPNewFindRootPageOtherGridCellState createState() =>
      _TPNewFindRootPageOtherGridCellState();
}

class _TPNewFindRootPageOtherGridCellState
    extends State<TPNewFindRootPageOtherGridCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: widget.style == 1,
          child: VerticalDivider(
            indent: ScreenUtil().setHeight(26),
            endIndent: ScreenUtil().setHeight(26),
            width: ScreenUtil().setWidth(2),
            color: Color.fromARGB(255, 208, 208, 208),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left : MediaQuery.of(context).size.width / 375 * 36),
          child: Icon(
          IconData(widget.iconNum, fontFamily: 'appIconFonts'),
          color: Theme.of(context).primaryColor,
        ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(28)),
              ),
              Text(
                widget.title,
                style: TextStyle(
                    color: Color.fromARGB(255, 152, 152, 152),
                    fontSize: ScreenUtil().setSp(20)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
