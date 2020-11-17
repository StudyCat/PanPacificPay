import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TPUserAgreementPage extends StatefulWidget {
  TPUserAgreementPage({Key key}) : super(key: key);

  @override
  _TPUserAgreementPageState createState() => _TPUserAgreementPageState();
}

class _TPUserAgreementPageState extends State<TPUserAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'user_agreement_page',
        transitionBetweenRoutes: false,
        middle: Text('用户协议'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: WebView(
        initialUrl : 'http://128.199.126.189:8080/tld-wallet-agreement.html'
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}