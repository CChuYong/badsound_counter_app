import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/create_new_room_screen/create_new_room_screen_store.dart';
import 'package:badsound_counter_app/view/component/touchableopacity.dart';
import 'package:badsound_counter_app/view/designsystem/component/gray_rounded_button.dart';
import 'package:badsound_counter_app/view/designsystem/component/title_text_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/user.dart';
import '../../../presenter/feature/create_new_room_screen/create_new_room_screen_state.dart';
import '../../designsystem/theme/base_color.dart';

class CreateNewRoomScreen extends BaseView<CreateNewRoomScreen,
    CreateNewRoomScreenAction, CreateNewRoomScreenState> {
  CreateNewRoomScreen({super.key});

  @override
  CreateNewRoomScreenAction initAction() => CreateNewRoomScreenAction();

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: BaseColor.defaultBackgroundColor,
      elevation: 0,
      title: Text(
        '방 생성하기',
        style: TextStyle(
          color: BaseColor.warmGray500,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget render(BuildContext context, CreateNewRoomScreenAction action,
      CreateNewRoomScreenState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: BaseColor.defaultBackgroundColor,
      child: Scaffold(
          appBar: buildAppBar(),
          backgroundColor: BaseColor.defaultBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: action.uploadImage,
                    child: Container(
                      width: 82.sp,
                      height: 82.sp,
                      decoration: BoxDecoration(
                        color: BaseColor.warmGray700,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(state.profileImageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  TitleTextBox('방 제목',
                      hint: '여기에 방 제목을 입력하세요',
                      controller: action.roomTitleController),
                  SizedBox(height: 12.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('초대할 친구 선택')],
                  ),
                  SizedBox(height: 14.sp),
                  Expanded(
                      child: RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    onRefresh: action.updateFriends,
                    child: CustomScrollView(reverse: false, slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate(state
                              .friendsMap.values
                              .map((e) => buildFriend(action, e))
                              .toList())),
                      SliverToBoxAdapter(child: SizedBox(height: 5.sp)),
                    ]),
                  )),
                  GrayRoundedButton('생성하기', onTap: action.createRoom),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildFriend(CreateNewRoomScreenAction action, User user) {
    return TouchableOpacity(
        onTap: () => action.toggleSelection(user.userId),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 18.sp,
                      height: 18.sp,
                      decoration: BoxDecoration(
                        color: BaseColor.warmGray700,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(user.profileImgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.nickname,
                            style: TextStyle(
                              color: BaseColor.warmGray600,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            )),
                      ],
                    )
                  ],
                ),
                if (action.isSelected(user.userId))
                  Icon(Icons.check, size: 14.sp, color: BaseColor.warmGray600),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Divider(),
          ],
        ));
  }
}
