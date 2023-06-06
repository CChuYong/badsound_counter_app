import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final AuthProvider authProvider = inject<AuthProvider>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[REQ] [${options.method}] ${options.uri}');

    if(authProvider.isAuthenticated()) {
      options.headers["X-BCA-APP-TOKEN"] = authProvider.authToken?.accessToken;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final isStatus401 = err.response?.statusCode == 401;
    if(isStatus401) {
      if(authProvider.isAuthenticated()) {
        // try refresh it
      }
    }
    return super.onError(err, handler);
  }
}
