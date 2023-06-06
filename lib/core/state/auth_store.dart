import 'package:injectable/injectable.dart';

import '../model/auth_token.dart';


@singleton
class AuthProvider {
  AuthToken? authToken;

  bool isAuthenticated() => authToken != null;

  void authenticate(AuthToken token){
    authToken = token;
  }

  void clearAuthentication() {
    authToken = null;
  }
}
