import 'package:flutter_sample/models/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'member.dart';

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
    final path = join(await getDatabasesPath(), 'database.db');

    // スキーマ変更時などは↓をコメントインしてDBをリセットする
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      // DBがpathに存在しなかった場合に onCreateメソッドが呼ばれる
      onCreate: (Database newDb, int version) async {
        await newDb.execute('CREATE TABLE IF NOT EXISTS event '
            '(id INTEGER PRIMARY KEY, name TEXT, date TEXT, liquidated INTEGER);');
        await newDb.execute('CREATE TABLE IF NOT EXISTS member '
            '(id INTEGER PRIMARY KEY, name TEXT UNIQUE);');
        await newDb.execute('CREATE TABLE IF NOT EXISTS participant '
            '(id INTEGER PRIMARY KEY, event_id INTEGER, member_id INTEGER);');
        await newDb.execute('CREATE TABLE IF NOT EXISTS billing_detail '
            '(id INTEGER PRIMARY KEY, participant_id INTEGER, amount INTEGER, category INTEGER);');
        await newDb.execute('CREATE TABLE IF NOT EXISTS liquidation '
            '(id INTEGER PRIMARY KEY, from_participant INTEGER, to_participant INTEGER, amount INTEGER)');
      },
    );
  }

  Future<List<Event>> findAllEvents() async {
    final list = await (await _database).query('event');
    return list.map((m) => Event.of(m)).toList();
  }

  Future<int> insertEvent(Event event) async {
    return (await _database).insert('event', event.toMap());
  }

  Future<int> updateEvent(Event event) async {
    return (await _database)
        .update('event', event.toMap(), where: 'id=?', whereArgs: [event.id]);
  }

  Future<int> deleteEvent(int id) async {
    return (await _database).delete('event', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Member>> findAllMembers() async {
    final list = await (await _database).query('member');
    return list.map((m) => Member.of(m)).toList();
  }

  Future<int> insertMember(Member member) async {
    return (await _database).insert('member', member.toMap());
  }

  Future<int> deleteMember(int id) async {
    return (await _database).delete('member', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Member>> findAllParticipantByEventId(int eventId) async {
    final query = [eventId.toString()];
    final list = await (await _database).rawQuery(
        'SELECT member.id, member.name from participant inner join member on participant.member_id = member.id where participant.event_id=?;',
        query);
    return list.map((m) => Member.of(m)).toList();
  }

  Future<int> insertParticipant(int eventId, int memberId) async {
    return (await _database)
        .insert('participant', {'event_id': eventId, 'member_id': memberId});
  }

  Future<int> deleteParticipant(int id) async {
    return (await _database)
        .delete('participant', where: 'id=?', whereArgs: [id]);
  }
}
