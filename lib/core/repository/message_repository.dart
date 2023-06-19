import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MessageRepository {
  late Database database;
  final String tableName = "messages";

  MessageRepository() {
    open();
  }

  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'messages.db');

    database = await openDatabase(
      path,
      version: 1,
    );

    database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        message_id TEXT PRIMARY KEY,
        room_id TEXT NOT NULL,
        content TEXT NOT NULL,
        sender_id TEXT NOT NULL,
        sender_nickname TEXT NOT NULL,
        sender_profile_img TEXT NOT NULL,
        violent_price INTEGER NOT NULL,
        created_at LONG NOT NULL
      )
    ''');

    database.execute('''
      CREATE INDEX IF NOT EXISTS messages_idx1 ON $tableName (room_id)
    ''');
  }

  Future<void> persist(Chat chat) async {
    await database.insert(
      tableName,
      {
        'message_id': chat.messageId,
        'room_id': chat.roomId,
        'content': chat.content,
        'sender_id': chat.senderId,
        'sender_nickname': chat.senderNickname,
        'sender_profile_img': chat.senderProfileImg,
        'violent_price': chat.violentPrice,
        'created_at': chat.createdAtTs
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Chat>> getMessagesByRoom(String roomId) async {
    final result = await database
        .rawQuery('SELECT * FROM $tableName WHERE room_id = ?', [roomId]);
    return result
        .map((e) => Chat(
            e["message_id"] as String,
            e["room_id"] as String,
            e["content"] as String,
            e["sender_id"] as String,
            e["sender_nickname"] as String,
            e["sender_profile_img"] as String,
            e["violent_price"] as int,
            e["created_at"] as int))
        .toList();
  }
}
