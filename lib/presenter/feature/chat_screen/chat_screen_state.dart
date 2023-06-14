import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:quiver/collection.dart';

class ChatScreenState {
  TreeSet<Chat> chatTreeSet = TreeSet<Chat>(comparator: (a, b) => b.createdAtTs.compareTo(a.createdAtTs));
  ChatScreenState(List<Chat> chats) {
    chatTreeSet.addAll(chats);
  }
}
