import 'package:badsound_counter_app/core/api/api_interceptor.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/service/webview_service.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
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

  final interceptor = ApiInterceptor();
  dio.interceptors.add(interceptor);

  inject.registerSingleton(UserRepository());
}
