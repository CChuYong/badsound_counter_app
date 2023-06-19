import 'dart:math';

import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../presenter/feature/main_screen/main_screen_chat_box_store.dart';
import '../../../component/touchableopacity.dart';
import '../../../designsystem/theme/base_color.dart';

class MainPageChatBox extends BaseView<MainPageChatBox, MainPageChatBoxAction,
    MainPageChatBoxState> {
  const MainPageChatBox({super.key});

  @override
  MainPageChatBoxAction initAction() => MainPageChatBoxAction();

  @override
  Widget render(BuildContext context, MainPageChatBoxAction action,
      MainPageChatBoxState state) {
    final rooms = state.rooms
        .map((e) => [
              MainPageChatBoxElements(
                  e.roomName,
                  DateParser.lastMessageFormat(e.lastMessageAtTs),
                  e.unreadMessageCount,
                  () => action.openChatRoom(e),
                  e.roomImageUrl),
              SizedBox(height: 13.sp)
            ])
        .flattened
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '나쁜말 방 목록',
          style: TextStyle(
            color: BaseColor.warmGray700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: 13.sp),
        Expanded(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () => action.pullRooms(),
            child: CustomScrollView(slivers: [
              if (rooms.isNotEmpty)
                SliverList(delegate: SliverChildListDelegate(rooms))
              else
                SliverToBoxAdapter(
                    child: Column(children: [
                      SizedBox(height: 24.sp),
                      Icon(Icons.people_alt,
                      color: BaseColor.warmGray500,
                        size: 24.sp,
                      ),
                      SizedBox(height: 6.sp),
                  Text(
                    '아직 방이 없어요! 아래 버튼을 눌러 방을 생성해보세요',
                    style: TextStyle(
                      color: BaseColor.warmGray500,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 36.sp),
                ])),
              SliverToBoxAdapter(
                  child: MainPageChatBoxAddElements(action.createNewChatBox)),
            ]),
          ),
        )
      ],
    );
  }
}

class MainPageChatBoxElements extends StatefulWidget {
  const MainPageChatBoxElements(
      this.roomName, this.lastTime, this.unreadMessageCount, this.onTap, this.roomImageUrl,
      {super.key});

  final String roomName;
  final String lastTime;
  final int unreadMessageCount;
  final String roomImageUrl;
  final Function() onTap;

  @override
  State createState() => _MainPageChatBoxElementState();
}

class _MainPageChatBoxElementState extends State<MainPageChatBoxElements> {
  late bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => isDown = true),
          onTapUp: (_) => setState(() => isDown = false),
          onTapCancel: () => setState(() => isDown = false),
          child: Container(
            padding: EdgeInsets.only(
                top: 10.sp, bottom: 10.sp, left: 14.sp, right: 14.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.sp),
              color: isDown ? BaseColor.warmGray200 : BaseColor.warmGray100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 46.sp,
                          height: 46.sp,
                          decoration: BoxDecoration(
                            color: BaseColor.warmGray700,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.roomImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3.sp,
                          right: 3.sp,
                          child: Container(
                            width: 10.sp,
                            height: 10.sp,
                            decoration: const BoxDecoration(
                              color: BaseColor.defaultGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.roomName,
                          style: TextStyle(
                            color: BaseColor.warmGray900,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 5.sp),
                        Text(
                          '+ 28,000원',
                          style: TextStyle(
                            color: BaseColor.defaultGreen,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.lastTime,
                      style: TextStyle(
                        color: BaseColor.warmGray500,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 5.sp),
                    if (widget.unreadMessageCount >= 1)
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: 14.sp,
                        height: 14.sp,
                        decoration: const BoxDecoration(
                          color: BaseColor.defaultRed,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          widget.unreadMessageCount.toString(),
                          style: TextStyle(
                            color: BaseColor.warmGray50,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: 14.sp,
                        height: 14.sp,
                      )
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () => {});
  }
}

class MainPageChatBoxAddElements extends StatelessWidget {
  final Function() onTap;

  const MainPageChatBoxAddElements(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        onTap: onTap,
        child: Container(
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
                  Icons.person_add,
                  color: BaseColor.warmGray600,
                  size: 14.sp,
                ),
                SizedBox(width: 5.sp),
                Text(
                  '방 생성하기',
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
}
