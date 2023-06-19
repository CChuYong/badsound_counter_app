import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:badsound_counter_app/view/feature/login_screen.dart/login_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/calendar_screen/calendar_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';
import 'package:badsound_counter_app/view/feature/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import 'dependencies.config.dart' as di;
import 'firebase_options.dart';
import 'view/feature/navigator_screen/main_navigator.dart';

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => di.init();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await StateStore.init();
  configureDependencies();
  runApp(ScreenUtilInit(
      builder: (context, widget) => GetMaterialApp(
            // home: const MyApp(),
            theme: ThemeData(
              fontFamily: 'Pretendard',
              colorScheme:
                  ColorScheme.fromSeed(seedColor: BaseColor.defaultGreen),
              useMaterial3: true,
            ),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => SplashScreen()),
              GetPage(name: '/login', page: () => LoginScreenV2()),
              GetPage(
                  name: '/navigator',
                  page: () => const MainNavigator(
                        pages: [
                          CalendarPage(),
                          MainPage(),
                          ProfilePage(),
                        ],
                      )),
            ],
          )));
}
