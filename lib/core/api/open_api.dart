import 'package:retrofit/http.dart';

import 'package:dio/dio.dart';

@RestApi(baseUrl: '')
class OpenAPI {
  final Dio dio;
  OpenAPI(this.dio);
}