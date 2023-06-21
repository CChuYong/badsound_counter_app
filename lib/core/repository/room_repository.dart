import 'package:badsound_counter_app/core/model/room.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../api/model/room_detail_response.dart';

class RoomRepository {
  late Database database;
  final String tableName = "rooms";
  final Map<String, Room> roomCache = {};

  RoomRepository() {
    open();
  }

  Future<void> truncate() async {
    roomCache.clear();
    database.execute('''
      TRUNCATE TABLE $tableName
    ''');
    database.execute('''
      TRUNCATE TABLE ${tableName}_selected_user
    ''');
  }

  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'room.db');

    database = await openDatabase(
      path,
      version: 1,
    );

    database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        roomId TEXT PRIMARY KEY,
        roomName TEXT NOT NULL,
        ownerId TEXT NOT NULL,
        createdAtTs LONG NOT NULL,
        lastMessageAtTs LONG NOT NULL,
        unreadMessageCount INT NOT NULL,
        roomImageUrl TEXT NOT NULL
      )
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS ${tableName}_selected_user (
        roomId TEXT PRIMARY KEY,
        userId TEXT NOT NULL
      )
    ''');

    final currentRooms = await getRooms();
    currentRooms.forEach((element) {
      roomCache[element.roomId] = element;
    });
  }

  List<Room> getCachedRooms() {
    return roomCache.values.toList();
  }

  Future<String?> getSpeakerIdOfRoom(String roomID) async {
    final result = await database.rawQuery('SELECT userId FROM ${tableName}_selected_user WHERE roomId = ?', [roomID]);
    if (result.isNotEmpty) {
      return result[0]["userId"] as String;
    } else {
      return null;
    }
  }

  Future<Room?> getRoomById(String roomId) async {
    final result = await database
        .rawQuery('SELECT * FROM $tableName WHERE room_id = ?', [roomId]);
    if (result.isNotEmpty) {
      final json = result[0];
      return Room(
        json['roomId'] as String,
        json['roomName'] as String,
        json['ownerId'] as String,
        json['createdAtTs'] as int,
        json['lastMessageAtTs'] as int,
        json['unreadMessageCount'] as int,
        json['roomImageUrl'] as String,
      );
    } else {
      return null;
    }
  }

  Future<List<Room>> getRooms() async {
    final result = await database.rawQuery('SELECT * FROM $tableName', []);
    return result.map((json) {
      return Room(
        json['roomId'] as String,
        json['roomName'] as String,
        json['ownerId'] as String,
        json['createdAtTs'] as int,
        json['lastMessageAtTs'] as int,
        json['unreadMessageCount'] as int,
        json['roomImageUrl'] as String,
      );
    }).toList();
  }

  Future<void> persist(Room room) async {
    roomCache[room.roomId] = room;
    await database.insert(
      tableName,
      {
        'roomId': room.roomId,
        'roomName': room.roomName,
        'ownerId': room.ownerId,
        'createdAtTs': room.createdAtTs,
        'lastMessageAtTs': room.lastMessageAtTs,
        'unreadMessageCount': room.unreadMessageCount,
        'roomImageUrl': room.roomImageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> setSpeakerIdOfRoom(String roomId, String speakerId) async {
    await database.insert('${tableName}_selected_user', {
      'roomId': roomId,
      'userId': speakerId,
    },
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}
