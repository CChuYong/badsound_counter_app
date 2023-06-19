import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/view/designsystem/component/base_top_bar.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/chat.dart';
import '../../../presenter/feature/chat_screen/chat_screen_state.dart';
import '../../../presenter/feature/chat_screen/chat_screen_store.dart';
import '../../designsystem/theme/base_color.dart';

class ChatScreen
    extends BaseView<ChatScreen, ChatScreenAction, ChatScreenState> {
  final RoomDetailResponse room;
  final List<Chat> initialMessages;

  ChatScreen(this.room, this.initialMessages, {super.key});

  @override
  ChatScreenAction initAction() => ChatScreenAction(room, initialMessages);

  @override
  Widget render(
      BuildContext context, ChatScreenAction action, ChatScreenState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: BaseColor.defaultBackgroundColor,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: BaseColor.defaultBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BaseTopBar(room.roomName),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                  child: RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    onRefresh: () => action.pullPreviousChat(),
                    child: CustomScrollView(reverse: true, slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate(state.chatTreeSet
                              .map((e) => ChatBox(e))
                              .toList())),
                    ]),
                  )),
            ),
            buildInputArea(context, action),
          ],
        ),
      )),
    );
  }

  Widget buildInputArea(BuildContext context, ChatScreenAction action) {
    return Padding(
      padding: EdgeInsets.only(left: 12.sp, right: 6.sp, top: 9.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                TextField(
                  controller: action.textController,
                  decoration: InputDecoration(
                      hintText: "개소리 입력하기...",
                      contentPadding:
                          EdgeInsets.fromLTRB(42.sp, 0.sp, 5.sp, 0.sp),
                      fillColor: BaseColor.warmGray50,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.sp),
                          borderSide: BorderSide(
                            width: 1.sp,
                          ))),
                  style:
                      TextStyle(color: BaseColor.warmGray700, fontSize: 12.sp),
                ),
                Positioned(
                    top: 8.sp,
                    right: 10.sp,
                    child: GestureDetector(
                      onTap: action.onTapSend,
                      child: Icon(
                        Icons.send,
                        color: BaseColor.warmGray400,
                      ),
                    )),
                Positioned(
                  left: 5.sp,
                  top: 5.sp,
                  child: Container(
                    width: 30.sp,
                    height: 30.sp,
                    decoration: const BoxDecoration(
                      color: BaseColor.warmGray400,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.sp),
        ],
      ),
    );
  }

// Widget buildMessageList() {
//   return Expanded(
//     child: ListView.builder(
//       shrinkWrap: true,
//       itemCount: 50,
//       controller: _controller,
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: EdgeInsets.all(10),
//           child: Container(
//             color: Colors.red,
//             height: 20,
//             child: Text(index.toString()),
//           ),
//         );
//       },
//     ),
//   );
// }
}
