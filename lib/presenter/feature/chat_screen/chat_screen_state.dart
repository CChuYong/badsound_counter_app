import 'package:badsound_counter_app/core/api/model/me_response.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/model/violent.dart';
import 'package:quiver/collection.dart';

class ChatScreenState {
  User? speaker;
  TreeSet<Violent> violentSet = TreeSet<Violent>(
      comparator: (a, b) => b.price.compareTo(a.price)
  );
  TreeSet<Chat> chatTreeSet = TreeSet<Chat>(
      comparator: (a, b) => b.createdAtTs.compareTo(a.createdAtTs));

  ChatScreenState(List<Chat> chats, this.speaker) {
    chatTreeSet.addAll(chats);
  }
}
