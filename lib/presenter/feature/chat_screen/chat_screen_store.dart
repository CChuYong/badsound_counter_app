import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/chat_request.dart';
import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/api/model/violent_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/model/room.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/core/repository/room_repository.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/state/push_store.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/designsystem/component/gray_rounded_textbox.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_speaker_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/api/model/last_message_id_request.dart';
import '../../../core/model/violent.dart';
import '../../../view/designsystem/theme/base_color.dart';
import 'chat_screen_state.dart';

class ChatScreenAction
    extends BaseAction<ChatScreen, ChatScreenAction, ChatScreenState> {
  ChatScreenAction(this.roomResponse, List<Chat> initialMessages)
      : super(ChatScreenState(initialMessages, null));

  final Room roomResponse;
  final OpenAPI openAPI = inject<OpenAPI>();
  final UserRepository userRepository = inject<UserRepository>();
  final PushStore pushStore = inject<PushStore>();
  final RoomRepository roomRepository = inject<RoomRepository>();
  final MessageRepository messageRepository = inject<MessageRepository>();

  final textController = TextEditingController();

  @override
  Future<ChatScreenState> initState() async {
    print("Before pull, initial message size : ${state.chatTreeSet.length}");
    final userId = await roomRepository.getSpeakerIdOfRoom(roomResponse.roomId);
    final speaker = await (userId?.let(userRepository.getUserOrPull) ??
        userRepository.getMe());
    state.speaker = speaker;

    await updateChat();
    pushStore.chatMessageConsumer = onMessageReceived;
    updateLastChatId();

    await reloadViolents();
    return state;
  }

  Future<void> updateLastChatId() async {
    if(state.chatTreeSet.isNotEmpty) {
      final lastChat = state.chatTreeSet.first;
      await openAPI.updateLastReadMessageId(roomResponse.roomId, UpdateLastMessageIdRequest(lastChat.messageId));
    }
  }

  Future<void> reloadViolents() async {
    final violents = await openAPI.getRoomViolents(roomResponse.roomId);
    setState(() {
      state.violentSet.clear();
      state.violentSet.addAll(violents.map((e) => Violent(
          id: e.violentId,
          name: e.name,
          description: e.description,
          price: e.violentPrice)));
    });
  }

  Future<void> deleteViolents(String violentId) async {
    confirmModal(
        content: '정말 삭제 할까요?',
        confirmText: '삭제',
        onConfirm: () async {
          await openAPI.deleteViolent(roomResponse.roomId, violentId);
          await reloadViolents();
          Get.back();
        });
  }

  void onTapCreateViolent() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final priceController = TextEditingController();
    defaultDialog(
      buttonText: "추가하기",
      content: Padding(
          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
          child: Column(
            children: [
              Text('나쁜말 추가하기', style: TextStyle(
                color: BaseColor.warmGray600,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              )),
              SizedBox(height: 10.sp),
              GrayRoundedTextBox(
                  '나쁜말 단어',
                  controller: nameController
              ),
              SizedBox(height: 10.sp),
              GrayRoundedTextBox(
                  '나쁜말 설명 (선택)',
                  controller: descController
              ),
              SizedBox(height: 10.sp),
              GrayRoundedTextBox(
                  '나쁜말 가격',
                  controller: priceController
              )
            ],
          )),
      onPerform: () async {
        final name = nameController.text;
        final desc = descController.text;
        final price = int.tryParse(priceController.text) ?? 0;
        if (name.length <= 1) {
          Get.snackbar('오류', '나쁜말 단어는 2자 이상이어야해요.');
          return;
        }
        if (price <= 0) {
          Get.snackbar('오류', '나쁜말 가격을 입력해주세요.');
          return;
        }
        await openAPI.createRoomViolent(
            roomResponse.roomId,
            ViolentRequest(
                name: name, description: desc, violentPrice: price));
        await reloadViolents();
        Get.back();
        infoSnackBar(message: '나쁜말을 성공적으로 추가했어요!');
      }
    );
  }

  @override
  void dispose() {
    pushStore.chatMessageConsumer = null;
    if (state.speaker != null) {
      roomRepository.setSpeakerIdOfRoom(
          roomResponse.roomId, state.speaker!.userId);
    }

    for (var element in state.chatTreeSet) {
      messageRepository.persist(element);
    }

    updateLastChatId();
  }

  void onMessageReceived(ChatResponse chat) async {
    final message = await getChat(chat);
    setState(() {
      state.chatTreeSet.add(message);
    });
    updateLastChatId();
  }

  Future<List<Chat>> pullAllChat() async {
    final data = await openAPI.getChattings(roomResponse.roomId);
    final mappedData = data.map((e) async => await getChat(e));
    return await Future.wait(mappedData);
  }

  Future<Chat> getChat(ChatResponse e) async {
    final sender = await userRepository.getUserOrPull(e.speakerId);
    return Chat(e.messageId, e.roomId, e.content, e.speakerId, sender.nickname,
        sender.profileImgUrl, e.violentPrice, e.createdAtTs);
  }

  Future<void> updateChat() async {
    if (state.chatTreeSet.isEmpty) {
      final allChats = await pullAllChat();
      setState(() {
        state.chatTreeSet.addAll(allChats);
      });
      return;
    }
    final lastChat = state.chatTreeSet.first;
    final data = await openAPI.getChattingsAfter(
        roomResponse.roomId, lastChat.messageId);
    final mappedData = data.map((e) async => await getChat(e));
    final chats = await Future.wait(mappedData);
    setState(() {
      state.chatTreeSet.addAll(chats);
    });
  }

  Future<void> pullPreviousChat() async {
    if (state.chatTreeSet.isNotEmpty) {
      final firstChat = state.chatTreeSet.last;
      final data = await openAPI.getChattingsBefore(
          roomResponse.roomId, firstChat.messageId);
      final mappedData = data.map((e) async => await getChat(e));
      final chats = await Future.wait(mappedData);
      setState(() {
        state.chatTreeSet.addAll(chats);
      });
    }
  }

  void onTapSend() async {
    if (textController.text == '') return;
    final me = await userRepository.getCachedMe();
    log('message send');
    final message = textController.text;
    final chat = ChatRequest('test', state.speaker!.userId, me.userId, message);
    textController.text = '';
    await openAPI.sendMessage(roomResponse.roomId, chat);
    //await updateChat();
  }

  void onTapChangeSpeaker() async {
    final users = await openAPI.getUsersInRoom(roomResponse.roomId);
    Get.to(() => ChatSpeakerSelectorScreen(users, this));
  }

  void updateSpeaker(User user) {
    setState(() {
      state.speaker = user;
    });
  }
}
