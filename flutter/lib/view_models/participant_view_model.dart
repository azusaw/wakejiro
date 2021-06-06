import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/participant.dart';

class ParticipantListViewModel with ChangeNotifier {
  List<Participant> participantList = [];

  void add(String id, String name) {
    this.participantList.add(Participant(id: id, name: name));
    notifyListeners();
  }

  void delete(int index) {
    this.participantList.removeAt(index);
    notifyListeners();
  }

  Future<void> refreshByEventId(int eventId) async {
    this.participantList = [];
    await database
        .findAllParticipantByEventId(eventId)
        .then((v) => this.participantList = v);
    notifyListeners();
  }
}
