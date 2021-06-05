import 'package:flutter/material.dart';

class Member {
  Member({
    this.id,
    @required this.name,
  });

  int id;
  String name;

  Member copyWith({
    String name,
  }) =>
      Member(
        name: name ?? this.name,
      );

  Map<String, dynamic> toMap() {
    return {if (id != null) 'id': id, 'name': name};
  }

  static Member of(Map<String, dynamic> m) =>
      Member(id: m['id'], name: m['name']);

  @override
  String toString() {
    return "$id, $name";
  }
}
