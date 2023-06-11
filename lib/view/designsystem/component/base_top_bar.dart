import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BaseTopBar extends StatelessWidget {
  final String title;
  const BaseTopBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            BaseIcon.arrowLeft,
            color: BaseColor.warmGray600,
            size: 16.sp,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: BaseColor.warmGray500,
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container()
      ],
    ));
  }

}

