import 'dart:developer';

import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:injectable/injectable.dart';

import '../model/auth_token.dart';

@singleton
class AuthProvider {
  AuthToken? authToken =
      StateStore.loadState(AuthProvider)?.let(AuthToken.fromJson);

  bool isAuthenticated() => authToken != null;

  void authenticate(AuthToken token) {
    log('Authenticate succeed!');
    authToken = token;
    StateStore.saveState(AuthProvider, token.toJson());
  }

  void clearAuthentication() {
    log('Authenticate cleared!');
    authToken = null;
    StateStore.clear();
  }
}
