import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/calendar_screen_store.dart';
import 'package:badsound_counter_app/view/designsystem/component/safe_area_with_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: Center(
      child: Text(
        '준비중이에요!',
        style: TextStyle(
          color: BaseColor.warmGray700,
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    ));
  }
}
