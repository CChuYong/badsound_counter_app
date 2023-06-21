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
        Text(
          '내 친구',
          style: TextStyle(
            color: BaseColor.warmGray700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 18.sp),
        Expanded(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: action.updateFriends,
            child: CustomScrollView(reverse: false, slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(
                      state.friendSet.map(buildFriend).toList())),
              SliverToBoxAdapter(child: SizedBox(height: 5.sp)),
              SliverToBoxAdapter(child: friendAddButton(action))
            ]),
          ),
        ),
      ],
    ));
  }

  Widget buildFriend(User user) {
    return Column(
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
            Text('asdf',
                style: TextStyle(
                  color: BaseColor.warmGray600,
                  fontSize: 14.sp,
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
    );
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
}
