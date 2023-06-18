import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/chat_request.dart';
import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/state/push_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';

import 'chat_screen_state.dart';

class ChatScreenAction extends BaseAction<ChatScreen, ChatScreenAction, ChatScreenState> {
  ChatScreenAction(this.roomResponse, List<Chat> initialMessages) : super(ChatScreenState(initialMessages));

  final RoomDetailResponse roomResponse;
  final OpenAPI openAPI = inject<OpenAPI>();
  final UserRepository userRepository = inject<UserRepository>();
  final PushStore pushStore = inject<PushStore>();
  final MessageRepository messageRepository = inject<MessageRepository>();

  final textController = TextEditingController();

  @override
  Future<ChatScreenState> initState() async {
    print("Before pull, initial message size : ${state.chatTreeSet.length}");
    final chats = await pullAllChat();
    pushStore.chatMessageConsumer = onMessageReceived;
    return ChatScreenState(chats);
  }

  @override
  void dispose() {
    pushStore.chatMessageConsumer = null;

    for (var element in state.chatTreeSet) {
      messageRepository.persist(element);
    }
  }

  void onMessageReceived(ChatResponse chat) async {
    final message = await getChat(chat);
    setState(() {
      state.chatTreeSet.add(message);
    });
  }

  Future<List<Chat>> pullAllChat() async {
    final data = await openAPI.getChattings(roomResponse.roomId);
    final mappedData = data.map((e) async => await getChat(e));
    return await Future.wait(mappedData);
  }

  Future<Chat> getChat(ChatResponse e) async {
    final sender = await userRepository.getUserOrPull(e.speakerId);
    return Chat(e.messageId, e.roomId, e.content, e.speakerId, sender.nickname, sender.profileImgUrl, e.violentPrice, e.createdAtTs);
  }

  Future<void> updateChat() async {
    if(state.chatTreeSet.isEmpty){
      final allChats = await pullAllChat();
      setState(() {
        state.chatTreeSet.addAll(allChats);
      });
      return;
    }
    final lastChat = state.chatTreeSet.first;
    final data = await openAPI.getChattingsAfter(roomResponse.roomId, lastChat.messageId);
    final mappedData = data.map((e) async => await getChat(e));
    final chats = await Future.wait(mappedData);
    setState(() {
      state.chatTreeSet.addAll(chats);
    });
  }

  Future<void> pullPreviousChat() async {
    if(state.chatTreeSet.isNotEmpty){
      final firstChat = state.chatTreeSet.last;
      final data = await openAPI.getChattingsBefore(roomResponse.roomId, firstChat.messageId);
      final mappedData = data.map((e) async => await getChat(e));
      final chats = await Future.wait(mappedData);
      setState(() {
        state.chatTreeSet.addAll(chats);
      });
    }
  }

  void onTapSend() async {
    if(textController.text == '') return;
    final me = await userRepository.getCachedMe();
    log('message send');
    final message = textController.text;
    final chat = ChatRequest('test', me.userId, me.userId, message);
    textController.text = '';
    await openAPI.sendMessage(roomResponse.roomId, chat);
    //await updateChat();
  }
}
