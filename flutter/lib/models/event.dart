import 'package:flutter/material.dart';

class Event {
  const Event({
    @required this.date,
    @required this.name,
    @required this.isAlreadyPaid,
  });

  final String date;
  final String name;
  final bool isAlreadyPaid;
}
