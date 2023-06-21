import 'dart:collection';

import 'package:badsound_counter_app/core/model/user.dart';

class CreateNewRoomScreenState {
  String profileImageUrl =
      'https://bsc-assets-public.s3.ap-northeast-2.amazonaws.com/default_profile.jpeg';
  HashMap<String, User> friendsMap = HashMap();
  HashSet<String> selectedUserIds = HashSet();
}
