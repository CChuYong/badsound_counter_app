import 'package:badsound_counter_app/designsystem/component/safe_area_with_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
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
