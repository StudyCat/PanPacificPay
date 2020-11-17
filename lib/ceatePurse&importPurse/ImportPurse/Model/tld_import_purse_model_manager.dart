import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;


class TPImportPurseModelManager{

  void jugeMnemonicisLegal(List mnemonicList , Function(String) success, ValueChanged<int> faliure) async{
    String mnemonicString = "";
    for (String str in mnemonicList) {
      if (mnemonicString.length > 0){
        mnemonicString = mnemonicString + " " + str;
      }else{
        mnemonicString = mnemonicString + str;
      }
    }   
    if (_isMnemonic(mnemonicString)){
      
      success(mnemonicString);
    }else{
      faliure(0);
    }
  }

  bool _isMnemonic(String mnemonicString){
    bool isMnemonic = bip39.validateMnemonic(mnemonicString);
    return isMnemonic;
  }


  void jugePrivateKeyLegal(String privateKey , Function(String) success, ValueChanged<int> faliure) async{
     if (privateKey.length == 64){
        success(privateKey);
    }else{
      faliure(0);
    }
  }

}