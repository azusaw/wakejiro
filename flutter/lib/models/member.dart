import 'package:flutter/material.dart';

class Member {
  Member({
    @required this.name,
  });

  String name;

  Member copyWith({
    String name,
  }) =>
      Member(
        name: name ?? this.name,
      );
}
