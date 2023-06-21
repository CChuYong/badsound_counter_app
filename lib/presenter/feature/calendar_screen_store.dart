import 'package:badsound_counter_app/core/api/model/friend_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/designsystem/component/mini_info_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiver/collection.dart';

import '../../view/designsystem/theme/base_color.dart';
import '../../view/feature/navigator_screen/social_screen/social_sceren.dart';

class SocialScreenState {
  TreeSet<User> friendSet = TreeSet<User>(
      comparator: (a, b) {
        if(a.userId == b.userId) return 0;
        return b.nickname.compareTo(a.nickname);
      }
  );
}

class SocialScreenAction extends BaseAction<SocialScreen,
    SocialScreenAction, SocialScreenState> {
  SocialScreenAction() : super(SocialScreenState());

  final OpenAPI openAPI = inject<OpenAPI>();

  @override
  Future<SocialScreenState> initState() async {
    await updateFriends();
    return state;
  }

  Future<void> updateFriends() async {
    final friends = await openAPI.getMyFriends();
    setState(() {
      state.friendSet.addAll(friends.map((e) => e.toModel()));
    });
  }

  Future<void> addFriend() async {
    final textController = TextEditingController();
    Get.defaultDialog(
      title: '',
      content: Padding(
          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
          child: Column(
            children: [
              const Text('친구 추가하기'),
              SizedBox(height: 10.sp),
              TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '친구 닉네임태그',
                  )),
              SizedBox(height: 4.sp),
              MiniInfoMessage('닉네임#태그 형식이에요!', size: 12.sp),
            ],
          )),
      middleText: 'gelllel',
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(fontSize: 0),
      middleTextStyle: const TextStyle(color: BaseColor.warmGray800),
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: () {},
      onCancel: () {},
      contentPadding: EdgeInsets.only(bottom: 15.sp),
      confirm: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: BaseColor.warmGray300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.sp)),
          ),
          child: const Text(
            '취소하기',
            style: TextStyle(color: BaseColor.warmGray400),
          ),
          onPressed: () {
            Get.back();
          }),
      cancel: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: BaseColor.warmGray200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.sp)),
          ),
          child: const Text(
            '추가하기',
            style: TextStyle(color: BaseColor.warmGray500),
          ),
          onPressed: () async {
            try{
              await openAPI.createFriend(FriendRequest(textController.text));
            }finally {
              Get.back();
              await updateFriends();
            }
          }),
    );
  }
}
