import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/state/user_store.dart';
import 'package:badsound_counter_app/core/util/currency_parser.dart';
import 'package:badsound_counter_app/dependencies.config.dart';

import '../../presenter/feature/main_screen/main_screen_stat_box_state.dart';

class UserRepository {
  final OpenAPI api = inject<OpenAPI>();
  final UserStore userStore = inject<UserStore>();

  Future<User> getMe() async {
    final data = await api.getMe();
    final retrievedMe = User(
      userId: data.id,
      nickname: data.nickname,
      email: data.email,
      createdAtTs: data.createdAtTs,
      profileImgUrl: data.profileImgUrl,
    );
    return retrievedMe;
  }

  Future<User> getCachedMe() async {
    final cachedMe = userStore.getMe();
    if (cachedMe != null) return cachedMe;

    final retrievedMe = await getMe();
    userStore.setMe(retrievedMe);
    return retrievedMe;
  }

  Future<MainPageStatBoxState> getDashboard() async {
    final data = await api.getDashboard();
    return MainPageStatBoxState(
        CurrencyParser.format(data.weeklyPrice),
        '${data.currentMonth}월 ${data.currentWeek}주차 합산',
        '${data.currentMonth}/${data.weekStartDay} ~ ${data.currentMonth}/${data.weekEndDay} 사이의 내역이에요!');
  }

  Future<User> getUserOrPull(String userId) async {
    final cachedUser = userStore.getUser(userId);
    if (cachedUser != null) return cachedUser;

    final pulledUser = await api.getUserById(userId);
    final user = User(
        userId: pulledUser.id,
        email: pulledUser.email,
        nickname: pulledUser.nickname,
        createdAtTs: pulledUser.createdAtTs,
        profileImgUrl: pulledUser.profileImgUrl);
    userStore.save(user);
    return user;
  }
}
