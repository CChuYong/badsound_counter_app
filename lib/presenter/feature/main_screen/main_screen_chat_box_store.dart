import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/core/repository/room_repository.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen_chat_box.dart';
import 'package:get/get.dart';

import '../../../view/feature/create_new_room_screen/create_new_room_screen.dart';

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

  @override
  void dispose() {
    state.rooms.forEach((element) {
      rooms.persist(element);
    });
  }

  void openChatRoom(RoomDetailResponse roomDetail) async {
    final messages =
        await messageRepository.getMessagesByRoom(roomDetail.roomId);
    Get.to(() => ChatScreen(roomDetail, messages));
  }

  Future<void> pullRooms() async {
    final data = await openAPI.getMyRooms();
    setState(() {
      state.rooms = data;
    });
  }

  void createNewChatBox() {
    Get.to(() => CreateNewRoomScreen());
  }
}
