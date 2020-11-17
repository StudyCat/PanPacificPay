import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPVerifyWordGridView extends StatefulWidget {
  TPVerifyWordGridView({Key key,this.currentedIndex,this.words,this.didClickItem}) : super(key: key);

  final int currentedIndex;
  final List words;
  final ValueChanged<int> didClickItem;
  @override
  _TPVerifyWordGridViewState createState() => _TPVerifyWordGridViewState();
}

class _TPVerifyWordGridViewState extends State<TPVerifyWordGridView> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top : ScreenUtil().setWidth(40)),
      child: Container(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(28),right : ScreenUtil().setWidth(28)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2,mainAxisSpacing: ScreenUtil().setHeight(20),crossAxisSpacing: ScreenUtil().setHeight(20)),
            itemCount: 12,
            itemBuilder: (context ,index) => _getItem(context,index))
        ), 
    );
  }

  Widget _getItem(BuildContext context,int index){
    return GestureDetector(
      onTap : () => widget.didClickItem(index),
      child: ClipRRect(
       borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color: getItemBackColor(index),
          child: Center(
            child : Text(widget.words[index],style : TextStyle(fontSize:ScreenUtil().setSp(28),color : getWordColor(index)))
          ),
        )
      ),
    );
  }

  Color getItemBackColor(int index){
    if (widget.currentedIndex == null){
      return Colors.white;
    }else{
        return Colors.white;
    }
  }

  Color getWordColor(int index){
    if (widget.currentedIndex == null){
      return Color.fromARGB(255, 51, 51, 51);
    }else{
      // if (widget.currentedIndex == index){
      //   return Colors.white;
      // }else{
        return Color.fromARGB(255, 51, 51, 51);
      // }
    }
  }

}


