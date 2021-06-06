import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/event.dart';
import 'package:flutter_sample/models/participant.dart';
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
            '(id INTEGER PRIMARY KEY, event_id INTEGER, member_id INTEGER, UNIQUE(event_id, member_id));');
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

  Future<List<Participant>> findAllParticipantByEventId(int eventId) async {
    final list = await (await _database).rawQuery(
      'SELECT participant.id, member.name FROM participant '
      'INNER JOIN member ON participant.member_id=member.id where participant.event_id=${eventId.toString()}',
    );
    return list.map((m) => Participant.of(m)).toList();
  }

  void replaceParticipant(int eventId, List<int> memberIds) async {
    final batch = (await _database).batch();
    memberIds.forEach((memberId) {
      batch.insert('participant', {'event_id': eventId, 'member_id': memberId},
          conflictAlgorithm: ConflictAlgorithm.ignore);
    });
    batch.delete('participant',
        where: 'event_id=? AND member_id NOT IN (${memberIds.join(',')})',
        whereArgs: [eventId]);
    await batch.commit(noResult: true);
  }

  Future<List<BillingDetails>> findAllBillingDetails(int eventId) async {
    final list = await (await _database).rawQuery(
      'SELECT b.id, b.participant_id, m.name, b.category, b.amount FROM billing_detail AS b '
      'JOIN participant AS p ON p.id=b.participant_id '
      'JOIN member AS m ON m.id=p.member_id '
      'WHERE p.event_id = ${eventId.toString()}',
    );
    return list.map((m) => BillingDetails.of(m)).toList();
  }

  Future<int> insertBillingDetails(BillingDetails billingDetails) async {
    return (await _database).insert('billing_detail', billingDetails.toMap());
  }

  Future<int> deleteBillingDetails(int id) async {
    return (await _database)
        .delete('billing_detail', where: 'id=?', whereArgs: [id]);
  }
}
