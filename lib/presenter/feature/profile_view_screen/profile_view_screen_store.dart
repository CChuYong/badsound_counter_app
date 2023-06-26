import 'package:badsound_counter_app/core/api/model/break_friend_request.dart';
import 'package:badsound_counter_app/core/api/model/friend_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/profile_view_screen/profile_view_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/model/user.dart';

class ProfileViewScreenState {
  final User profile;
  bool isFriend;

  ProfileViewScreenState(this.profile, this.isFriend);
}

class ProfileViewScreenAction extends BaseAction<ProfileViewScreen,
    ProfileViewScreenAction, ProfileViewScreenState> {
  ProfileViewScreenAction(ProfileViewScreenState state) : super(state);

  final OpenAPI openAPI = inject<OpenAPI>();

  @override
  Future<ProfileViewScreenState> initState() async => state;

  void onTapImageView() {
    setImagePreview(state.profile.profileImgUrl);
  }

  Future<void> onTapBreakFriend() async {
    confirmModal(content: '정말로 친구 목록에서 삭제할까요?', confirmText: '삭제하기', onConfirm: () async {
      await openAPI.breakFriend(BreakFriendRequest(state.profile.userId));
      setState(() {
        state.isFriend = false;
      });
      Get.back();
    });
  }

  Future<void> onTapBeFriend() async {
    await openAPI
        .createFriendRequest(FriendRequest(state.profile.taggedNickname));
    infoSnackBar(message: '친구 추가 요청을 보냈어요!');
  }
}
