import 'package:flutter/material.dart';

class Event {
  Event({
    @required this.date,
    @required this.name,
    @required this.liquidated,
  });

  DateTime date;
  String name;
  bool liquidated;

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'name': name,
      'isAlreadyPaid': liquidated,
    };
  }
}
