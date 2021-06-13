import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel extends Member with ChangeNotifier {
  MemberViewModel({
    id,
    @required name,
    @required this.isChecked,
  }) : super(id: id, name: name);

  bool isChecked;

  void setName(String name) {
    this.name = name;
  }
}

class MemberListViewModel with ChangeNotifier {
  List<MemberViewModel> memberList = [];

  void add(String name, bool isChecked) {
    this.memberList.add(MemberViewModel(name: name, isChecked: isChecked));
    notifyListeners();
  }

  void delete(int index) {
    this.memberList.removeAt(index);
    notifyListeners();
  }

  void changeChecked(int index, bool checked) {
    this.memberList[index].isChecked = checked;
    notifyListeners();
  }

  Future<void> refreshByEventId(int eventId) async {
    this.memberList = [];
    await database.findAllMembers().then((v) {
      v.forEach((member) {
        this.memberList.add(MemberViewModel(
            id: member.id, name: member.name, isChecked: false));
      });
    });
    await database
        .findAllParticipantByEventId(eventId)
        .then((v) => v.forEach((participant) {
              this.changeChecked(
                  this.memberList.indexWhere((v) => v.name == participant.name),
                  true);
            }));
    notifyListeners();
  }
}
