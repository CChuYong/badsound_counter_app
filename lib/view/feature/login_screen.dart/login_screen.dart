import 'dart:developer';

import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/login_screen_store.dart';
import 'package:badsound_counter_app/view/component/touchableopacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';
import '../../designsystem/theme/base_icon.dart';

class LoginScreenV2 extends BaseView<LoginScreenV2, LoginScreenAction, LoginScreenState> {
  @override
  LoginScreenAction initAction() => LoginScreenAction();

  @override
  Widget render(BuildContext context, LoginScreenAction action,
      LoginScreenState state) {
    return
        Container(
            width: double.infinity,
            height: double.infinity,
            color: BaseColor.warmGray200,
            child: SafeArea(
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 800),
                  padding: EdgeInsets.only(left: 20.sp,
                      right: 20.sp,
                      top: !state.isLoading ? 50.sp : 100.sp,
                      bottom: 10.sp),
                  child: Column(
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
                      AnimatedOpacity(opacity: !state.isLoading ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 800),
                          child: Column(
                            children: [
                              TouchableOpacity(
                                  onTap: () => action.loginWithApple(),
                                  child: Image.asset(
                                  'assets/images/sign_in_with_apple_4x.png')
                              ),
                              SizedBox(height: 8.sp),
                              TouchableOpacity(
                                onTap: () => action.loginWithGoogle(),
                                child: Image.asset(
                                    'assets/images/sign_in_with_google_4x.png'),
                              ),
                            ],
                          ))

                    ],
                  ),
                )

            )

    );
  }

}
