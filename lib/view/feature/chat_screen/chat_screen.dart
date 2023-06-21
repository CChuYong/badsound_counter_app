import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/core/model/room.dart';
import 'package:badsound_counter_app/core/model/violent.dart';
import 'package:badsound_counter_app/core/util/currency_parser.dart';
import 'package:badsound_counter_app/view/component/touchableopacity.dart';
import 'package:badsound_counter_app/view/designsystem/component/mini_info_message.dart';
import 'package:badsound_counter_app/view/feature/chat_screen/chat_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/chat.dart';
import '../../../presenter/feature/chat_screen/chat_screen_state.dart';
import '../../../presenter/feature/chat_screen/chat_screen_store.dart';
import '../../designsystem/theme/base_color.dart';

class ChatScreen
    extends BaseView<ChatScreen, ChatScreenAction, ChatScreenState> {
  final Room room;
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

          child: Scaffold(
            appBar: buildAppBar(),
        endDrawer: buildDrawer(action, state),
        backgroundColor: BaseColor.defaultBackgroundColor,
        body: SafeArea(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
        )),
      ),
    );
  }

  Widget buildDrawer(ChatScreenAction action, ChatScreenState state) {
    return Drawer(
      backgroundColor: BaseColor.warmGray200,
      child: SafeArea(child:
          Padding(
            padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '이 방의 나쁜말',
                    style: TextStyle(
                      color: BaseColor.warmGray600,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    )
                ),
                SizedBox(height: 16.sp),
                Expanded(
                  child: RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: action.reloadViolents,
                        child: CustomScrollView(reverse: false, slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate(state.violentSet
                                  .map(buildViolent)
                                  .toList())),
                          SliverToBoxAdapter(child: SizedBox(height: 20.sp)),
                          SliverToBoxAdapter(child: violentAddButton(action)),
                          SliverToBoxAdapter(child: SizedBox(height: 5.sp)),
                          SliverToBoxAdapter(child: MiniInfoMessage('혼자 있는 방에선 나쁜말이 적립되지 않아요', size: 11.sp)),
                        ]),
                      ),
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget buildViolent(Violent violent){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                violent.name,
                style: TextStyle(
                  color: BaseColor.warmGray600,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                )
            ),
            Text(
                CurrencyParser.formatUnsigned(violent.price),
                style: TextStyle(
                  color: BaseColor.warmGray600,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                )
            )
          ],
        ),
        SizedBox(
          height: 10.sp,
        )
      ],
    );
  }


  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: BaseColor.defaultBackgroundColor,
      elevation: 0,
      title: Text(
        room.roomName,
        style: TextStyle(
          color: BaseColor.warmGray500,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget violentAddButton(ChatScreenAction action) {
    return TouchableOpacity(
      onTap: action.onTapCreateViolent,
        child:
    Container(
      padding: EdgeInsets.only(top: 14.sp, bottom: 14.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.sp),
        color: BaseColor.warmGray100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Icon(
              Icons.message,
              color: BaseColor.warmGray600,
              size: 14.sp,
            ),
            SizedBox(width: 5.sp),
            Text(
              '나쁜말 추가하기',
              style: TextStyle(
                color: BaseColor.warmGray600,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ])
        ],
      ),
    ));
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
                      hintText: "${action.state.speaker?.nickname ?? ''}님의 나쁜말 입력하기...",
                      contentPadding:
                          EdgeInsets.fromLTRB(42.sp, 0.sp, 5.sp, 0.sp),
                      fillColor: BaseColor.warmGray50,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.sp),
                          borderSide: BorderSide(
                            color: BaseColor.warmGray400,
                            width: 1.sp,
                          ))
                  ),
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
                  child: GestureDetector(
                    onTap: action.onTapChangeSpeaker,
                  child: Container(
                    width: 30.sp,
                    height: 30.sp,
                    decoration: BoxDecoration(
                      color: BaseColor.warmGray400,
                      shape: BoxShape.circle,
                      border: Border.all(color: BaseColor.warmGray600),
                      image: action.state.speaker != null ? DecorationImage(image: CachedNetworkImageProvider(action.state.speaker!.profileImgUrl)) : null
                    ),
                  )),
                )
              ],
            ),
          ),
          SizedBox(width: 10.sp),
        ],
      ),
    );
  }
}
