import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_speaker_selector_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/api/model/me_response.dart';
import 'chat_screen_store.dart';

class ChatSpeakerSelectorScreenState {
  final List<MeResponse> members;
  ChatSpeakerSelectorScreenState(this.members);
}

class ChatSpeakerSelectorScreenAction extends BaseAction<ChatSpeakerSelectorScreen, ChatSpeakerSelectorScreenAction, ChatSpeakerSelectorScreenState> {
  final ChatScreenAction chatScreenAction;
  ChatSpeakerSelectorScreenAction(List<MeResponse> members, this.chatScreenAction) : super(ChatSpeakerSelectorScreenState(members));

  @override
  Future<ChatSpeakerSelectorScreenState> initState() async => state;

  void selectUser(MeResponse user) async {
    chatScreenAction.updateSpeaker(user);
    Get.back();
  }

}
