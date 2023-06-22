import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/create_new_room_screen/create_new_room_screen_store.dart';
import 'package:badsound_counter_app/view/component/touchableopacity.dart';
import 'package:badsound_counter_app/view/designsystem/component/gray_rounded_button.dart';
import 'package:badsound_counter_app/view/designsystem/component/title_text_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/model/user.dart';
import '../../../presenter/feature/create_new_room_screen/create_new_room_screen_state.dart';
import '../../../presenter/feature/update_notification_config/update_notification_config_store.dart';
import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class UpdateNotificationConfig extends BaseView<UpdateNotificationConfig,
    UpdateNotificationConfigAction, UpdateNotificationConfigState> {
  UpdateNotificationConfig({super.key});

  @override
  UpdateNotificationConfigAction initAction() => UpdateNotificationConfigAction();

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: BaseColor.defaultBackgroundColor,
      elevation: 0,
      title: Text(
        '알림 설정 변경하기',
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
  Widget render(BuildContext context, UpdateNotificationConfigAction action,
      UpdateNotificationConfigState state) {
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
                  ToggleableMenuElement('친구 관련 알림', '친구 추가, 요청 등의 알림을 보내드려요!', Icons.people, () => {}),
                  ToggleableMenuElement('나쁜말 알림', '누가 나쁜말을 했을때 알림을 보내드려요!', Icons.masks, () => {}),
                  ToggleableMenuElement('일반 채팅 알림', '나쁜말을 제외한 채팅의 알림을 보내드려요!', Icons.chat, () => {}),
                  ToggleableMenuElement('앱 관련 알림', '앱의 공지사항, 업데이트 등을 알려드려요!', Icons.phone_android, () => {})

                ],
              ),
            ),
          )),
    );
  }
}

class ToggleableMenuElement extends StatelessWidget {
  String text;
  String description;
  IconData icon;
  Function onTap;

  ToggleableMenuElement(this.text, this.description, this.icon, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => onTap(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 0.sp, top: 13.sp, bottom: 13.sp, right: 0.sp),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icon, size: 19.sp, color: BaseColor.warmGray500),
                        SizedBox(width: 12.sp),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                color: BaseColor.warmGray500,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                color: BaseColor.warmGray500,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                    ToggleSwitch(
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels: ['켜짐', '꺼짐'],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                      activeFgColor: BaseColor.warmGray200,
                      activeBgColor: [BaseColor.warmGray600],
                      inactiveFgColor: BaseColor.warmGray500,
                      inactiveBgColor: BaseColor.warmGray300,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
