import 'package:badsound_counter_app/core/model/room.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';
import 'package:get/get.dart';
import 'package:quiver/collection.dart';

import '../../../core/api/open_api.dart';
import '../../../core/framework/base_action.dart';
import '../../../core/framework/state_store.dart';
import '../../../core/repository/message_repository.dart';
import '../../../core/repository/room_repository.dart';
import '../../../core/repository/user_repository.dart';
import '../../../dependencies.config.dart';
import '../../../view/feature/chat_screen/chat_screen.dart';
import '../../../view/feature/create_new_room_screen/create_new_room_screen.dart';
import 'main_screen_stat_box_state.dart';

class MainScreenState {
  MainPageStatBoxState statBoxState;
  TreeSet<Room> roomTreeSet = TreeSet<Room>(comparator: (a, b) {
    if (a.roomId == b.roomId) return 0;
    return b.lastMessageAtTs.compareTo(a.lastMessageAtTs);
  });

  MainScreenState(this.statBoxState, List<Room> rooms) {
    roomTreeSet.addAll(rooms);
  }
}

class MainScreenAction
    extends BaseAction<MainPage, MainScreenAction, MainScreenState> {
  MainScreenAction()
      : super(MainScreenState(
            StateStore.loadState(MainPageStatBoxState)
                    ?.letCatching(MainPageStatBoxState.fromJson) ??
                MainPageStatBoxState(0, '', ''),
            inject<RoomRepository>().getCachedRooms()));

  final UserRepository userRepository = inject<UserRepository>();
  final OpenAPI openAPI = inject<OpenAPI>();
  final RoomRepository rooms = inject<RoomRepository>();
  final MessageRepository messageRepository = inject<MessageRepository>();

  @override
  Future<MainScreenState> initState() async {
    final statBox = await userRepository.getDashboard();
    final chatBox = await openAPI.getMyRooms();
    return MainScreenState(statBox, chatBox.map((e) => e.toModel()).toList());
  }

  @override
  void dispose() {
    StateStore.saveState(MainPageStatBoxState, state.statBoxState.toJson());
    state.roomTreeSet.forEach((element) {
      rooms.persist(element);
    });
  }

  void openChatRoom(Room roomDetail) async {
    final messages =
        await messageRepository.getMessagesByRoom(roomDetail.roomId);
    Get.to(() => ChatScreen(roomDetail, messages));
  }

  Future<void> pullRooms() async {
    final data = await openAPI.getMyRooms();
    setState(() {
      state.roomTreeSet.clear();
      state.roomTreeSet.addAll(data.map((e) => e.toModel()));
    });
  }

  void createNewChatBox() {
    Get.to(() => CreateNewRoomScreen());
  }
}
