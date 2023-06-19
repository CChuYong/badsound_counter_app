import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_speaker_selector_screen.dart';

import '../../../core/api/model/me_response.dart';

class ChatSpeakerSelectorScreenState {
  final List<MeResponse> members;
  ChatSpeakerSelectorScreenState(this.members);
}

class ChatSpeakerSelectorScreenAction extends BaseAction<ChatSpeakerSelectorScreen, ChatSpeakerSelectorScreenAction, ChatSpeakerSelectorScreenState> {
  ChatSpeakerSelectorScreenAction(List<MeResponse> members) : super(ChatSpeakerSelectorScreenState(members));

  @override
  Future<ChatSpeakerSelectorScreenState> initState() async => state;

}
