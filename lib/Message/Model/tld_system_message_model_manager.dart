import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

class TPSystemMessageModelManager{
    deleteSystemMessage(String id,Function success)async {
      await TPNewIMManager().deleteSystemMessage(id);
      success();
    }

    getSystemMessageList(int page,Function(List) success) async{
      TPNewIMManager manager = TPNewIMManager();
      await manager.getConversation('TPSystem');
      manager.getSystemMessageList(page, success);
    }

}