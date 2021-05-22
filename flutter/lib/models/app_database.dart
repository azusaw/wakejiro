import 'package:flutter_sample/models/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class AppDatabase {
  Database db;

  AppDatabase() {
    init();
  }

  void init() async {
    final path = join(await getDatabasesPath(), "database.db");
    db = await openDatabase(
      path,
      version: 1,
      // DBがpathに存在しなかった場合に onCreateメソッドが呼ばれる
      onCreate: (Database newDb, int version) {
        newDb.execute("CREATE TABLE IF NOT EXISTS event "
            "(id INTEGER PRIMARY KEY, name TEXT, date TEXT);"
            "CREATE TABLE IF NOT EXISTS member "
            "(id INTEGER PRIMARY KEY, name TEXT);"
            "CREATE TABLE IF NOT EXISTS payment "
            "(id INTEGER PRIMARY KEY, from_member INTEGER, to_member INTEGER, amount INTEGER)");
      },
    );
  }

  Future<int> insertEvent(Event event) async {
    return await db.insert("event", event.toMap());
  }

  Future<void> showEvents() async {
    final List<Map<String, dynamic>> list = await db.query("event");
    list.forEach((element) {
      print(element);
    });
  }
}
