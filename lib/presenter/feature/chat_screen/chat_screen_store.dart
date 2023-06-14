import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/chat_request.dart';
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
    return Chat(e.messageId, e.roomId, e.content, e.speakerId, sender.nickname, sender.profileImgUrl, e.violentPrice, e.createdAtTs);
  }

  Future<void> updateChat() async {
    final lastChat = state.chatTreeSet.first;
    final data = await openAPI.getChattingsAfter(roomResponse.roomId, lastChat.messageId);
    final mappedData = data.map((e) async => await getChat(e));
    final chats = await Future.wait(mappedData);
    setState(() {
      state.chatTreeSet.addAll(chats);
    });
  }

  void onTapSend() async {
    if(textController.text == '') return;
    final me = await userRepository.getCachedMe();
    log('message send');
    final message = textController.text;
    final chat = ChatRequest('test', me.userId, me.userId, message);
    textController.text = '';
    await openAPI.sendMessage(roomResponse.roomId, chat);
    await updateChat();
  }
}
