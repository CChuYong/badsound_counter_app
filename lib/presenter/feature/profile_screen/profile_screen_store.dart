import 'dart:developer';

import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen/profile_screen_state.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';

class ProfileScreenAction extends BaseAction<ProfilePage, ProfileScreenAction, ProfileScreenState> {
  final UserRepository userRepository = inject<UserRepository>();
  ProfileScreenAction() : super(
    StateStore.loadState(ProfileScreenState)?.let(ProfileScreenState.fromJson) ?? ProfileScreenState('', ''));

  @override
  void dispose() {
    log('save state');
    StateStore.saveState(ProfileScreenState, state.toJson());
  }

  @override
  Future<ProfileScreenState> initState() async {
    final retrievedData = await userRepository.getMe();
    return ProfileScreenState(retrievedData.nickname, DateParser.timeStampAsDate(retrievedData.createdAtTs));
  }
}
