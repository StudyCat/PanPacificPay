import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Model/tld_user_feedback_question_type_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/UserFeedback/Page/tld_user_feedback_question_type_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import '../View/tld_user_feedback_question_desc_cell.dart';
import '../View/tld_user_feedback_pick_pic_cell.dart';
import 'package:image_picker/image_picker.dart';
import '../../../CommonWidget/tld_image_show_page.dart';

class TPUserFeedBackPage extends StatefulWidget {
  TPUserFeedBackPage({Key key}) : super(key: key);

  @override
  _TPUserFeedBackPageState createState() => _TPUserFeedBackPageState();
}

class _TPUserFeedBackPageState extends State<TPUserFeedBackPage> {
  List titles = [
    I18n.of(navigatorKey.currentContext).salutation,
    I18n.of(navigatorKey.currentContext).cellPhoneNumber,
    I18n.of(navigatorKey.currentContext).email,
    I18n.of(navigatorKey.currentContext).questionType,
    I18n.of(navigatorKey.currentContext).questionSpecificDescription,
    I18n.of(navigatorKey.currentContext).captureUpload,
  ];

  List placeholders = [
    I18n.of(navigatorKey.currentContext).pleaseEnterYourSalutation,
    I18n.of(navigatorKey.currentContext).pleaseEnterYourCellPhoneNumber,
    I18n.of(navigatorKey.currentContext).PleaseEnterYourEmail,
    I18n.of(navigatorKey.currentContext).pleaseChooseQuestionType,
    I18n.of(navigatorKey.currentContext).pleaseDescribeSpecificQuestion
  ];

  PageController _pageController;

  TPUserFeedBackPramatersModel _pramatersModel;

  TPUserFeedBackModelManager _manager;

  bool _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();

    _manager = TPUserFeedBackModelManager();

    _pramatersModel = TPUserFeedBackPramatersModel();

    _loading = false;
  }

  void _sendUserFeedBackQuestion(){
    if (_pramatersModel.nickname.length == 0){
      Fluttertoast.showToast(msg: '请填写您的称呼，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.tel.length == 0){
      Fluttertoast.showToast(msg: '请填写您的手机号，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.email.length == 0){
      Fluttertoast.showToast(msg: '请填写您的电子邮箱地址，便于我们联系您',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.questionType == null){
      Fluttertoast.showToast(msg: '请选择问题类型',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    if (_pramatersModel.questionDesc.length == 0){
      Fluttertoast.showToast(msg: '请填写问题描述',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.sendFeedBack(_pramatersModel, (){
      if (mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(msg: '反馈成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TPError error){
      if (mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'user_feedback_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).feedBack),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          if (index < 3) {
            return _getPadding(TPClipTitleInputCell(
              placeholder: placeholders[index],
              title: titles[index],
              titleFontSize: ScreenUtil().setSp(28),
              textFieldEditingCallBack: (String text){
                if (index == 0){
                  _pramatersModel.nickname = text;
                }else if(index == 1){
                  _pramatersModel.tel = text;
                }else if (index == 2){
                  _pramatersModel.email = text;
                }
              },
            ));
          } else if (index == 3){
            String content = _pramatersModel.questionType == null ? I18n.of(context).pleaseChooseQuestionType : _pramatersModel.questionType.typeName;
            return GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => TPUserFeedbackQuestionTypePage(didChooseQuestionTypeCallBack: (TPUserFeedbackQuestionTypeModel questionTypeModel){
                setState(() {
                  _pramatersModel.questionType = questionTypeModel;
                });
              },))),
              child: _getPadding(_getQuestionTypeCell(titles[index],content)),
              );
          }else if(index == 4){
            return _getPadding(TPUserFeedbackQuestionDescCell(title: titles[index],placeholder: placeholders[index],stringDidChangeCallBack: (String text){
              _pramatersModel.questionDesc = text;
            },));
          }else if (index == 5){
            return _getPadding(TPUserFeedbackPickPicCell(title: titles[index],images: _pramatersModel.imageFileList,didClickCallBack: (){
              showCupertinoModalPopup(context: context,builder : (BuildContext context){
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoButton(child: Text('拍摄'), onPressed: (){
                          _takePhoto();
                          Navigator.of(context).pop();
                        }),
                        CupertinoButton(child: Text('从相册选择'), onPressed: (){
                          _openGallery();
                          Navigator.of(context).pop();
                        }),
                      ],
                      cancelButton: CupertinoButton(child: Text('取消'), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    );
                  });
            },
            didClickImageCallBack: (int index){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TPImageShowPage(images: _pramatersModel.imageFileList,pageController: _pageController,index: index,heroTag: 'user_feedback',isShowDelete: true,deleteCallBack: (int index){
                setState(() {
                  _pramatersModel.imageFileList.removeAt(index);
                });
              },)));
            },
            ));
          }else {
            return Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(40),
                  left: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(100)),
              height: ScreenUtil().setHeight(80),
              width: size.width - ScreenUtil().setWidth(200),
              child: CupertinoButton(
                  child: Text(
                    I18n.of(context).submitFeedback,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28), color: Colors.white),
                  ),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _sendUserFeedBackQuestion();
                  }),
            );
          }
        });
  }

  Widget _getPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(2)),
      child: child,
    );
  }

  Widget _getQuestionTypeCell(String title, String content) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(content,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 153, 153, 153))),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              )
            ]),
      ),
    );
  }

   /*拍照*/
  void _takePhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted || status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
      _pramatersModel.imageFileList.add(image);
    });
    }
  }

  /*相册*/
void  _openGallery() async {
  var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery); 
    if (image != null) {
     setState(() {
      _pramatersModel.imageFileList.add(image);
    }); 
    }
  }

}
