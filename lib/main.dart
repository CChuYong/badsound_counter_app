import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:badsound_counter_app/view/feature/login_screen.dart/login_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/social_screen/social_sceren.dart';
import 'package:badsound_counter_app/view/feature/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://8d4b4fed72054359b7e184ac00aef593@o4505441864908800.ingest.sentry.io/4505441866088448';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () =>  runApp(ScreenUtilInit(
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
                    SocialScreen(),
                    MainPage(),
                    ProfilePage(),
                  ],
                )),
          ],
        ))));
 ;
}
