import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../model/auth_token.dart';


@singleton
class AuthProvider {
  AuthToken? authToken;

  bool isAuthenticated() => authToken != null;

  void authenticate(AuthToken token){
    log('Authenticate succeed!');
    authToken = token;
  }

  void clearAuthentication() {
    log('Authenticate cleared!');
    authToken = null;
  }
}
