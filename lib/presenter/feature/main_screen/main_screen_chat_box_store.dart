import 'package:badsound_counter_app/core/api/model/room_create_request.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
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

  @override
  Future<MainPageChatBoxState> initState() async {
    final data = await openAPI.getMyRooms();
    return MainPageChatBoxState(data);
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
          onPressed: () {
            openAPI.createNewRoom(RoomCreateRequest(textController.text));
          }),
    );
  }
}
