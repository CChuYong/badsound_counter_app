import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/dependencies.config.dart';

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
}