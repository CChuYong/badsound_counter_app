import 'package:badsound_counter_app/core/api/model/room_create_request.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/core/repository/room_repository.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen_chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../view/designsystem/theme/base_color.dart';

class MainPageChatBoxState {
  List<RoomDetailResponse> rooms;

  MainPageChatBoxState(this.rooms);
}

class MainPageChatBoxAction extends BaseAction<MainPageChatBox,
    MainPageChatBoxAction, MainPageChatBoxState> {
  MainPageChatBoxAction()
      : super(MainPageChatBoxState(List<RoomDetailResponse>.empty()));

  final OpenAPI openAPI = inject<OpenAPI>();
  final RoomRepository rooms = inject<RoomRepository>();
  final MessageRepository messageRepository = inject<MessageRepository>();

  @override
  Future<MainPageChatBoxState> initState() async {
    final cachedRooms = await rooms.getRooms();
    updateFromServer();
    return MainPageChatBoxState(cachedRooms);
  }

  Future<void> updateFromServer() async {
    final data = await openAPI.getMyRooms();
    setState(() {
      state.rooms = data;
    });
  }

  void openChatRoom(RoomDetailResponse roomDetail) async {
    final messages = await messageRepository.getMessagesByRoom(roomDetail.roomId);
    Get.to(() => ChatScreen(roomDetail, messages));
  }

  Future<void> pullRooms() async {
    final data = await openAPI.getMyRooms();
    setState(() {
      state.rooms = data;
    });
  }

  void createNewChatBox() {
    final textController = TextEditingController();
    Get.defaultDialog(
      title: '',
      content: Padding(
          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
          child: Column(
            children: [
              Text('방 생성하기'),
              SizedBox(height: 10.sp),
              TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '방 이름',
                  ))
            ],
          )),
      middleText: 'gelllel',
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(fontSize: 0),
      middleTextStyle: const TextStyle(color: BaseColor.warmGray800),
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: () {},
      onCancel: () {},
      contentPadding: EdgeInsets.only(bottom: 15.sp),
      confirm: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: BaseColor.warmGray300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.sp)),
          ),
          child: Text(
            '취소하기',
            style: TextStyle(color: BaseColor.warmGray400),
          ),
          onPressed: () {
            Get.back();
          }),
      cancel: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: BaseColor.warmGray200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.sp)),
          ),
          child: Text(
            '생성하기',
            style: TextStyle(color: BaseColor.warmGray500),
          ),
          onPressed: () async {
            final roomResponse = await openAPI.createNewRoom(RoomCreateRequest(textController.text));
            final mockRoom = RoomDetailResponse(
              roomResponse.roomId,
              roomResponse.roomName,
              roomResponse.ownerId,
              roomResponse.createdAtTs,
              roomResponse.createdAtTs,
              0
            );
            Get.back();
            openChatRoom(mockRoom);
          }),
    );
  }
}
