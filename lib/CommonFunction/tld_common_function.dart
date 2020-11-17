import 'dart:isolate';
import 'dart:typed_data';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CommonWidget/tld_data_manager.dart';
import '../CommonWidget/tld_alert_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:date_format/date_format.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';



void jugeHavePassword(BuildContext context,Function passwordRightCallBack,TPCreatePursePageType type,Function setPasswordSuccessCallBack) async{
  String password = await TPDataManager.instance.getPassword();
   if(password == null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TPCreatePursePage(type: type,setPasswordSuccessCallBack: setPasswordSuccessCallBack,)));
    }else{
      String password;
      showDialog(context: context,builder: (BuildContext context){
        return TPAlertView(placeHolder: I18n.of(navigatorKey.currentContext).pleaseEnterPassword,isNeedSecretShow: true,title:I18n.of(navigatorKey.currentContext).enterPassword,type : TPAlertViewType.input,textEditingCallBack: (String text){
          password = text;
        },didClickSureBtn: (){
          if (password == TPDataManager.instance.password) {
            passwordRightCallBack();
          } else {
            Fluttertoast.showToast(
                        msg: "安全密码错误",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
          }
        },);
      });
    }
}

void thirdAppTransferAccount(Map queryParameter,Function success,Function(TPError) failure){
  String fromAddress = queryParameter['fromAddress'];
  String toAddress = queryParameter['toAddress'];
  if (fromAddress != null && toAddress != null){
    List purseList = TPDataManager.instance.purseList;
    List addressList = [];
    for (TPWallet wallet in purseList) {
      addressList.add(wallet.address);
    }
    if (addressList.contains(fromAddress)){
      success();
    }else{
      TPError error = TPError(801,'尚未拥有转账钱包');
      failure(error);
    }
  }else{
    TPError error = TPError(800,'地址不能为空');
    failure(error);
  }
}

 String getMoneyStyleStr(String text) {
    try {
      if (text == null || text.isEmpty) {
        return "";
      } else {
        if (text.contains('.')){
          List stringList = text.split('.');
          String intText = stringList.first;
          String resultIntText = '';
          if (text.length <= 3) {
          resultIntText = intText;
          return resultIntText;
        } else {
          int count = ((intText.length) ~/ 3); //切割次数
          int startIndex = intText.length % 3; //开始切割的位置
          if (startIndex != 0) {
            if (count == 1) {
              resultIntText = intText.substring(0, startIndex) +
                  "," +
                  intText.substring(startIndex, intText.length);
            } else {
              resultIntText = intText.substring(0, startIndex) + ","; //第一次切割0-startIndex
              int syCount = count - 1; //剩余切割次数
              for (int i = 0; i < syCount; i++) {
                resultIntText += intText.substring(
                        startIndex + 3 * i, startIndex + (i * 3) + 3) +
                    ",";
              }
              resultIntText += intText.substring(
                  (startIndex + (syCount - 1) * 3 + 3), intText.length);
            }
          } else {
            for (int i = 0; i < count; i++) {
              if (i != count - 1) {
                resultIntText += intText.substring(3 * i, (i + 1) * 3) + ",";
              } else {
                resultIntText += intText.substring(3 * i, (i + 1) * 3);
              }
            }
          }
          return resultIntText + '.' + stringList.last;
        }
        }else{
          String temp = "";
          if (text.length <= 3) {
          temp = text;
          return temp;
        } else {
          int count = ((text.length) ~/ 3); //切割次数
          int startIndex = text.length % 3; //开始切割的位置
          if (startIndex != 0) {
            if (count == 1) {
              temp = text.substring(0, startIndex) +
                  "," +
                  text.substring(startIndex, text.length);
            } else {
              temp = text.substring(0, startIndex) + ","; //第一次切割0-startIndex
              int syCount = count - 1; //剩余切割次数
              for (int i = 0; i < syCount; i++) {
                temp += text.substring(
                        startIndex + 3 * i, startIndex + (i * 3) + 3) +
                    ",";
              }
              temp += text.substring(
                  (startIndex + (syCount - 1) * 3 + 3), text.length);
            }
          } else {
            for (int i = 0; i < count; i++) {
              if (i != count - 1) {
                temp += text.substring(3 * i, (i + 1) * 3) + ",";
              } else {
                temp += text.substring(3 * i, (i + 1) * 3);
              }
            }
          }
          return temp;
        }
      }
        }
    } catch (e) {
      print(e);
    }
  }

  String getTimeString(int date){
    return formatDate(DateTime.fromMillisecondsSinceEpoch(date),[yyyy,'.',mm,'.',dd,' ',HH,':',nn]);
  }

    //图片转base64
   Future<String> imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

 /*
  * 将Base64字符串的图片转换成图片
  */
   Uint8List base642Image(String base64Txt) {
    Uint8List decodeTxt =  convert.base64Decode(base64Txt);
    return decodeTxt;
   }
  

 