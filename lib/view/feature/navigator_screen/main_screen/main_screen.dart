import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/main_screen/main_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/safe_area_with_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_screen_top_bar.dart';
import 'main_screen_chat_box.dart';
import 'main_screen_stat_box.dart';

class MainPage extends BaseView<MainPage, MainScreenAction, MainScreenState> {
  const MainPage({super.key});

  @override
  MainScreenAction initAction() => MainScreenAction();

  @override
  Widget render(BuildContext context, MainScreenAction action, MainScreenState state) {
    return SafeAreaWithPadding(
        child: Column(children: [
          SizedBox(height: 5.sp),
          MainPageTopBar(),
          SizedBox(height: 20.sp),
          MainPageStatBox(),
          SizedBox(height: 20.sp),
          Expanded(child: MainPageChatBox()),
        ]));
  }
}
