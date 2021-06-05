import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel extends Member with ChangeNotifier {
  MemberViewModel({
    @required name,
    @required this.isNew,
  }) : super(name: name);

  bool isNew;
  var isChecked = true;

  void setName(String name) {
    this.name = name;
  }

  void setIsNew(bool isNew) {
    this.isNew = isNew;
    notifyListeners();
  }
}

class MemberListViewModel with ChangeNotifier {
  List<MemberViewModel> memberList = [];

  void add(String name, bool isNew) {
    this.memberList.add(MemberViewModel(name: name, isNew: isNew));
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

  void changeIsNew(int index, bool isNew) {
    this.memberList[index].isNew = isNew;
    notifyListeners();
  }

  Future<void> refresh() async {
    var completer = Completer<void>();
    this.memberList = [];
    await database
        .findAllMembers()
        .then((v) => v.forEach((member) => this
            .memberList
            .add(MemberViewModel(name: member.name, isNew: false))))
        .then((v) {
      notifyListeners();
      completer.complete();
    });
    return completer.future;
  }
}
