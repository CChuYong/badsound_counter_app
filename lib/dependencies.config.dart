import 'package:badsound_counter_app/core/api/api_interceptor.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/repository/message_repository.dart';
import 'package:badsound_counter_app/core/repository/room_repository.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/service/auth_service.dart';
import 'package:badsound_counter_app/core/service/webview_service.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/core/state/push_store.dart';
import 'package:badsound_counter_app/core/state/user_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> init() async {
  final dio = Dio();
  final client = OpenAPI(dio);

  inject.registerSingleton(dio);
  inject.registerSingleton(client);
  inject.registerSingleton(AuthProvider());
  inject.registerSingleton(WebViewService());
  inject.registerSingleton(UserStore());
  inject.registerSingleton(PushStore());
  inject.registerSingleton(AuthService());
  inject.registerSingleton(MessageRepository());
  inject.registerSingleton(RoomRepository());

  final interceptor = ApiInterceptor();
  dio.interceptors.add(interceptor);

  inject.registerSingleton(UserRepository());
}
