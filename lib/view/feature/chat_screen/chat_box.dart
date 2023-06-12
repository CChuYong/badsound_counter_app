import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:flutter/cupertino.dart';

class ChatBox extends StatelessWidget {
  final Chat chat;
  ChatBox(this.chat, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(chat.senderNickname),
        Text(chat.content),
      ],
    );
  }

}
