import 'dart:developer';

import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';

class ProfileScreenState{
  User user;
  ProfileScreenState(this.user);
}

class ProfileScreenAction extends BaseAction<ProfilePage, ProfileScreenAction, ProfileScreenState> {
  final UserRepository userRepository = inject<UserRepository>();
  ProfileScreenAction() : super(
      ProfileScreenState(
          StateStore.loadState(User)?.let(User.fromJson) ??
    User(
      userId: '',
      nickname: 'before-load',
      email: '',
      createdAtTs: 0
    ),
  ));

  @override
  void dispose() {
    log('save state');
    StateStore.saveState(User, state.user.toJson());
  }

  @override
  Future<ProfileScreenState> initState() async => ProfileScreenState(await userRepository.getMe());
}
