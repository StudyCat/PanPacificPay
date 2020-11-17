import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum TPWebPageType{
  billDescUrl,
  cashDescUrl,
  inviteProfitDescUrl,
  overflowProfitDescUrl,
  profitDescUrl,
  tldWalletAgreement,
  orderDescUrl,
  playDescUrl,
  transferOutUrl,
  aaaUrl,
  ylbDescUrl,
  merchantJoin,
  upgradeDesc
  }

class TPWebPage extends StatefulWidget {
  TPWebPage({Key key,this.title,this.type,this.urlStr = ''}) : super(key: key);

  final TPWebPageType type;

  final String title;

  final String urlStr;

  @override
  _TPWebPageState createState() => _TPWebPageState();
}

class _TPWebPageState extends State<TPWebPage> {

  @override
  void initState() { 
    super.initState();
    _getBaseUrl();
  }

  String _url = '';

  void _getBaseUrl(){
    TPBaseRequest request = TPBaseRequest({},'common/tldPlayDesc');
    request.postNetRequest((value) {
      String url = '';
      if (widget.type == TPWebPageType.billDescUrl) {
        url = value['billDescUrl'];
      }else if(widget.type == TPWebPageType.cashDescUrl){
        url = value['cashDescUrl'];
      }else if(widget.type == TPWebPageType.inviteProfitDescUrl){
        url = value['inviteProfitDescUrl'];
      }else if(widget.type == TPWebPageType.overflowProfitDescUrl){
        url = value['overflowProfitDescUrl'];
      }else if(widget.type == TPWebPageType.profitDescUrl){
        url = value['profitDescUrl'];
      }else if(widget.type == TPWebPageType.tldWalletAgreement){
        url = value['tldWalletAgreement'];
      }else if(widget.type == TPWebPageType.orderDescUrl){
        url = value['orderDescUrl'];
      }else if(widget.type == TPWebPageType.playDescUrl){
         url = value['playDescUrl'];
      }else if(widget.type == TPWebPageType.transferOutUrl){
        url = value['transferOutUrl'];
      }else if(widget.type == TPWebPageType.aaaUrl){
        url = value['aaaUrl'];
      }else if(widget.type == TPWebPageType.ylbDescUrl){
        url = value['ylbDescUrl'];
      }else if(widget.type == TPWebPageType.merchantJoin){
        url = value['merchantJoin'];
      }else if(widget.type == TPWebPageType.upgradeDesc){
        url = value['upgradeDesc'];
      }
      if (mounted) {
        setState(() {
          _url = url;
        });
      }
    }, (TPError error){
      
    });
  }

  @override
  Widget build(BuildContext context) {
    String urlStr = '';
    if (widget.urlStr.length > 0) {
      urlStr = widget.urlStr;
    }else{
      urlStr = _url;
    }
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'web_page',
        transitionBetweenRoutes: false,
        middle: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: urlStr.length > 0 ?  WebView(
        initialUrl : urlStr,
        javascriptMode: JavascriptMode.unrestricted,
      ) : Container(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}