import 'dart:collection';

import 'package:badsound_counter_app/core/api/open_api.dart';
import 'package:badsound_counter_app/core/model/user.dart';
import 'package:badsound_counter_app/core/state/user_store.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../presenter/feature/main_screen/main_screen_stat_box_state.dart';

class UserRepository {
  late Database database;
  final String tableName = "friends";
  final OpenAPI api = inject<OpenAPI>();
  final UserStore userStore = inject<UserStore>();
  final HashSet<User> friendsCache = HashSet();

  UserRepository() {
    open();
  }

  Future<void> truncate() async {
    await database.execute('''
      DELETE FROM $tableName
    ''');
  }

  Future<void> truncateFriend() async {
    await database.execute('''
      DELETE FROM ${tableName}_friend
    ''');
  }

  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'room_data.db');

    database = await openDatabase(
      path,
      version: 1,
    );

    database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        userId TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        nickname TEXT NOT NULL,
        createdAtTs LONG NOT NULL,
        profileImageUrl TEXT NOT NULL,
        taggedNickname TEXT NOT NULL
      )
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS ${tableName}_friend (
        userId TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        nickname TEXT NOT NULL,
        createdAtTs LONG NOT NULL,
        profileImageUrl TEXT NOT NULL,
        taggedNickname TEXT NOT NULL
      )
    ''');

    final myFriends = await _getFriends();
    friendsCache.addAll(myFriends);
  }

  List<User> getFriends() => friendsCache.toList();

  bool isFriend(User user) {
    friendsCache.forEach((element) {
      print(element.nickname);
    });
    return friendsCache.contains(user);
  }

  Future<List<User>> _getFriends() async {
    final result = await database.rawQuery('SELECT * FROM ${tableName}_friend', []);
    return result.map((json) {
      return User(
        userId: json['userId'] as String,
        email: json['email'] as String,
        nickname: json['nickname'] as String,
        createdAtTs: json['createdAtTs'] as int,
        profileImgUrl: json['profileImageUrl'] as String,
        taggedNickname: json['taggedNickname'] as String,
      );
    }).toList();
  }

  Future<void> saveFriends(List<User> friends) async {
    friendsCache.clear();
    friendsCache.addAll(friends);
    await truncateFriend();
    friends.forEach((friend) async {
      await database.rawInsert('''
        INSERT INTO ${tableName}_friend (
          userId,
          email,
          nickname,
          createdAtTs,
          profileImageUrl,
          taggedNickname
        ) VALUES (?, ?, ?, ?, ?, ?)
      ''', [
        friend.userId,
        friend.email,
        friend.nickname,
        friend.createdAtTs,
        friend.profileImgUrl,
        friend.taggedNickname,
      ]);
    });
  }

  Future<User> getMe() async {
    final data = await api.getMe();
    final retrievedMe = User(
      userId: data.id,
      nickname: data.nickname,
      email: data.email,
      createdAtTs: data.createdAtTs,
      profileImgUrl: data.profileImgUrl,
      taggedNickname: data.taggedNickname,
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
        data.weeklyPrice,
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
      profileImgUrl: pulledUser.profileImgUrl,
      taggedNickname: pulledUser.taggedNickname,
    );
    userStore.save(user);
    return user;
  }
}
