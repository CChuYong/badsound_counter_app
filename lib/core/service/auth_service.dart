import 'package:badsound_counter_app/core/api/model/device_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/core/state/push_store.dart';
import 'package:badsound_counter_app/core/util/device_info_util.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:get/get.dart';

import '../api/model/refresh_request.dart';
import '../model/auth_token.dart';

class AuthService {
  final authProvider = inject<AuthProvider>();
  final pushStore = inject<PushStore>();
  final openAPI = inject<OpenAPI>();

  Future<void> authenticate(AuthToken token) async {
    print("Try authenticating");
    //Phase 1: Store tokens
    authProvider.authenticate(token);
    //Phase 3: After loaded (fcm.. etc)
    await pushStore.initializeNotification();
    //Phase 4: Send device info to server
    if (pushStore.isPushAuthorized()) {
      openAPI.registerDevice(DeviceRequest(pushStore.token!, getDeviceInfo()));
    } else {
      print("Push not authorized!");
    }

    //Phase 2: Navigate Page
    final currentRoute = Get.currentRoute;
    if (currentRoute == '/' || currentRoute == '/login') {
      await Get.offNamed('navigator');
    }
  }

  Future<bool> refresh() async {
    try {
      print("Refreshing auth token..");
      final result = await openAPI.refresh(RefreshRequest(
          refreshToken: authProvider.authToken?.refreshToken ?? ''));
      authProvider
          .authenticate(AuthToken(result.accessToken, result.refreshToken));
      print("Refreshing auth token succeed..");
      return true;
    } catch (e) {
      print("Refreshing auth token failed.");
      //Refresh failure. invalidate authentication
      authProvider.clearAuthentication();
      await logout();
      return false;
    }
  }

  Future<void> logout() async {
    print("Logging out..");
    authProvider.clearAuthentication();
    await Get.offNamed('/login');
  }
}
