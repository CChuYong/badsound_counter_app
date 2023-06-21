import 'dart:developer';

import 'package:badsound_counter_app/core/api/model/upload_request.dart';
import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/service/auth_service.dart';
import 'package:badsound_counter_app/core/service/webview_service.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/presenter/feature/profile_screen/profile_screen_state.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import '../../../core/api/model/user_nickname_request.dart';
import '../../../view/designsystem/theme/base_color.dart';

class ProfileScreenAction
    extends BaseAction<ProfilePage, ProfileScreenAction, ProfileScreenState> {
  final UserRepository userRepository = inject<UserRepository>();
  final AuthService authService = inject<AuthService>();
  final WebViewService webViewService = inject<WebViewService>();
  final OpenAPI openAPI = inject<OpenAPI>();
  final Dio dio = inject<Dio>();

  ProfileScreenAction()
      : super(StateStore.loadState(ProfileScreenState)
                ?.let(ProfileScreenState.fromJson) ??
            ProfileScreenState('', '', '', '#'));

  @override
  void dispose() {
    StateStore.saveState(ProfileScreenState, state.toJson());
  }

  @override
  Future<ProfileScreenState> initState() async {
    log('loading profile');
    final retrievedData = await userRepository.getMe();
    return ProfileScreenState(
        retrievedData.nickname,
        DateParser.timeStampAsDate(retrievedData.createdAtTs),
        retrievedData.profileImgUrl,
        retrievedData.taggedNickname
    );
  }

  void onTapSelectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final mimeType = lookupMimeType(image.path);
    final imageRequest = await openAPI.requestProfileImageUpload();

    final bytes = await image.readAsBytes();
    await dio.request(imageRequest.uploadUrl, data: bytes,
        options: Options(method: 'PUT', headers: {'Content-Type': mimeType}));

    final newMe = await openAPI.updateProfileImage(UploadRequest(imageRequest.downloadUrl));
    infoSnackBar(message: '업로드에 성공했어요!');
    setState(() {
      state.profileImageUrl = newMe.profileImgUrl;
    });
  }

  void updateNickname() {
    final textController = TextEditingController();
    Get.defaultDialog(
      title: '',
      content: Padding(
          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
          child: Column(
            children: [
              const Text('닉네임 변경하기'),
              SizedBox(height: 10.sp),
              TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '새로운 닉네임',
                  ))
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
            '변경하기',
            style: TextStyle(color: BaseColor.warmGray500),
          ),
          onPressed: () {
            openAPI
                .updateNickname(UserNicknameRequest(textController.text))
                .then((value) {
              onReady();
              Get.back();
              infoSnackBar(message: '닉네임을 성공적으로 변경했어요!');
            });
          }),
    );
  }

  void onPressMenu(ProfileScreenMenuType type) {
    switch (type) {
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
            onConfirm: () {
              authService.logout();
            });
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
