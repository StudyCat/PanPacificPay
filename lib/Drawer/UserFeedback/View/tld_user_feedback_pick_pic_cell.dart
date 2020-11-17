import 'package:dragon_sword_purse/Message/Model/tld_just_notice_vote_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TPUserFeedbackPickPicCell extends StatefulWidget {
  TPUserFeedbackPickPicCell({Key key, this.title, this.images,this.didClickCallBack,this.didClickImageCallBack,this.subTitle})
      : super(key: key);

  final String title;

  final String subTitle;

  final List images;
  
  final Function didClickCallBack;

  final ValueChanged<int> didClickImageCallBack;

  @override
  _TPUserFeedbackPickPicCellState createState() =>
      _TPUserFeedbackPickPicCellState();
}

class _TPUserFeedbackPickPicCellState
    extends State<TPUserFeedbackPickPicCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num singleHeight = (size.width - ScreenUtil().setWidth(120)) / 3;
    num height = singleHeight + ScreenUtil().setHeight(100);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: RichText(
                  text: TextSpan(
                    text : widget.title,
                    style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),
                    children: <InlineSpan>[
                      TextSpan(
                        text : widget.subTitle == null ? '' : widget.subTitle,
                        style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153))
                      )
                    ],
                  ),
                )
              ),
                Container(
                      height: height,
                      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: ScreenUtil().setWidth(10),
                            mainAxisSpacing: ScreenUtil().setHeight(10)),
                        itemCount: widget.images.length < 3 ? widget.images.length + 1 : 3,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == widget.images.length) {
                            return CupertinoButton(
                              padding: EdgeInsets.all(0),
                                color: Color.fromARGB(255, 242, 242, 242),
                                child: Center(
                                  child:  Icon(
                                    IconData(0xe623,
                                        fontFamily: 'appIconFonts'),
                                    size: ScreenUtil().setWidth(60),
                                    color: Color.fromARGB(255, 153, 153, 153),
                                  ),
                                ),
                                onPressed: () {
                                  // if (widget.images.length < 2) {
                                      widget.didClickCallBack();
                                  // }
                                });
                          } else {
                            return GestureDetector(
                              onTap :() => widget.didClickImageCallBack(index),
                              child : Image.file(widget.images[index],fit : BoxFit.fill)
                            );
                          }
                        }),
                    )
            ]),
      ),
    );
  }
}
