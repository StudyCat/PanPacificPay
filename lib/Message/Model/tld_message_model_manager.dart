
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';

class TPMessageModelManager{

  void searchChatGroup(Function(List) success)async{
    TPNewIMManager manager = TPNewIMManager();
    List result = await manager.getMessageConversationList();
    success(result);
  }

}