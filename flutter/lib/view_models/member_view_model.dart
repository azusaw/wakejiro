import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel with ChangeNotifier {
  MemberViewModel({
    @required this.member,
  });

  Member member;
  var checked = true;

  void setName(String name) {
    member.name = name;
  }

  void setChecked(bool checked) {
    this.checked = checked;
  }
}

class MemberListViewModel with ChangeNotifier {
  MemberListViewModel({
    @required this.memberList,
  });

  List<MemberViewModel> memberList;

  void add(Member member) {
    memberList.add(MemberViewModel(member: member));
    notifyListeners();
  }

  void changeChecked(bool checked, int index) {
    memberList[index].setChecked(checked);
    notifyListeners();
  }
}
