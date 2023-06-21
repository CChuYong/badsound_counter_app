import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/base_color.dart';

class MiniInfoMessage extends StatelessWidget {
  final String message;
  final double size;
  const MiniInfoMessage(this.message, {this.size = 14, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info,
          color: BaseColor.warmGray600,
          size: size,
        ),
        SizedBox(width: 5.sp),
        Text(
          message,
          style: TextStyle(
            color: BaseColor.warmGray600,
            fontSize: size,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ],
    );
  }

}