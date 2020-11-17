import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TPCommonCellType {
  normal, // 两侧文字式样
  normalArrow, //带箭头文字式样
}

Widget getCommonCell(BuildContext context,TPCommonCellType type,String title,TextStyle titleStyle,String content,TextStyle contentStyle) {
  if (type == TPCommonCellType.normal){
    return Container(
    height: ScreenUtil().setHeight(44),
    child: ListTile(
      leading: Text(
        title,
        style: titleStyle,
      ),
      trailing:  Text(
              content,
              style: contentStyle,
            )
    ),
  );
  }else{
    return Container(
    height: ScreenUtil().setHeight(44),
    child: ListTile(
      leading: Text(
        title,
        style: titleStyle,
      ),
      trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  content,
                  style: contentStyle,
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
    ),
  );
  }
}
