import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/view/designsystem/component/base_top_bar.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presenter/feature/chat_screen/chat_screen_state.dart';
import '../../../presenter/feature/chat_screen/chat_screen_store.dart';
import '../../designsystem/theme/base_color.dart';

class ChatScreen
    extends BaseView<ChatScreen, ChatScreenAction, ChatScreenState> {
  final RoomDetailResponse room;

  ChatScreen(this.room, {super.key});

  @override
  ChatScreenAction initAction() => ChatScreenAction(room);

  @override
  Widget render(
      BuildContext context, ChatScreenAction action, ChatScreenState state) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: BaseColor.defaultBackgroundColor,
        child: SafeArea(
            child: Column(children: [
              BaseTopBar(room.roomName),
          SizedBox(height: 20.sp),
          // Text(
          //   'hi room ${room.roomId}',
          //   style: TextStyle(
          //     color: BaseColor.warmGray500,
          //     fontSize: 24.sp,
          //     fontWeight: FontWeight.w900,
          //   ),
          // ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => {  },
                  child: CustomScrollView(
                      slivers: [
                        SliverList(delegate: SliverChildListDelegate(state.chattings.map((e) => ChatBox(e)).toList())),
                      ]
                  ),
                ),
              )
        ])));
  }
}
