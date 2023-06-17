import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/generic_error.dart';
import 'package:badsound_counter_app/core/api/model/refresh_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/auth_token.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_navigation/get_navigation.dart';

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
    } else{
      if(err.response != null) {
        final errorBody = GenericError.fromJson(err.response!.data);
        BaseAction.errorSnackBar(message: errorBody.message, margin: EdgeInsets.only(top: 20, left: 12, right: 12));
      }
      log(err.response?.data?.toString() ?? 'unknown dio error');
    }
    return super.onError(err, handler);
  }
}
