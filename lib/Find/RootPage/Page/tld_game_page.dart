import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_ad_banner_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';



class TPGamePage extends StatefulWidget {
  TPGamePage({Key key}) : super(key: key);

  @override
  _TPGamePageState createState() => _TPGamePageState();
}

class _TPGamePageState extends State<TPGamePage> {
  List _bannerList = [];

  List _iconDataSource = [];

  TPFindRootModelManager _modelManager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager =  TPFindRootModelManager();

    _getGameInfo();
  }

  void _getGameInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getGamePageInfo((List bannerList,List gameList){
      if (mounted){
        setState(() {
          _isLoading = false;
          _bannerList.addAll(bannerList);
          _dealGameList(gameList);
        });
      }
    }, (TPError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _dealGameList(List gameList){
     List newWebList = [];
      for (TP3rdWebInfoModel item in gameList) {
        TPFindRootCellUIItemModel uiItemModel = TPFindRootCellUIItemModel(title: item.name,iconUrl: item.iconUrl,url: item.url,isNeedHideNavigation: item.isNeedHideNavigation,appType: item.appType);
        newWebList.add(uiItemModel);
      }
     TPFindRootCellUIModel findRootCellUIModel = TPFindRootCellUIModel(title: I18n.of(context).game,items: newWebList,isHaveNotice: false);
     _iconDataSource.add(findRootCellUIModel);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child:  _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'game_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).game,),
        automaticallyImplyLeading: true,
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
    );
  }

  Widget _getBodyWidget(){
     return ListView.builder(
      itemCount: _iconDataSource.length + 1,
      itemBuilder: (context,index){
        if (index == 0){
          return TPFindRootADBannerView(bannerList: _bannerList,didClickBannerViewCallBack: (TPBannerModel bannerModel){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TP3rdPartWebPage(isNeedHideNavigation: !bannerModel.isNeedNavigation,urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TPFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          return TPFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TPFindRootCellUIItemModel itemModel){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> TP3rdPartWebPage(urlStr: itemModel.url,isNeedHideNavigation: itemModel.isNeedHideNavigation,)));
          },
          didLongClickItemCallBack: (TPFindRootCellUIItemModel itemModel){

          },
          didClickQuestionItem: (){
            
          },
          );
        }
      });
  }

}