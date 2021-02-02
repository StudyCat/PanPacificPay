import 'dart:convert';
import 'dart:typed_data';

import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid_enhanced/uuid.dart';
import 'package:web3dart/credentials.dart';
// import 'package:file_picker/file_picker.dart';

final String tableWallet = 'wallet';
final String walletId = '_id';
final String walletJson = 'walletJson';
final String walletMnemonic = 'walletMnemonic';
final String walletPrivate = 'walletPrivate';
final String walletAdress = 'walletAdress';
final String walletName = 'walletName';
final String walletType = 'walletType';

// final String tableIM = 'imtable';
// final String contentTypeIM = 'contentType';
// final String contentIM = 'content';
// final String fromIM = 'fromAddress';
// final String toIM = 'toAddress';
// final String unreadIM = 'unread';
// final String createTimeIM = 'createTime';
// final String idIM = '_id';
// final String orderNoIM = 'orderNo';
// final String messageTypeIM = 'messageType';
// final String bizAttrIM = 'bizAttr';

class TPWallet{
  int id;
  String json;
  String mnemonic;
  String privateKey;
  String address;
  String name;
  int type;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      walletJson: json,
      walletMnemonic: mnemonic,
      walletPrivate : privateKey,
      walletAdress : address,
      walletName : name,
      walletType : type
    };
    if (id != null) {
      map[walletId] = id;
    }
    return map;
  }

  TPWallet(int id, String json, String mnemonic,String privateKey,String address,String name,int type) {
    this.id = id;
    this.json = json;
    this.mnemonic = mnemonic;
    this.privateKey = privateKey;
    this.address = address;
    this.name = name;
    this.type = type;
  }

  TPWallet.fromMap(Map<String, dynamic> map) {
    id = map[walletId];
    json = map[walletJson];
    mnemonic = map[walletMnemonic];
    privateKey = map[walletPrivate];
    address = map[walletAdress];
    name = map[walletName];
    type = map[walletType];
  }
}

class TPDataBaseManager {

  // 工厂模式
  factory TPDataBaseManager() =>_getInstance();
  static TPDataBaseManager get instance => _getInstance();
  static TPDataBaseManager _instance;
  TPDataBaseManager._internal(){
    // 初始化
     
  }
  static TPDataBaseManager _getInstance() {
    if (_instance == null) {
      _instance = new TPDataBaseManager._internal();
    }
    return _instance;
  }

  Database db;
  

  openDataBase() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TPDollar.db');

    //根据数据库文件路径和数据库版本号创建数据库表
    if (db == null ||!db.isOpen){
      db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableWallet (
            $walletId INTEGER PRIMARY KEY, 
            $walletJson TEXT, 
            $walletMnemonic TEXT,
            $walletPrivate TEXT,
            $walletAdress TEXT,
            $walletName TEXT,
            $walletType INTEGER)
          ''');
    },onUpgrade: (db,oldVersion,newVersion) async{
      if (oldVersion == 1 && newVersion == 2){
        await db.execute('''
          ALTER TABLE $tableWallet 
          add column $walletType INTEGER
          ''');
      }
    });
    }
  }

  closeDataBase()async{
    if (db.isOpen){
      // await db.close();
    }
  }


  // Future insertIMDataBase(List messageList) async{
  //   for (TPMessageModel model in messageList) {
  //       if (model.contentType == 2){
  //         String filePath = await this._saveImageFileInMemory(model.content);
  //         model.content = filePath;
  //       }
  //   }
  //   for (TPMessageModel item in messageList) {
  //     item.id = await db.insert(tableIM, item.toJson()); 
  //   }
  // }

  //存储Base64图片到本地，存储本地路径
  // Future<String> _saveImageFileInMemory(String base64ImageString) async{
  //   Uint8List imageByteList = base642Image(base64ImageString);
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   String floderPath = appDocPath+"/"+"IM";
  //   var file = Directory(floderPath);
  //   try {
  //     bool exists = await file.exists();
  //     if (!exists) {
  //       await file.create();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   String filePath =  floderPath +'/'+ Uuid.randomUuid().toString() + '.png';
  //   var pngFile = File(filePath);
  //   await pngFile.writeAsBytes(imageByteList);
  //   return filePath;
  // }

// //搜索历史消息（通过orderNo为条件）
//   Future<List> searchIMDataBase(String orderNo,int page) async{
//     List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM WHERE $orderNoIM = \"$orderNo\" AND $messageTypeIM = 2 ORDER BY _id DESC LIMIT $page,10');
//      if (maps == null || maps.length == 0) {
//       return [];
//     }

//     List<TPMessageModel> messages = [];
//     for (int i = 0; i < maps.length; i++) {
//       messages.insert(0, TPMessageModel.fromJson(maps[i]));
//     }
//     return messages;
//   }

//   Future<List> searchSystemIMDataBase(int page) async{
//     int pageLimit = page * 10;
//     List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM WHERE  $messageTypeIM = 1 ORDER BY _id ASC LIMIT $pageLimit,10');
//      if (maps == null || maps.length == 0) {
//       return [];
//     }

//     List<TPMessageModel> messages = [];
//     for (int i = 0; i < maps.length; i++) {
//       messages.insert(0, TPMessageModel.fromJson(maps[i]));
//     }
//     return messages;
//   }

  // //进入到聊天界面后把所有未读消息置位已读
  // updateUnreadMessageType(String orderNo) async{
  //   await db.rawUpdate('UPDATE  $tableIM SET $unreadIM = 0 WHERE $orderNoIM = \"$orderNo\" AND $messageTypeIM = 2');
  // }

  // //进入系统消息界面后吧所有系统消息置位已读
  // updateUnreadSystemMessageType() async{
  //   await db.rawUpdate('UPDATE  $tableIM SET $unreadIM = 0 WHERE  $messageTypeIM = 1');
  // }


// //搜寻所有未读消息
//   Future<List> searchUnReadMessageList()async{
//     if (!db.isOpen){
//       await openDataBase();
//     }
//      List maps = await db.rawQuery('SELECT * FROM $tableIM WHERE $unreadIM = 1');
//      if (maps == null || maps.length == 0) {
//       return [];
//     }

  //   List<TPMessageModel> messages = [];
  //   for (int i = 0; i < maps.length; i++) {
  //     messages.insert(0, TPMessageModel.fromJson(maps[i]));
  //   }
  //   return messages;
  // }

  // //搜索数据库中以orderNo分组的IM聊天
  // Future<List> searchOrderNoChatGroup() async{
  //   List<Map> maps = await db.rawQuery('SELECT * FROM $tableIM as m1 WHERE m1._id IN(SELECT max(_id) from $tableIM GROUP BY $orderNoIM) AND $messageTypeIM = 2 GROUP BY m1.$orderNoIM');
  //    if (maps == null || maps.length == 0) {
  //     return [];
  //   }

  //   List<TPMessageModel> messages = [];
  //   for (int i = 0; i < maps.length; i++) {
  //     messages.insert(0, TPMessageModel.fromJson(maps[i]));
  //   }
  //   return messages;
  // }
  
  // //搜索数据库中以fromAdress分组IM的分组
  // Future<List> searchFromAddressChatGroup()async{
  //   List purseList = TPDataManager.instance.purseList;
  //   String sqlPurseStr = '';
  //   for (int i = 0; i < purseList.length ; i++) {
  //     TPWallet wallet = purseList[i];
  //   if (i == 0){
  //       sqlPurseStr = '\"' +wallet.address + '\"';
  //     }else{
  //       sqlPurseStr = sqlPurseStr +','+ '\"'+wallet.address+'\"';
  //     }
  //   }

  //   List<Map> maps = await db.rawQuery('SELECT	m1.* FROM $tableIM as m1  WHERE m1._id in ( SELECT max(_id) from $tableIM GROUP BY $fromIM) AND m1.$fromIM IN ($sqlPurseStr) GROUP BY m1.$toIM');
  //    if (maps == null || maps.length == 0) {
  //     return [];
  //   }

  //   List<TPMessageModel> messages = [];
  //   for (int i = 0; i < maps.length; i++) {
  //     messages.insert(0, TPMessageModel.fromJson(maps[i]));
  //   }
  //   return messages;
  // }

  // //删除投票系统消息
  // deleteVoteSystemMessage(int appealId) async{
  //   Map bizAttrMap = {'appealId':appealId};
  //   String bizStr = jsonEncode(bizAttrMap);
  //   db.rawDelete('DELETE FROM $tableIM WHERE $messageTypeIM = 1 AND $contentTypeIM = 106 AND $bizAttrIM = \'$bizStr\''); 
  // }

  // deleteSystemMessage(int id) async{
  //   db.rawDelete('DELETE FROM $tableIM WHERE _id = $id');
  // }

  // //搜索数据库中以toAdress分组IM的分组
  // Future<List> searchToAddressChatGroup()async{
  //   List purseList = TPDataManager.instance.purseList;
  //   String sqlPurseStr = '';
  //   for (int i = 0; i < purseList.length ; i++) {
  //     TPWallet wallet = purseList[i];
  //     if (i == 0){
  //       sqlPurseStr = '\"' +wallet.address + '\"';
  //     }else{
  //       sqlPurseStr = sqlPurseStr +','+ '\"'+wallet.address+'\"';
  //     }
  //   }

  //   List<Map> maps = await db.rawQuery('SELECT m1.* FROM $tableIM as m1 WHERE  m1.$toIM IN ($sqlPurseStr) AND  m1._id in ( SELECT max(_id) from $tableIM  GROUP BY $fromIM)  GROUP BY m1.$fromIM');
  //    if (maps == null || maps.length == 0) {
  //     return [];
  //   }

  //   List<TPMessageModel> messages = [];
  //   for (int i = 0; i < maps.length; i++) {
  //     messages.insert(0, TPMessageModel.fromJson(maps[i]));
  //   }
  //   return messages;
  // }

  Future<TPWallet> insertDataBase(TPWallet wallet) async {
    wallet.id = await db.insert(tableWallet, wallet.toMap());
    return wallet;
  }

   deleteDataBase(TPWallet wallet) async{
     await db.delete(tableWallet,where:'$walletId = ${wallet.id}');
  }

  changeWalletName(TPWallet wallet) async{
    await db.update(tableWallet, wallet.toMap(),where: '$walletId = ${wallet.id}');
  }

  Future<List> searchAllWallet() async{
    List<Map> maps = await db.query(tableWallet,columns: [
      walletId,
      walletJson,
      walletMnemonic,
      walletPrivate,
      walletAdress,
      walletName,
      walletType
    ]);

     if (maps == null || maps.length == 0) {
      return null;
    }

    List<TPWallet> tldWallet = [];
    for (int i = 0; i < maps.length; i++) {
      tldWallet.add(TPWallet.fromMap(maps[i]));
    }
    return tldWallet;
  }

  
  }
