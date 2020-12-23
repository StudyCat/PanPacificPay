import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TPPurseFirstPageHeaderPainter extends CustomPainter {

  String mouneyStr;

  TPPurseFirstPageHeaderPainter({Key key,this.mouneyStr});

  @override
  void paint(Canvas canvas, Size size) {

    Rect bigRect = Rect.fromCircle(
      center : Offset(size.width / 2, size.height),
      radius : (size.width - ScreenUtil().setWidth(132)) / 2
    );

    Paint bigCirclePaint = Paint(); 
    bigCirclePaint.color = Colors.white;
    bigCirclePaint.strokeWidth  = ScreenUtil().setHeight(4);
    bigCirclePaint.strokeCap = StrokeCap.round;
    bigCirclePaint.style =  PaintingStyle.stroke;
    canvas.drawArc(bigRect, -pi, pi, false, bigCirclePaint);


    Rect smallRect = Rect.fromCircle(
      center : Offset(size.width / 2, size.height),
      radius : (size.width - ScreenUtil().setWidth(200)) / 2
    );

    Paint smallPaint = Paint(); 
    smallPaint.color = Colors.white;
    smallPaint.strokeCap = StrokeCap.round;
    smallPaint.strokeWidth  = ScreenUtil().setHeight(10);
    smallPaint.style =  PaintingStyle.stroke;
    canvas.drawArc(smallRect, -pi, pi, false, smallPaint);  
    

    TextPainter centerTitlePainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '总资产（TP）',
            style:
                TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28))),
        textDirection: TextDirection.ltr);

    centerTitlePainter.layout(minWidth: 100);
    centerTitlePainter.paint(
        canvas,
        Offset((size.width - centerTitlePainter.width) / 2,
            size.height - 75));

     TextPainter moneyPainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: this.mouneyStr,
            style:
                TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(48))),
        textDirection: TextDirection.ltr);

    moneyPainter.layout(minWidth: (size.width - ScreenUtil().setWidth(250)));
    moneyPainter.paint(
        canvas,
        Offset((size.width - moneyPainter.width) / 2,
            size.height - 50));

     TextPainter ratePainter  = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '1.00TP = 1.00USD',
            style:
                TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28))),
        textDirection: TextDirection.ltr);

    ratePainter.layout(minWidth: 100);
    ratePainter.paint(
        canvas,
        Offset((size.width - ratePainter.width) / 2,
            size.height- ScreenUtil().setSp(28)));
  }

  @override
  bool shouldRepaint(TPPurseFirstPageHeaderPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TPPurseFirstPageHeaderPainter oldDelegate) => false;
} 