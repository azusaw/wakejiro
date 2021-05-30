import 'package:flutter/material.dart';

class Event {
  Event({
    this.id,
    @required this.date,
    @required this.name,
    @required this.liquidated,
  });

  int id;
  DateTime date;
  String name;
  bool liquidated;

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'date': date.toString(),
      'name': name,
      'liquidated': liquidated ? 1 : 0,
    };
  }

  static Event of(Map<String, dynamic> m) => Event(
      id: m['id'],
      name: m['name'],
      date: DateTime.parse(m['date']),
      liquidated: m['liquidated'] == 1);

  @override
  String toString() {
    return "$id, $name, $date, $liquidated";
  }
}
