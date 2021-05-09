import 'package:flutter/material.dart';

class Member extends ChangeNotifier {
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
}
