import 'package:flutter/material.dart';

import 'member.dart';

class Participant extends Member {
  Participant({
    @required id,
    @required name,
  }) : super(id: id, name: name);

  Map<String, dynamic> toMap() {
    return {if (id != null) 'id': id, 'name': name};
  }

  static Participant of(Map<String, dynamic> m) =>
      Participant(id: m['id'], name: m['name']);
}
