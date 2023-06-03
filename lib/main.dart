import 'package:badsound_counter_app/feature/calendar_screen/calendar_screen.dart';
import 'package:badsound_counter_app/feature/main_screen/main_screen.dart';
import 'package:badsound_counter_app/feature/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'designsystem/layout/main_navigator.dart';

void main() {
  runApp(const MyApp());
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
              home: const MainNavigator(
                defaultPageNumber: 1,
                pages: [
                  CalendarPage(),
                  MainPage(),
                  ProfilePage(),
                ],
              ),
            ));
  }
}
