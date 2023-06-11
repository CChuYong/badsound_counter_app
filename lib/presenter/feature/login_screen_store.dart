import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/auth_token.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../view/feature/login_screen.dart/login_screen.dart';

Future<AuthorizationCredentialAppleID> signInWithApple() async {
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  return appleCredential;
}

class LoginScreenState {
  bool isLoading;
  LoginState loginState;

  LoginScreenState({
    this.isLoading = true,
    this.loginState = LoginState.WAIT_FOR_LOGIN,
  });
}

enum LoginState {
  WAIT_FOR_LOGIN,
  LOGIN_SUCCEED;
}

class LoginScreenAction
    extends BaseAction<LoginScreenV2, LoginScreenAction, LoginScreenState> {
  LoginScreenAction() : super(LoginScreenState());

  final AuthProvider authProvider = inject<AuthProvider>();
  final OpenAPI openApi = inject<OpenAPI>();

  @override
  Future<LoginScreenState> initState() async {
    final state = LoginScreenState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        state.isLoading = false;
      });
    });
    return state;
  }

  void loginWithApple() async {
    setState(() {
      state.isLoading = true;
    });
    try {
      final authResult = await signInWithApple();
      final authenticateResult = await openApi.authenticate(AuthRequest(
          provider: 'APPLE', token: authResult.identityToken ?? ""));
      authProvider.authenticate(AuthToken(
        authenticateResult.accessToken,
        authenticateResult.refreshToken,
      ));
      setState(() {
        state.loginState = LoginState.LOGIN_SUCCEED;
        state.isLoading = false;
      });
      Get.offNamed('navigator');
    } catch (e) {
      log(e.toString());
      errorSnackBar(message: '알 수 없는 오류가 발생했어요');
      setState(() {
        state.loginState = LoginState.WAIT_FOR_LOGIN;
        state.isLoading = false;
      });
    }
  }

  void loginWithGoogle() async {}
}
