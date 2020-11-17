import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPAcceptanceScanCell extends StatefulWidget {
  TPAcceptanceScanCell({Key key,this.title,this.placeholder,this.didClickScanButtonCallBack,this.inviteController,this.textDidChangeCallBack}) : super(key: key);

  final String title;

  final String placeholder;

  final Function didClickScanButtonCallBack;

  final TextEditingController inviteController;

  final Function(String) textDidChangeCallBack;

  @override
  _TPAcceptanceScanCellState createState() => _TPAcceptanceScanCellState();
}

class _TPAcceptanceScanCellState extends State<TPAcceptanceScanCell> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize:  ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: CupertinoTextField(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20)),
                controller: widget.inviteController,
                placeholder: widget.placeholder,
                textAlign: TextAlign.right,
                onChanged: (String text){
                  widget.textDidChangeCallBack(text);
                },
                placeholderStyle: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24)),
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(10),right:0,top: 0,bottom: 0),
                child: Container(
                 width: ScreenUtil().setWidth(100),
                 height: ScreenUtil().setHeight(60),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Icon(IconData(0xe606,fontFamily : 'appIconFonts'),color: Theme.of(context).primaryColor,),
                   onPressed: widget.didClickScanButtonCallBack),
               ),
                )
            ]),
      ),
    );
  }
}