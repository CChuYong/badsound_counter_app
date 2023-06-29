import 'package:badsound_counter_app/core/api/model/friend_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/service/user_service.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen/profile_screen_state.dart';
import 'package:badsound_counter_app/view/designsystem/component/mini_info_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiver/collection.dart';

import '../../core/framework/state_store.dart';
import '../../view/designsystem/theme/base_color.dart';
import '../../view/feature/navigator_screen/social_screen/social_sceren.dart';

class SocialScreenState {
  String myTag;
  TreeSet<User> friendSet = TreeSet<User>(comparator: (a, b) {
    if (a.userId == b.userId) return 0;
    return b.nickname.compareTo(a.nickname);
  });

  TreeSet<User> friendRequests = TreeSet<User>(comparator: (a, b) {
    if (a.userId == b.userId) return 0;
    return b.nickname.compareTo(a.nickname);
  });
  TreeSet<User> sentFriendRequests = TreeSet<User>(comparator: (a, b) {
    if (a.userId ==b.userId) return 0;
    return b.nickname.compareTo(a.nickname);
  });

  SocialScreenState(this.myTag);
}

class SocialScreenAction
    extends BaseAction<SocialScreen, SocialScreenAction, SocialScreenState> {
  SocialScreenAction()
      : super(SocialScreenState(StateStore.loadState(ProfileScreenState)
                ?.letCatching(ProfileScreenState.fromJson)
                ?.taggedNickname ??
            '#')) {
    state.friendSet.addAll(inject<UserRepository>().friendsCache);
  }

  final OpenAPI openAPI = inject<OpenAPI>();
  final UserService userService = inject<UserService>();
  final UserRepository userRepository = inject<UserRepository>();

  @override
  Future<SocialScreenState> initState() async {
    state.myTag = (await userRepository.getCachedMe()).taggedNickname;
    await updateFriends();
    await updateRequests();
    return state;
  }

  @override
  void dispose() {
    final friends = state.friendSet.toList();
    userRepository.saveFriends(friends);
  }

  Future<void> updateFriends() async {
    final friends = await openAPI.getMyFriends();
    setState(() {
      state.friendSet.clear();
      state.friendSet.addAll(friends.map((e) => e.toModel()));
    });
  }

  Future<void> acceptFriendRequest(User user) async {
    await openAPI.acceptFriendRequest(FriendRequest(user.taggedNickname));
    await updateFriends();
    await updateRequests();
  }

  Future<void> denyFriendRequest(User user) async {
    await openAPI.denyFriendRequest(FriendRequest(user.taggedNickname));
    await updateFriends();
    await updateRequests();
  }

  Future<void> updateRequests() async {
    final friends = await openAPI.getMyFriendRequests();
    final sendRequests = await openAPI.getMySentFriendRequests();
    setState(() {
      state.friendRequests.clear();
      state.friendRequests.addAll(friends.map((e) => e.toModel()));

      state.sentFriendRequests.clear();
      state.sentFriendRequests.addAll(sendRequests.map((e) => e.toModel()));
    });
  }

  Future<void> addFriend() async {
    final textController = TextEditingController();
    defaultDialog(
      buttonText: '친구 추가하기',
        content: Padding(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Column(
          children: [
            Text('친구 추가하기',
                style: TextStyle(
                  color: BaseColor.warmGray600,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                )),
            SizedBox(height: 10.sp),
            TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임#태그',
                ),
                style: TextStyle(
                  color: BaseColor.warmGray600,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                )),
            SizedBox(height: 4.sp),
          ],
        )),
        onPerform: () async {
          try {
            Get.back();
            await openAPI
                .createFriendRequest(FriendRequest(textController.text));
          } finally {
            await updateFriends();
            await updateRequests();
          }
        }
    );
    return;
  }

  onTapFriend(User user) {
    userService.openUserProfilePage(user.userId);
  }
}
