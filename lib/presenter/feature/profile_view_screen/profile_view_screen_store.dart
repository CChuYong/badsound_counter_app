import 'package:badsound_counter_app/core/api/model/break_friend_request.dart';
import 'package:badsound_counter_app/core/api/model/friend_request.dart';
import 'package:badsound_counter_app/core/api/model/me_response.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/profile_view_screen/profile_view_screen.dart';

import '../../../core/model/user.dart';

class ProfileViewScreenState {
  final User profile;
  bool isFriend;
  ProfileViewScreenState(this.profile, this.isFriend);
}

class ProfileViewScreenAction extends BaseAction<ProfileViewScreen, ProfileViewScreenAction, ProfileViewScreenState> {
  ProfileViewScreenAction(ProfileViewScreenState state) : super(state);

  final OpenAPI openAPI = inject<OpenAPI>();

  @override
  Future<ProfileViewScreenState> initState() async => state;

  void onTapImageView() {
    setImagePreview(state.profile.profileImgUrl);
  }

  Future<void> onTapBreakFriend() async {
    await openAPI.breakFriend(BreakFriendRequest(state.profile.userId));
    setState(() {
      state.isFriend = false;
    });
  }

  Future<void> onTapBeFriend() async {
    await openAPI.createFriendRequest(FriendRequest(state.profile.taggedNickname));
  }
}