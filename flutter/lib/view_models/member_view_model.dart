import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel with ChangeNotifier {
  Member member = new Member(name: "選択してください");

  void setName(String name) {
    member.name = name;
    notifyListeners();
  }
}

class MemberListViewModel with ChangeNotifier {
  List<Member> memberList = [];

  void add(Member member) {
    memberList.add(member.copyWith());
    notifyListeners();
  }
}