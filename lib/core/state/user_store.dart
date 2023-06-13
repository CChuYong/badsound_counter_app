import '../model/user.dart';

class UserStore {
  final Map<String, User> users = {};
  User? me;

  void setMe(User user) {
    me = user;
  }

  User? getMe() => me;

  User? getUser(String userId) {
    return users[userId];
  }

  void save(User user) {
    users[user.userId] = user;
  }
}
