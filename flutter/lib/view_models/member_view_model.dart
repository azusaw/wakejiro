import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel with ChangeNotifier {
  MemberViewModel({
    @required this.member,
    @required this.isNew,
  });

  Member member;
  bool isNew;
  var isChecked = true;
}

class MemberListViewModel with ChangeNotifier {
  MemberListViewModel({
    @required this.memberList,
  });

  List<MemberViewModel> memberList;

  void add(Member member, bool isNew) {
    memberList.add(MemberViewModel(member: member, isNew: isNew));
    notifyListeners();
  }

  void delete(int index) {
    memberList.removeAt(index);
    notifyListeners();
  }

  void changeChecked(int index, bool checked) {
    memberList[index].isChecked = checked;
    notifyListeners();
  }
}
