import 'package:badsound_counter_app/core/api/model/me_response.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/profile_view_screen/profile_view_screen.dart';

import '../../../core/model/user.dart';

class ProfileViewScreenState {
  final User profile;
  final bool isFriend;
  ProfileViewScreenState(this.profile, this.isFriend);
}

class ProfileViewScreenAction extends BaseAction<ProfileViewScreen, ProfileViewScreenAction, ProfileViewScreenState> {
  ProfileViewScreenAction(ProfileViewScreenState state) : super(state);

  @override
  Future<ProfileViewScreenState> initState() async => state;

  void onTapImageView() {
    setImagePreview(state.profile.profileImgUrl);
  }
}