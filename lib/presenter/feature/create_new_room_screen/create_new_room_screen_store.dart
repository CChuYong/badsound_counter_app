import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/view/feature/create_new_room_screen/create_new_room_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/api/model/room_create_request.dart';
import '../../../core/api/model/room_detail_response.dart';
import '../../../core/api/open_api.dart';
import '../../../dependencies.config.dart';
import '../../../view/feature/chat_screen/chat_screen.dart';
import 'create_new_room_screen_state.dart';

class CreateNewRoomScreenAction extends BaseAction<CreateNewRoomScreen, CreateNewRoomScreenAction, CreateNewRoomScreenState> {
  final OpenAPI openAPI = inject<OpenAPI>();
  final MessageRepository messageRepository = inject<MessageRepository>();
  final roomTitleController = TextEditingController();
  CreateNewRoomScreenAction() : super(CreateNewRoomScreenState());

  @override
  Future<CreateNewRoomScreenState> initState() async => CreateNewRoomScreenState();

  Future<void> createRoom() async {
    final roomResponse = await openAPI.createNewRoom(RoomCreateRequest(roomTitleController.text));
    final mockRoom = RoomDetailResponse(
        roomResponse.roomId,
        roomResponse.roomName,
        roomResponse.ownerId,
        roomResponse.createdAtTs,
        roomResponse.createdAtTs,
        0,
      roomResponse.roomImageUrl,
    );
    openChatRoom(mockRoom);
  }

  void openChatRoom(RoomDetailResponse roomDetail) async {
    final messages = await messageRepository.getMessagesByRoom(roomDetail.roomId);
    Get.back();
    await Get.to(() => ChatScreen(roomDetail, messages));
  }
}