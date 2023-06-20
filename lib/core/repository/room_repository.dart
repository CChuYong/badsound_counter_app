import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../api/model/room_detail_response.dart';

class RoomRepository {
  late Database database;
  final String tableName = "rooms";
  final Map<String, RoomDetailResponse> roomCache = {};

  RoomRepository() {
    open();
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

    final currentRooms = await getRooms();
    currentRooms.forEach((element) {
      roomCache[element.roomId] = element;
    });
  }

  List<RoomDetailResponse> getCachedRooms() {
    return roomCache.values.toList();
  }

  Future<RoomDetailResponse?> getRoomById(String roomId) async {
    final result = await database
        .rawQuery('SELECT * FROM $tableName WHERE room_id = ?', [roomId]);
    if (result.isNotEmpty) {
      return RoomDetailResponse.fromJson(result[0]);
    } else {
      return null;
    }
  }

  Future<List<RoomDetailResponse>> getRooms() async {
    final result = await database.rawQuery('SELECT * FROM $tableName', []);
    return result.map(RoomDetailResponse.fromJson).toList();
  }

  Future<void> persist(RoomDetailResponse roomDetailResponse) async {
    roomCache[roomDetailResponse.roomId] = roomDetailResponse;
    await database.insert(
      tableName,
      roomDetailResponse.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
