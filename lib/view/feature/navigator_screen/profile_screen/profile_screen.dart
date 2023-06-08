import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/safe_area_with_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/date_parser.dart';
import '../../../designsystem/component/gray_solid_button.dart';
import '../../../designsystem/theme/base_color.dart';

class ProfilePage extends BaseView<ProfilePage, ProfileScreenAction, ProfileScreenState> {
  const ProfilePage({super.key});

  @override
  ProfileScreenAction initAction() => ProfileScreenAction();

  @override
  Widget render(BuildContext context, ProfileScreenAction action, ProfileScreenState state) {
    return SafeAreaWithPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 프로필',
              style: TextStyle(
                color: BaseColor.warmGray700,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 15.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 82.sp,
                      height: 82.sp,
                      decoration: const BoxDecoration(
                        color: BaseColor.warmGray700,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                    Text(
                      state.user.nickname,
                      style: TextStyle(
                        color: BaseColor.warmGray700,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'since ${DateParser.timeStampAsDate(state.user.createdAtTs)}',
                      style: TextStyle(
                        color: BaseColor.warmGray700,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                    Row(
                      children: [
                        const GraySolidButton('프로필 사진 변경'),
                        SizedBox(width: 10.sp),
                        GraySolidButton('닉네임 변경', onTap: () => {
                          Navigator.pushNamed(context, 'splash')
                        }),
                      ],
                    ),
                    const Divider(color: BaseColor.warmGray700)
                  ],
                )
              ],
            )
          ],
        ));
  }
}
