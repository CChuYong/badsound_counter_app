import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/presenter/feature/calendar_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/safe_area_with_padding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/touchableopacity.dart';
import '../../../designsystem/theme/base_color.dart';

class SocialScreen
    extends BaseView<SocialScreen, SocialScreenAction, SocialScreenState> {
  const SocialScreen({super.key});

  @override
  SocialScreenAction initAction() => SocialScreenAction();

  @override
  Widget render(BuildContext context, SocialScreenAction action,
      SocialScreenState state) {
    return SafeAreaWithPadding(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '내 친구 (${state.friendSet.length}명)',
              style: TextStyle(
                color: BaseColor.warmGray700,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            GestureDetector(
              onTap: action.addFriend,
              child: Icon(Icons.add_rounded, size: 30.sp, color: BaseColor.warmGray700)
            )

          ],
        ),
        SizedBox(height: 18.sp),
        Expanded(
          flex: 3,
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: action.updateFriends,
            child: CustomScrollView(reverse: false, slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(state.friendSet
                      .map((e) => buildFriend(action, e))
                      .toList())),
              SliverToBoxAdapter(child: SizedBox(height: 15.sp)),
            ]),
          ),
        ),
        SizedBox(height: 10.sp),
        Text(
          '친구 요청 (${state.friendRequests.length}명)',
          style: TextStyle(
            color: BaseColor.warmGray700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Expanded(
          flex: 1,
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: action.updateRequests,
            child: CustomScrollView(reverse: false, slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(state.friendRequests
                      .map((e) => buildFriendRequest(action, e))
                      .toList())),
              SliverToBoxAdapter(child: SizedBox(height: 15.sp)),
            ]),
          ),
        )
      ],
    ));
  }

  Widget buildFriend(SocialScreenAction action, User user) {
    return TouchableOpacity(
        onTap: () => action.onTapFriend(user),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30.sp,
                      height: 30.sp,
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
                        Text(user.taggedNickname,
                            style: TextStyle(
                              color: BaseColor.warmGray400,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ))
                      ],
                    )
                  ],
                ),
                Text("",
                    style: TextStyle(
                      color: BaseColor.warmGray600,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ))
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Divider(),
          ],
        ));
  }

  Widget friendAddButton(SocialScreenAction action) {
    return TouchableOpacity(
        onTap: action.addFriend,
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
                  Icons.people_alt,
                  color: BaseColor.warmGray600,
                  size: 14.sp,
                ),
                SizedBox(width: 5.sp),
                Text(
                  '친구 추가하기',
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

  Widget buildFriendRequest(SocialScreenAction action, User user) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TouchableOpacity(
                onTap: () => action.onTapFriend(user),
                child: Row(
                  children: [
                    Container(
                      width: 30.sp,
                      height: 30.sp,
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
                        Text(user.taggedNickname,
                            style: TextStyle(
                              color: BaseColor.warmGray600,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ))
                      ],
                    )
                  ],
                )),
            Row(
              children: [
                acceptButton(action, user),
                SizedBox(width: 5.sp),
                denyButton(action, user)
              ],
            )
          ],
        ),
        SizedBox(
          height: 3.sp,
        ),
        Divider(),
      ],
    );
  }

  Widget acceptButton(SocialScreenAction action, User user) {
    return TouchableOpacity(
        onTap: () => action.acceptFriendRequest(user),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: BaseColor.defaultGreen.withOpacity(0.7),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 4.sp, bottom: 4.sp, left: 6.sp, right: 6.sp),
              child: Text("수락",
                  style: TextStyle(
                    color: BaseColor.warmGray50,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  )),
            )));
  }

  Widget denyButton(SocialScreenAction action, User user) {
    return TouchableOpacity(
        onTap: () => action.denyFriendRequest(user),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: BaseColor.warmGray300,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 4.sp, bottom: 4.sp, left: 6.sp, right: 6.sp),
              child: Text("거절",
                  style: TextStyle(
                    color: BaseColor.warmGray600,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  )),
            )));
  }
}
