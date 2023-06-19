import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/auth_token.dart';
import 'package:badsound_counter_app/core/service/auth_service.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

Future<GoogleSignInAuthentication?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  return await googleUser?.authentication;
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

  //final AuthProvider authProvider = inject<AuthProvider>();
  final AuthService authService = inject<AuthService>();
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
      await authService.authenticate(AuthToken(
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
      BaseAction.errorSnackBar(message: '알 수 없는 오류가 발생했어요');
      setState(() {
        state.loginState = LoginState.WAIT_FOR_LOGIN;
        state.isLoading = false;
      });
    }
  }

  void loginWithGoogle() async {
    setState(() {
      state.isLoading = true;
    });
    try {
      final authResult = await signInWithGoogle();
      if (authResult == null) throw Error();
      log(authResult.accessToken ?? '');
      final authenticateResult = await openApi.authenticate(
          AuthRequest(provider: 'GOOGLE', token: authResult.accessToken ?? ""));
      await authService.authenticate(AuthToken(
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
      BaseAction.errorSnackBar(message: '알 수 없는 오류가 발생했어요');
      setState(() {
        state.loginState = LoginState.WAIT_FOR_LOGIN;
        state.isLoading = false;
      });
    }
  }
}
