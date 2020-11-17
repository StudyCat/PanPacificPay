
// import 'package:web3dart/credentials.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import '../../../dataBase/tld_database_manager.dart';
import 'dart:typed_data';
import 'package:web3dart/crypto.dart';
import '../../../Base/tld_base_request.dart';

class TPCreatePurseModelManager {

  void createSafeSecretPasswordRegisterUser(String password,Function(String) success,Function(TPError) failure){
    String registerId = TPDataManager.instance.registrationID;
    TPBaseRequest request = TPBaseRequest({'registrationId': registerId,'password':password},'wallet/registerUser');
    request.postNetRequest((value) async{
      Map data = value;
      String token = data['token'];
      String username = data['username'];
      SharedPreferences perference = await SharedPreferences.getInstance();
      perference.setString('userToken',token);
      TPDataManager.instance.userToken = token;
      perference.setString('username', username);
      
      success(username);
    }, (error)=> failure(error));
  }

  Future createPurse(String password, Function(TPWallet) success,Function(TPError) failure) async {
    TPWallet wallet = await _getWalletWithNoting();
    createServiceWallet(wallet, (TPWallet wallet)async{
      await _insertDB(wallet);
      success(wallet);
    }, (error) => failure(error));
  }

  Future importPurseWithWord(String mnemonicString,Function(TPWallet) success,Function(TPError) failure) async {
    TPWallet wallet = await _getWalletWithWord(mnemonicString);
    if (await _isHaveSamePurse(wallet)){
      failure(TPError(800,'已拥有该钱包'));
    }else{
      insertServiceWallet(wallet, (TPWallet wallet)async{
        await _insertDB(wallet);
        success(wallet);
      }, (error) => failure(error));
    }
  }

   Future importPurseWithPrivateKey(String privateKey,Function(TPWallet) success,Function(TPError) failure) async {
    TPWallet wallet = await _getWalletWithPrivateKey(privateKey);
     if (await _isHaveSamePurse(wallet)){
       failure(TPError(800,'已拥有该钱包'));
    }else{
      insertServiceWallet(wallet, (TPWallet wallet)async{
        await _insertDB(wallet);
        success(wallet);
      }, (error) => failure(error));
    }
  }



  Future _insertDB(TPWallet tldWallet) async {
    TPDataBaseManager manager = TPDataBaseManager();
    await manager.openDataBase();
    await manager.insertDataBase(tldWallet);
    await manager.closeDataBase();
  }

  Future<TPWallet> _getWalletWithNoting() async{
    String randomMnemonic =  bip39.generateMnemonic();
    String seed = bip39.mnemonicToSeedHex(randomMnemonic);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
    return await _getWallet(privateKey,randomMnemonic,0);
  }

  Future<TPWallet> _getWallet(String privateKey,String mnemonic,int type) async{
    EthPrivateKey private = EthPrivateKey.fromHex(privateKey);
    EthereumAddress address = await private.extractAddress();
    Uint8List addressList = address.addressBytes;
    String addressHex = bytesToHex(
                      addressList,                           //地址字节数组
                      include0x:true,                    //包含0x前缀
                      forcePadLength:40                  //补齐到40字节
                    );
    Random rng = Random.secure();
    Wallet wallet = Wallet.createNew(private, '', rng);
    String walletJson = wallet.toJson();
    Map walletMap = jsonDecode(walletJson);
    String walletId = walletMap['id'];
    String walletName = 'TP钱包' + walletId.split('-').first;
    TPWallet tldWallet = TPWallet(null, walletJson, mnemonic,privateKey,addressHex,walletName,type);
    return tldWallet;
  }

  Future<TPWallet> _getWalletWithWord(String mnemonicString) async{
    String seed = bip39.mnemonicToSeedHex(mnemonicString);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    String privateKey = HEX.encode(master.key);
    return await _getWallet(privateKey, mnemonicString,1);
  }

    Future<TPWallet> _getWalletWithPrivateKey(String privateKey) async{
    return await _getWallet(privateKey, '',1);
  }


  Future<bool> _isHaveSamePurse(TPWallet wallet) async{
     List purses = await _getAllPurse();

    if (purses != null){
      List wallletIds = [];
     for (TPWallet item in purses) {
       wallletIds.add(item.address);
     }
      return wallletIds.contains(wallet.address);
    }else{
      return false;
    }
  }

  Future<List> _getAllPurse() async{
    TPDataBaseManager dataBase = TPDataBaseManager();
    await dataBase.openDataBase();
    List purses = await dataBase.searchAllWallet();
    await dataBase.closeDataBase();
    return purses;
  }

  //服务端创建钱包
  void createServiceWallet(TPWallet wallet,Function(TPWallet) success,Function(TPError) failure){
    String walletAddree = wallet.address;
    String userToken = TPDataManager.instance.userToken;
    Map pramater;
    // if (userToken.length == 0){
      pramater = {'walletAddress':walletAddree};
    // }else{
    //   pramater = {'walletAddress':walletAddree,'userToken':userToken};
    // }
    TPBaseRequest request = TPBaseRequest(pramater,'wallet/createWallet');
    request.postNetRequest((dynamic data) {
      success(wallet);
      } , (TPError error){
        failure(error);
        } );
  }

  //服务端导入钱包
  void insertServiceWallet(TPWallet wallet,Function(TPWallet) success,Function(TPError) failure){
    String walletAddree = wallet.address;
    String userToken = TPDataManager.instance.userToken;
    Map pramater;
    // if (userToken.length == 0){
      pramater = {'walletAddress':walletAddree};
    // }else{
    //   pramater = {'walletAddress':walletAddree,'userToken':userToken};
    // }
    TPBaseRequest request = TPBaseRequest(pramater,'wallet/importWallet');
    request.postNetRequest((dynamic data) {
      success(wallet);
      } , (TPError error){
        failure(error);
        } );
  }

}
