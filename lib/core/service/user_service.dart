import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/profile_view_screen/profile_view_screen.dart';
import 'package:get/get.dart';

import '../../presenter/feature/profile_view_screen/profile_view_screen_store.dart';

class UserService {
  final repository = inject<UserRepository>();

  Future<void> openUserProfilePage(String userId) async {
    final profile = await repository.getUserOrPull(userId);
    final state = ProfileViewScreenState(profile, repository.isFriend(profile));
    Get.to(() => ProfileViewScreen(state));
  }
}
