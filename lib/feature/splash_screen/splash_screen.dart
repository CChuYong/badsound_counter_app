import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {Navigator.pushNamed(context, 'navigator')},
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: BaseColor.warmGray50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      BaseIcon.logo,
                      color: BaseColor.warmGray500,
                      size: 24.sp,
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      '나쁜말 카운터',
                      style: TextStyle(
                        color: BaseColor.warmGray500,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
