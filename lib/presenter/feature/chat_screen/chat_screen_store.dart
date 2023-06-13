import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';

import 'chat_screen_state.dart';

class ChatScreenAction extends BaseAction<ChatScreen, ChatScreenAction, ChatScreenState> {
  ChatScreenAction(this.roomResponse) : super(ChatScreenState(List.empty()));

  final RoomDetailResponse roomResponse;
  final OpenAPI openAPI = inject<OpenAPI>();
  final UserRepository userRepository = inject<UserRepository>();

  final textController = TextEditingController();

  @override
  Future<ChatScreenState> initState() async {
    final data = await openAPI.getChattings(roomResponse.roomId);
    final mappedData = data.map((e) async => await getChat(e));
    return ChatScreenState(await Future.wait(mappedData));
  }

  Future<Chat> getChat(ChatResponse e) async {
    final sender = await userRepository.getUserOrPull(e.speakerId);
    return Chat(e.messageId, e.roomId, e.content, e.speakerId, sender.nickname, e.violentPrice, e.createdAtTs);
  }

  void onTapSend() {
    if(textController.text == '') return;
    log('message send');
  }
}
