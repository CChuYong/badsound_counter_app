import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';

import 'chat_screen_state.dart';

class ChatScreenAction extends BaseAction<ChatScreen, ChatScreenAction, ChatScreenState> {
  ChatScreenAction(this.roomResponse) : super(ChatScreenState(List.empty()));

  final RoomDetailResponse roomResponse;
  final OpenAPI openAPI = inject<OpenAPI>();

  @override
  Future<ChatScreenState> initState() async {
    final data = await openAPI.getChattings(roomResponse.roomId);
    return ChatScreenState(data);
  }

}
