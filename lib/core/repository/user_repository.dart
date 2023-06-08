import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/dependencies.config.dart';

class UserRepository {
  final OpenAPI api = inject<OpenAPI>();

  Future<User> getMe() async {
    final data = await api.getMe();
    return User(
      userId: data.id,
      nickname: 'after-load',
      email: data.email,
      createdAtTs: 0
    );
  }
}