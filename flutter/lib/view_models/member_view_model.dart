import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';

class MemberViewModel extends Member with ChangeNotifier {
  MemberViewModel({
    @required name,
    @required this.isNew,
  }) : super(name: name);

  bool isNew;
  var isChecked = true;
}

class MemberListViewModel with ChangeNotifier {
  MemberListViewModel({
    @required this.memberList,
  });

  List<MemberViewModel> memberList;

  void add(String name, bool isNew) {
    memberList.add(MemberViewModel(name: name, isNew: isNew));
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
