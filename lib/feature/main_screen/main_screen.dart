import 'package:badsound_counter_app/designsystem/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_screen_chat_box.dart';
import 'main_screen_stat_box.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child:
      Column(children:
        [
          MainPageStatBox(),
          SizedBox(height: 20.sp),
          Expanded(child: MainPageChatBox()),
        ]
      )
    );
  }
}
