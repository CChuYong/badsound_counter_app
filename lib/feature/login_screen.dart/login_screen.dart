import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginScreen> {
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _loaded = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _loaded = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {Navigator.pushReplacementNamed(context, 'navigator')},
        child:
        Container(
            width: double.infinity,
            height: double.infinity,
            color: BaseColor.warmGray200,
            child: SafeArea(
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 800),
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: _loaded ? 50.sp : 100.sp, bottom: 10.sp),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
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
                        ),
                      ),
                      AnimatedOpacity(opacity: _loaded ? 1.0 : 0.0, duration: Duration(milliseconds: 800), child: Column(
                        children: [
                          Image.asset('assets/images/sign_in_with_apple_4x.png'),
                          SizedBox(height: 8.sp),
                          Image.asset('assets/images/sign_in_with_google_4x.png'),
                        ],
                      ))

                    ],
                  ),
                )

            )

        ));
  }
}
