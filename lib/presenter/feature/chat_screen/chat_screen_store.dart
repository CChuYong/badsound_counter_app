import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';

import 'chat_screen_state.dart';

class ChatScreenAction extends BaseAction<ChatScreen, ChatScreenAction, ChatScreenState> {
  ChatScreenAction() : super(ChatScreenState());

  @override
  Future<ChatScreenState> initState() async => ChatScreenState();

}
