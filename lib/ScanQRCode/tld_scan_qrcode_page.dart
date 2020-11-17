import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';


class TPScanQrCodePage extends StatefulWidget {
  TPScanQrCodePage({Key key,this.scanCallBack}) : super(key: key);

  final Function(String) scanCallBack;

  @override
  _TPScanQrCodePageState createState() => _TPScanQrCodePageState();
}

class _TPScanQrCodePageState extends State<TPScanQrCodePage> {

  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'qr_scan_page',
        transitionBetweenRoutes: false,
        middle: Text('扫一扫'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: QrcodeReaderView(key: qrViewKey, onScan: (String result){
        Navigator.of(context).pop();
        widget.scanCallBack(result);
      }),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

}