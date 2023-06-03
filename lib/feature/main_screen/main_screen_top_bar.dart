import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class MainPageTopBar extends StatelessWidget {
  const MainPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        BaseIcon.logo,
        color: BaseColor.warmGray500,
        size: 15.sp,
      ),
      SizedBox(width: 3.sp),
      Text(
        '나쁜말 카운터',
        style: TextStyle(
          color: BaseColor.warmGray500,
          fontSize: 13.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    ]);
  }
}
