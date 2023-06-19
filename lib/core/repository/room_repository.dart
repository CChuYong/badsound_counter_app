import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../api/model/room_detail_response.dart';

class RoomRepository {
  late Database database;
  final String tableName = "rooms";

  RoomRepository() {
    open();
  }

  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'rooms.db');

    database = await openDatabase(
      path,
      version: 1,
    );

    database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        room_id TEXT PRIMARY KEY,
        room_name TEXT NOT NULL,
        owner_id TEXT NOT NULL,
        created_at LONG NOT NULL,
        last_message_at LONG NOT NULL,
        unread_message_cnt INT NOT NULL
      )
    ''');
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
    await database.insert(
      tableName,
      roomDetailResponse.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
