import 'package:badsound_counter_app/dependencies.config.dart';

import 'package:dio/dio.dart';

import '../model/auth_token.dart';


class AuthProvider {
  AuthToken? authToken;

  final dio = inject<Dio>();

  bool isAuthenticated() => authToken != null;

  void authenticate(AuthToken token){
   // dio.interceptors.
    authToken = token;
  }
}
