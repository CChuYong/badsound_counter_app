import 'package:badsound_counter_app/designsystem/component/safe_area_with_padding.dart';
import 'package:badsound_counter_app/feature/main_screen/main_screen_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_screen_chat_box.dart';
import 'main_screen_stat_box.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
