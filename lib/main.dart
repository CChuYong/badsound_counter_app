import 'package:badsound_counter_app/view/feature/calendar_screen/calendar_screen.dart';
import 'package:badsound_counter_app/view/feature/login_screen.dart/login_screen.dart';
import 'package:badsound_counter_app/view/feature/main_screen/main_screen.dart';
import 'package:badsound_counter_app/view/feature/profile_screen/profile_screen.dart';
import 'package:badsound_counter_app/view/feature/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/feature/main_navigator.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, widget) => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: 'Pretendard',
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: 'splash',
              routes: {
                'navigator': (builder) => const MainNavigator(
                      defaultPageNumber: 1,
                      pages: [
                        CalendarPage(),
                        MainPage(),
                        ProfilePage(),
                      ],
                    ),
                'splash': (builder) => const SplashScreen(),
                'login': (builder) => const LoginScreen()
              },
        )
    );
  }
}
