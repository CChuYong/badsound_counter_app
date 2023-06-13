import 'package:badsound_counter_app/core/api/model/refresh_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/auth_token.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class ApiInterceptor extends Interceptor {
  final AuthProvider authProvider = inject<AuthProvider>();
  final OpenAPI openAPI = inject<OpenAPI>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        '[REQ] [${options.method}] ${options.uri} ${authProvider.authToken?.accessToken}');

    if (authProvider.isAuthenticated()) {
      options.headers["X-BCA-APP-TOKEN"] = authProvider.authToken?.accessToken;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final isStatus401 = err.response?.statusCode == 401;
    if (isStatus401) {
      if (authProvider.isAuthenticated()) {
        // try refresh it
        try {
          final result = await openAPI.refresh(RefreshRequest(
              refreshToken: authProvider.authToken?.refreshToken ?? ''));
          authProvider
              .authenticate(AuthToken(result.accessToken, result.refreshToken));
        } catch (e) {
          //Refresh failure. invalidate authentication
          authProvider.clearAuthentication();
          g.Get.offNamed('/login');
        }
      }
    }
    return super.onError(err, handler);
  }
}
