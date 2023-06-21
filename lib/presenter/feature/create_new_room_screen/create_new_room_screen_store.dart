import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/view/feature/create_new_room_screen/create_new_room_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../core/api/model/room_create_request.dart';
import '../../../core/api/model/room_detail_response.dart';
import '../../../core/api/open_api.dart';
import '../../../dependencies.config.dart';
import '../../../view/feature/chat_screen/chat_screen.dart';
import 'create_new_room_screen_state.dart';

class CreateNewRoomScreenAction extends BaseAction<CreateNewRoomScreen,
    CreateNewRoomScreenAction, CreateNewRoomScreenState> {
  final OpenAPI openAPI = inject<OpenAPI>();
  final MessageRepository messageRepository = inject<MessageRepository>();
  final roomTitleController = TextEditingController();
  final Dio dio = inject<Dio>();

  CreateNewRoomScreenAction() : super(CreateNewRoomScreenState());

  @override
  Future<CreateNewRoomScreenState> initState() async  {
    await updateFriends();
    return state;
  }

  void toggleSelection(String userId) {
    setState(() {
      if(state.selectedUserIds.contains(userId)) {
        state.selectedUserIds.remove(userId);
      }else{
        state.selectedUserIds.add(userId);
      }
    });
  }

  bool isSelected(String userId) {
    return state.selectedUserIds.contains(userId);
  }


  Future<void> createRoom() async {
    final roomResponse = await openAPI.createNewRoom(
        RoomCreateRequest(roomTitleController.text, state.profileImageUrl, state.selectedUserIds.toList()));
    final mockRoom = RoomDetailResponse(
      roomResponse.roomId,
      roomResponse.roomName,
      roomResponse.ownerId,
      roomResponse.createdAtTs,
      roomResponse.createdAtTs,
      0,
      0,
      roomResponse.roomImageUrl,
    );
    openChatRoom(mockRoom);
  }

  void openChatRoom(RoomDetailResponse roomDetail) async {
    final messages =
        await messageRepository.getMessagesByRoom(roomDetail.roomId);
    Get.back();
    await Get.to(() => ChatScreen(roomDetail.toModel(), messages));
  }

  Future<void> updateFriends() async {
    final friends = await openAPI.getMyFriends();
    setState(() {
      friends.forEach((element) { state.friendsMap[element.id] = element.toModel(); });
    });
  }

  void uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final mimeType = lookupMimeType(image.path);
    final imageRequest = await openAPI.requestProfileImageUpload();

    final bytes = await image.readAsBytes();
    await dio.request(imageRequest.uploadUrl,
        data: bytes,
        options: Options(method: 'PUT', headers: {'Content-Type': mimeType}));

    infoSnackBar(message: '업로드에 성공했어요!');
    setState(() {
      state.profileImageUrl = imageRequest.downloadUrl;
    });
  }
}
