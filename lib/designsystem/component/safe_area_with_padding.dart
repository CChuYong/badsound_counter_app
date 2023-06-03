import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafeAreaWithPadding extends StatelessWidget {
  final Widget child;

  const SafeAreaWithPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: SizedBox(
              height: double.infinity,
              child: child,
            )));
  }
}
