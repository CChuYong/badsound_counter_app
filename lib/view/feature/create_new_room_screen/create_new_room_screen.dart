import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/create_new_room_screen/create_new_room_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/base_top_bar.dart';
import 'package:badsound_counter_app/view/designsystem/component/gray_rounded_button.dart';
import 'package:badsound_counter_app/view/designsystem/component/title_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presenter/feature/create_new_room_screen/create_new_room_screen_state.dart';
import '../../designsystem/theme/base_color.dart';

class CreateNewRoomScreen extends BaseView<CreateNewRoomScreen,
    CreateNewRoomScreenAction, CreateNewRoomScreenState> {
  CreateNewRoomScreen({super.key});

  @override
  CreateNewRoomScreenAction initAction() => CreateNewRoomScreenAction();

  @override
  Widget render(BuildContext context, CreateNewRoomScreenAction action,
      CreateNewRoomScreenState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: BaseColor.defaultBackgroundColor,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: BaseColor.defaultBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BaseTopBar('방 생성하기', border: null),
            Padding(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
              child: Column(
                children: [
                  Container(
                    width: 82.sp,
                    height: 82.sp,
                    decoration: BoxDecoration(
                      color: BaseColor.warmGray700,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.profileImageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  TitleTextBox('방 제목',
                      hint: '여기에 방 제목을 입력하세요',
                      controller: action.roomTitleController),
                  SizedBox(height: 12.sp),
                  GrayRoundedButton('생성하기', onTap: action.createRoom)
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
