import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/view_models/event_view_model.dart';
import 'package:flutter_sample/view_models/member_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final eventProvider = ChangeNotifierProvider((ref) => EventViewModel());
final memberProvider = ChangeNotifierProvider((ref) => Member(name: ""));
final memberListProvider =
    ChangeNotifierProvider((ref) => MemberListViewModel(memberList: [
          MemberViewModel(member: Member(name: "八田")),
          MemberViewModel(member: Member(name: "渡邉")),
          MemberViewModel(member: Member(name: "宮谷")),
          MemberViewModel(member: Member(name: "半田"))
        ]));
final addedMemberListProvider =
    ChangeNotifierProvider((ref) => MemberListViewModel(memberList: []));

class EventInfoStep extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _eventPv = useProvider(eventProvider);
    final _memberPv = useProvider(memberProvider);
    final _memberListPv = useProvider(memberListProvider);
    final _addedMemberListPv = useProvider(addedMemberListProvider);
    final _memberNameController = TextEditingController(text: "");

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(dateFormat(_eventPv.date)),
              IconButton(
                  onPressed: () => selectDate(context, _eventPv),
                  icon: Icon(Icons.calendar_today))
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'イベント名'),
          ),
          SizedBox(height: 30),
          Text('参加メンバー', textAlign: TextAlign.start),
          Column(
            children: List.generate(
              _memberListPv.memberList.length,
              (index) {
                return CheckboxListTile(
                  activeColor: ThemeColor.accent,
                  title: Text(_memberListPv.memberList[index].member.name),
                  value: _memberListPv.memberList[index].checked,
                  onChanged: (newValue) {
                    _memberListPv.changeChecked(newValue, index);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
          Column(
            children: List.generate(
              _addedMemberListPv.memberList.length,
              (index) {
                return CheckboxListTile(
                  activeColor: ThemeColor.accent,
                  title: Text(_addedMemberListPv.memberList[index].member.name),
                  value: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {},
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _memberNameController,
                  decoration: InputDecoration(labelText: 'メンバー名'),
                  onChanged: (newValue) {
                    _memberPv.setName(newValue);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_memberPv.name.trim().isNotEmpty) {
                    _addedMemberListPv.add(Member(name: _memberPv.name));
                    _memberPv.setName("");
                    _memberNameController.clear();
                  }
                },
                child: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  primary: ThemeColor.accent,
                  shape: const CircleBorder(),
                ),
              ),
            ],
          )
        ]);
  }

  Future<Null> selectDate(BuildContext context, EventViewModel eventPv) async {
    final picked = await showDatePicker(
      context: context,
      helpText: "",
      locale: const Locale("ja"),
      initialDate: eventPv.date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme:
                ColorScheme.light().copyWith(primary: ThemeColor.accent),
          ),
          child: child,
        );
      },
    );
    if (picked != null) eventPv.date = picked;
  }

  String dateFormat(DateTime dateTime) {
    var formatter = DateFormat('yyyy/MM/dd', "ja_JP");
    var formatted = formatter.format(dateTime); // DateからString
    return formatted;
  }
}
