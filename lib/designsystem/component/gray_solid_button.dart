import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/base_color.dart';

class GraySolidButton extends StatelessWidget {
  final String text;

  const GraySolidButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.sp),
          color: BaseColor.warmGray100,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 8.sp, bottom: 8.sp, left: 30.sp, right: 30.sp),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: BaseColor.warmGray400,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ));
  }
}
