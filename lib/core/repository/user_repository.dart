import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/util/currency_parser.dart';
import 'package:badsound_counter_app/dependencies.config.dart';

import '../../presenter/feature/main_screen/main_screen_stat_box_state.dart';

class UserRepository {
  final OpenAPI api = inject<OpenAPI>();

  Future<User> getMe() async {
    final data = await api.getMe();
    return User(
      userId: data.id,
      nickname: data.nickname,
      email: data.email,
      createdAtTs: data.createdAtTs,
    );
  }

  Future<MainPageStatBoxState> getDashboard() async {
    final data = await api.getDashboard();
    return MainPageStatBoxState(
        '${CurrencyParser.format(data.weeklyPrice)}원',
        '${data.currentMonth}월 ${data.currentWeek}주차 합산',
        '${data.currentMonth}/${data.weekStartDay} ~ ${data.currentMonth}/${data.weekEndDay} 사이의 내역이에요!');
  }
}
