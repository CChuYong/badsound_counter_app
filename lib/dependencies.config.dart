import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final di = GetIt.instance;

Future<void> init() async {
  final client = OpenAPI(Dio());
  di.registerSingleton(client);
}