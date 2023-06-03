import 'dart:async';

import 'package:badsound_counter_app/feature/login_screen.dart/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      //Navigator.pushNamed(context, 'login');
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: BaseColor.warmGray200,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 100.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
            ),
          )
        )
        );
  }
}
