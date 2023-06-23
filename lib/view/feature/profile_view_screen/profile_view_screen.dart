import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:badsound_counter_app/presenter/feature/profile_view_screen/profile_view_screen_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/component/gray_solid_button.dart';
import '../../designsystem/theme/base_color.dart';

class ProfileViewScreen extends BaseView<ProfileViewScreen,
    ProfileViewScreenAction, ProfileViewScreenState> {
  final ProfileViewScreenState profile;

  ProfileViewScreen(this.profile, {super.key});

  @override
  ProfileViewScreenAction initAction() => ProfileViewScreenAction(profile);

  PreferredSizeWidget buildAppBar(ProfileViewScreenState state) {
    return AppBar(
      backgroundColor: BaseColor.defaultBackgroundColor,
      elevation: 0,
      title: Text(
        '${state.profile.nickname}님의 프로필',
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
  Widget render(BuildContext context, ProfileViewScreenAction action,
      ProfileViewScreenState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: BaseColor.defaultBackgroundColor,
      child: Scaffold(
          appBar: buildAppBar(state),
          backgroundColor: BaseColor.defaultBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: action.onTapImageView,
                            child: Container(
                              width: 82.sp,
                              height: 82.sp,
                              decoration: BoxDecoration(
                                color: BaseColor.warmGray700,
                                shape: BoxShape.circle,
                                image: state.profile.profileImgUrl != ''
                                    ? DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            state.profile.profileImgUrl),
                                        fit: BoxFit.fitWidth,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.sp),
                          Text(
                            state.profile.nickname,
                            style: TextStyle(
                              color: BaseColor.warmGray700,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "(${state.profile.taggedNickname}으로 알려짐)",
                            style: TextStyle(
                              color: BaseColor.warmGray700,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'since ${DateParser.timeStampAsDate(state.profile.createdAtTs)}',
                            style: TextStyle(
                              color: BaseColor.warmGray700,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20.sp),
                          state.isFriend
                              ? GraySolidButton('친구 추가',
                                  onTap: action.onTapBeFriend)
                              : GraySolidButton('친구 삭제',
                                  onTap: action.onTapBreakFriend),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
