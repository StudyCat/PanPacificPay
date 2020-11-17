import 'dart:typed_data';
import 'dart:ui';

import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TPDetailRedEnvelopeQRCodeCell extends StatefulWidget {
  TPDetailRedEnvelopeQRCodeCell({Key key,this.detailRedEnvelopeModel}) : super(key: key);

  final TPDetailRedEnvelopeModel detailRedEnvelopeModel;

  @override
  _TPDetailRedEnvelopeQRCodeCellState createState() => _TPDetailRedEnvelopeQRCodeCellState();
}

class _TPDetailRedEnvelopeQRCodeCellState extends State<TPDetailRedEnvelopeQRCodeCell> {

  GlobalKey repainKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - ScreenUtil().setWidth(30);
    double height = width / 965 * 1170;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(16),bottom: ScreenUtil().setHeight(2)),
      child: Column(
        children: <Widget>[
          Text(I18n.of(context).tldPromotionRedEnvelopeQRCode,style: TextStyle(fontSize:ScreenUtil().setSp(32),fontWeight:FontWeight.bold,color:Color.fromARGB(255, 51, 51, 51)),),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
            child:  RepaintBoundary(
              key: repainKey,
              child: Stack(
              children : <Widget>[
                Container(
                  width : width,
                  height: width / 965 * 1170,
                  child: Image.asset(widget.detailRedEnvelopeModel.type == 1 ? 'assetss/images/red_denvelope_qrcode.png' : 'assetss/images/promotion_red_envelope_qrcode.png',fit: BoxFit.fill,),
                ),
                Container(
                  width : width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top : height / 15),
                        child: Container(
                          width : width,
                          child : Text('${widget.detailRedEnvelopeModel.tldCount} TP',overflow: TextOverflow.ellipsis,softWrap : true,style:TextStyle(fontSize : ScreenUtil().setSp(40),color : Color.fromARGB(255, 253, 239, 85)),textAlign: TextAlign.center,)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top : widget.detailRedEnvelopeModel.type == 1 ? height / 4 : height / 4.3),
                        child: Container( width : width / 345 * 205,height: width / 345 * 205,child: QrImage(data: widget.detailRedEnvelopeModel.qrCode),),
                      )
                    ],
                  ),
                )               
              ]
            ),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: CupertinoButton(child: Text(I18n.of(context).saveQRCodeCapture,style: TextStyle(fontSize:ScreenUtil().setSp(28),color : Theme.of(context).hintColor),), onPressed: ()async {
              Uint8List imageFile = await _capturePng();
              _saveQrCodeImage(imageFile);
            })
            ),
        ],
      ),
    );
  }

   Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          repainKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format:  ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;//这个对象就是图片数据
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future _saveQrCodeImage(Uint8List bytes) async{
    // Map<PermissionStatusGetters>
    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      ].request();
      return;
    }else if(status == PermissionStatus.permanentlyDenied){
      Fluttertoast.showToast(msg: I18n.of(navigatorKey.currentContext).PleaseTurnOnTheStoragePermissions);
      return;
    }
    var result = await ImageGallerySaver.saveImage(bytes);
    if (result != null){
      Fluttertoast.showToast(msg: '保存二维码成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }else{
      Fluttertoast.showToast(msg: '保存二维码失败',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }
  }
   
}