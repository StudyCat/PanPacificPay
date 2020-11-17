import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TPPurseLevelDescPage extends StatefulWidget {
  TPPurseLevelDescPage({Key key}) : super(key: key);

  @override
  _TPPurseLevelDescPageState createState() => _TPPurseLevelDescPageState();
}

class _TPPurseLevelDescPageState extends State<TPPurseLevelDescPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_level_page',
        transitionBetweenRoutes: false,
        middle: Text('钱包等级说明'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: WebView(
        initialUrl : 'http://oss.thyc.com/2020/07/10/f09bd30d4750429c9d3732fe8fa8c885.html'
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}