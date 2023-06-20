// import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
// import 'package:badsound_counter_app/core/api/open_api.dart';
// import 'package:badsound_counter_app/core/framework/base_action.dart';
// import 'package:badsound_counter_app/core/repository/message_repository.dart';
// import 'package:badsound_counter_app/core/repository/room_repository.dart';
// import 'package:badsound_counter_app/dependencies.config.dart';
// import 'package:badsound_counter_app/view/feature/chat_screen/chat_screen.dart';
// import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen_chat_box.dart';
// import 'package:get/get.dart';
// import 'package:quiver/collection.dart';
//
// import '../../../view/feature/create_new_room_screen/create_new_room_screen.dart';
//
// class MainPageChatBoxState {
//   TreeSet<RoomDetailResponse> roomTreeSet = TreeSet<RoomDetailResponse>(
//       comparator: (a, b) => b.lastMessageAtTs.compareTo(a.lastMessageAtTs));
//
//   MainPageChatBoxState(List<RoomDetailResponse> elements) {
//     roomTreeSet.addAll(elements);
//   }
// }
//
// class MainPageChatBoxAction extends BaseAction<MainPageChatBox,
//     MainPageChatBoxAction, MainPageChatBoxState> {
//   MainPageChatBoxAction()
//       : super(MainPageChatBoxState(inject<RoomRepository>().getCachedRooms()));
//
//
//
//   @override
//   Future<MainPageChatBoxState> initState() async {
//     final cachedRooms = await rooms.getRooms();
//     updateFromServer();
//     return MainPageChatBoxState(cachedRooms);
//   }
//
//
// }
