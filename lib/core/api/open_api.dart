import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/model/auth_result.dart';
import 'package:badsound_counter_app/core/api/model/dashboard_response.dart';
import 'package:retrofit/http.dart';

import 'package:dio/dio.dart';

import 'model/me_response.dart';
import 'model/refresh_request.dart';
part 'open_api.g.dart';

@RestApi(baseUrl: 'https://bsc.bearus.co/app')
abstract class OpenAPI {
  factory OpenAPI(Dio dio, {String baseUrl}) = _OpenAPI;

  @POST('/users/oauth')
  Future<AuthResult> authenticate(@Body() AuthRequest request);

  @POST('/users/refresh')
  Future<AuthResult> refresh(@Body() RefreshRequest request);

  @GET('/users/me')
  Future<MeResponse> getMe();

  @GET('/users/dashboard')
  Future<DashboardResponse> getDashboard();
}
