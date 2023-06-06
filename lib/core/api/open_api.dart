import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/model/auth_result.dart';
import 'package:retrofit/http.dart';

import 'package:dio/dio.dart';
part 'open_api.g.dart';

@RestApi(baseUrl: 'http://192.168.1.49:8080/app')
abstract class OpenAPI {
  factory OpenAPI(Dio dio, {String baseUrl}) = _OpenAPI;

  @POST('/users/oauth')
  Future<AuthResult> authenticate(@Body() AuthRequest request);
}
