import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/generic_error.dart';
import 'package:badsound_counter_app/core/api/model/refresh_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/auth_token.dart';
import 'package:badsound_counter_app/core/service/auth_service.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_navigation/get_navigation.dart';

class ApiInterceptor extends Interceptor {
  final AuthProvider authProvider = inject<AuthProvider>();
  final AuthService authService = inject<AuthService>();
  final OpenAPI openAPI = inject<OpenAPI>();
  final Dio dio = inject<Dio>();

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
        final refreshResult = await authService.refresh();
        if(refreshResult) {
          // Re-Request when refresh succeed
          var response = await dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
          );
          return handler.resolve(response);
        }
      }
    } else{
      if(err.response != null) {
        final errorBody = GenericError.fromJson(err.response!.data);
        BaseAction.errorSnackBar(message: errorBody.message, margin: EdgeInsets.only(top: 20, left: 12, right: 12));
      }
      log(err.response?.data?.toString() ?? 'unknown dio error');
    }
    return handler.next(err);
  }
}
