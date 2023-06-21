import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/model/violent.dart';
import 'package:quiver/collection.dart';

class ChatScreenState {
  User? speaker;
  TreeSet<Violent> violentSet = TreeSet<Violent>(comparator: (a, b) {
    if (a.id == b.id) return 0;
    return b.price.compareTo(a.price);
  });
  TreeSet<Chat> chatTreeSet = TreeSet<Chat>(comparator: (a, b) {
    if (a.messageId == b.messageId) return 0;
    return b.createdAtTs.compareTo(a.createdAtTs);
  });

  ChatScreenState(List<Chat> chats, this.speaker) {
    chatTreeSet.addAll(chats);
  }
}
