import 'package:flutter_sample/models/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var database = AppDatabase();

class AppDatabase {
  Database _db;

  Future<Database> get _database async {
    if (_db == null) {
      _db = await _init();
    }
    return _db;
  }

  Future<Database> _init() async {
    final path = join(await getDatabasesPath(), "database.db");

    // スキーマ変更時などは↓をコメントインしてDBをリセットする
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      // DBがpathに存在しなかった場合に onCreateメソッドが呼ばれる
      onCreate: (Database newDb, int version) {
        newDb.execute("CREATE TABLE IF NOT EXISTS event "
            "(id INTEGER PRIMARY KEY, name TEXT, date TEXT, liquidated INTEGER);"
            "CREATE TABLE IF NOT EXISTS member "
            "(id INTEGER PRIMARY KEY, name TEXT);"
            "CREATE TABLE IF NOT EXISTS participant "
            "(id INTEGER PRIMARY KEY, event_id INTEGER, member_id INTEGER);"
            "CREATE TABLE IF NOT EXISTS billing_detail "
            "(id INTEGER PRIMARY KEY, participant_id INTEGER, amount INTEGER, category INTEGER);"
            "CREATE TABLE IF NOT EXISTS liquidation "
            "(id INTEGER PRIMARY KEY, from_participant INTEGER, to_participant INTEGER, amount INTEGER)");
      },
    );
  }

  Future<int> insertEvent(Event event) async {
    return (await _database).insert("event", event.toMap());
  }

  Future<List<Event>> findAllEvents() async {
    final list = await (await _database).query("event");
    return list.map((m) => Event.of(m)).toList();
  }
}
