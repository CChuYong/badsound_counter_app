import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen/profile_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/safe_area_with_padding.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/date_parser.dart';
import '../../../../presenter/feature/profile_screen/profile_screen_state.dart';
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
            SizedBox(height: 18.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      state.nickname,
                      style: TextStyle(
                        color: BaseColor.warmGray700,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'since ${state.since}',
                      style: TextStyle(
                        color: BaseColor.warmGray700,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const GraySolidButton('프로필 사진 변경'),
                            SizedBox(width: 10.sp),
                            GraySolidButton('닉네임 변경', onTap: () => {
                              Navigator.pushNamed(context, 'splash')
                            }),
                          ],
                        ),
                        Divider(),
                      ],
                    ),

                  ],
                )
              ],
            ),
            Divider(),
            SizedBox(height: 10.sp),
            Text(
              '설정',
              style: TextStyle(
                color: BaseColor.warmGray700,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.sp),

            ProfileMenuElement('공지사항', Icons.announcement),
            ProfileMenuElement('알림', Icons.notifications),
            ProfileMenuElement('환경설정', Icons.settings),
            ProfileMenuElement('개인정보처리방침', Icons.file_copy_sharp),
            ProfileMenuElement('로그아웃', Icons.logout),

          ],
        ));
  }
}

class ProfileMenuElement extends StatelessWidget {
  String text;
  IconData icon;
  ProfileMenuElement(this.text, this.icon, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 0.sp, top: 13.sp, bottom: 13.sp, right: 0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: 19.sp),
                  SizedBox(width: 12.sp),
                  Text(
                    text,
                    style: TextStyle(
                      color: BaseColor.warmGray700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
              Icon(BaseIcon.arrowRight, size: 10.sp)
            ],
          ),
        ),
      ],
    );
  }
}
