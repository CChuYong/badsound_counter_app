import 'package:badsound_counter_app/view/feature/navigator_screen/calendar_screen/calendar_screen.dart';
import 'package:badsound_counter_app/view/feature/login_screen.dart/login_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';
import 'package:badsound_counter_app/view/feature/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import 'view/feature/navigator_screen/main_navigator.dart';
import 'dependencies.config.dart' as di;



@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => di.init();

void main() {
  configureDependencies();
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
                'login': (builder) => LoginScreenV2()
              },
        )
    );
  }
}
