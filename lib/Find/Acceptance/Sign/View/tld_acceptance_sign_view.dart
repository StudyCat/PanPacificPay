import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_day_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

class TPAcceptanceSignView extends StatefulWidget {
  TPAcceptanceSignView({Key key, this.userInfoModel,this.didClickItemToSignCallBack}) : super(key: key);

  final TPAAAUserInfo userInfoModel;

  final Function didClickItemToSignCallBack;

  @override
  _TPAcceptanceSignViewState createState() => _TPAcceptanceSignViewState();
}

class _TPAcceptanceSignViewState extends State<TPAcceptanceSignView> {
  CalendarController _calendarController;

  ValueNotifier<String> text;

  DateModel _todayDateModel;

  String _amount = '签到累计获得：0.0积分';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _getController();

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    _calendarController.addMonthChangeListener((year, month) {
      text.value = "$year年$month月";
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userInfoModel != null){
      _todayDateModel = DateModel.fromDateTime(DateTime.fromMillisecondsSinceEpoch(widget.userInfoModel.curTime));
      _calendarController.changeExtraData({});
    }
    return Column(children: <Widget>[_getDateHeaderView(), _getDateView(),]);
  }


  void _getController() {
    _calendarController = CalendarController(showMode: 1, offset: 0);
  }

  Widget _getDateView() {
    double size =
        (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 7;
    return CalendarViewWidget(
      itemSize: size,
      calendarController: _calendarController,
      weekBarItemWidgetBuilder: () {
        return Container();
      },
      dayWidgetBuilder: (DateModel model) {
        TPAcceptanceSignDayViewType type;
        bool enable = false;
        if (widget.userInfoModel != null) {
          if (model.isBefore(_todayDateModel)) {
            if (_isSignDay(model, _todayDateModel)){
              type = TPAcceptanceSignDayViewType.signComplete;
            }else{
              type = TPAcceptanceSignDayViewType.signFail;
            }
          } else if (model.isSameWith(_todayDateModel)) {
            if (_isSignDay(model, _todayDateModel)) {
              type = TPAcceptanceSignDayViewType.signToday;
            } else {
              type = TPAcceptanceSignDayViewType.signWait;
              enable = true;
            }
          } else if (model.isAfter(_todayDateModel)) {
            type = TPAcceptanceSignDayViewType.signFail;
          }
        } else {
          type = TPAcceptanceSignDayViewType.signFail;
        }
        return GestureDetector(
          onTap:  (){
            if (enable){
              widget.didClickItemToSignCallBack();
            }
          },
          child: TPAcceptanceSignDayView(type: type, day: model.day),
        );
      },
    );
  }


  bool _isSignDay(DateModel model, DateModel todayDateModel) {
    List dayList = [];
    for (TPSignModel item in widget.userInfoModel.signList) {
      if (int.parse(item.year) == model.year &&
          int.parse(item.month) == model.month) {
        dayList = item.dayList;
        break;
      }
    }
    for (int item in dayList) {
        if (item == model.day) {
          return true;
        }
    }
    return false;
  }

  Widget _getDateHeaderView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              _calendarController.moveToPreviousMonth();
            }),
        ValueListenableBuilder(
            valueListenable: text,
            builder: (context, value, child) {
              return new Text(
                text.value,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    color: Theme.of(context).hintColor),
              );
            }),
        new IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              _calendarController.moveToNextMonth();
            }),
      ],
    );
  }
}
