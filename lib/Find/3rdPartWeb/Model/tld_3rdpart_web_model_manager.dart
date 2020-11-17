
import 'dart:convert';
import 'dart:typed_data';

import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:web3dart/crypto.dart';

class TP3rdPartWebModelManager{
   void getRequestSign( Map pramaterMap, String walletAddress,Function success){
     _sign(walletAddress, (Map signPramaterStr,Map sign){
       pramaterMap.addEntries({'json':signPramaterStr,'sign':sign}.entries);
       success(pramaterMap);
     });
   }

   void _sign(String walletAddress,Function success){
    TPWallet wallet;
    List purseList = TPDataManager.instance.purseList;
    for (TPWallet item in purseList) { 
      if (item.address == walletAddress) {
        wallet = item;
      }
    }
    Map pramatersMap = {'walletAddress' : walletAddress};
    String pramaterStr = jsonEncode(pramatersMap);
    Uint8List privateKey = hexToBytes(wallet.privateKey);
    Uint8List messageHash = keccakUtf8(pramaterStr);
    MsgSignature signature = sign(messageHash, privateKey);
    Map signMap = {'r':signature.r.toString(),'v' : signature.v.toString(),'s':signature.s.toString()};

    success(pramatersMap,signMap);
   }

}