import 'package:flutter/material.dart';

class Member {
  Member({
    @required this.name,
  });

  String name;

  void setName(String name) {
    this.name = name;
  }

  Member copyWith({
    String name,
  }) =>
      Member(
        name: name ?? this.name,
      );

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
