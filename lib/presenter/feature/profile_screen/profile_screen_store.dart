import 'dart:developer';

import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/service/webview_service.dart';
import 'package:badsound_counter_app/core/state/auth_store.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen/profile_screen_state.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';
import 'package:badsound_counter_app/view/feature/webview_screen/full_webview_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreenAction extends BaseAction<ProfilePage, ProfileScreenAction, ProfileScreenState> {
  final UserRepository userRepository = inject<UserRepository>();
  final AuthProvider authProvider = inject<AuthProvider>();
  final WebViewService webViewService = inject<WebViewService>();
  ProfileScreenAction() : super(
    StateStore.loadState(ProfileScreenState)?.let(ProfileScreenState.fromJson) ?? ProfileScreenState('', ''));

  @override
  void dispose() {
    StateStore.saveState(ProfileScreenState, state.toJson());
  }

  @override
  Future<ProfileScreenState> initState() async {
    final retrievedData = await userRepository.getMe();
    return ProfileScreenState(retrievedData.nickname, DateParser.timeStampAsDate(retrievedData.createdAtTs));
  }

  void onPressMenu(ProfileScreenMenuType type) {
    switch(type) {
      case ProfileScreenMenuType.notice:
        log('notice');
        webViewService.navigateToNotice();
        break;
      case ProfileScreenMenuType.privacy:
        webViewService.navigateToPrivacy();
        break;
      case ProfileScreenMenuType.logout:
        log('logout');
        confirmModal(
            content: '정말 로그아웃 할까요?',
            confirmText: '로그아웃',
            onConfirm: ()  {
              log('logout');
              authProvider.clearAuthentication();
              Get.offNamed('/login');
            }
        );
        break;
      default:
        break;
    }
  }
}

enum ProfileScreenMenuType {
  notice,
  notification,
  settings,
  privacy,
  logout,
}
