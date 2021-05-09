import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final eventPv = useProvider(eventProvider);
    final memberPv = useProvider(memberProvider);
    final memberListPv = useProvider(memberListProvider);
    final addedMemberListPv = useProvider(addedMemberListProvider);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(dateFormat(eventPv.date)),
              IconButton(
                  onPressed: () => selectDate(context, eventPv),
                  icon: Icon(Icons.calendar_today))
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'イベント名'),
          ),
          SizedBox(height: 30),
          Text('参加メンバー', textAlign: TextAlign.start),
          ListView.builder(
            itemCount: memberListPv.memberList.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(memberListPv.memberList[index].member.name),
                value: memberListPv.memberList[index].checked,
                onChanged: (newValue) {
                  memberListPv.changeChecked(newValue, index);
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                initialValue: "",
                decoration: InputDecoration(labelText: 'メンバー名'),
                onChanged: (newValue) {
                  memberPv.setName(newValue);
                },
              )),
              ElevatedButton(
                onPressed: () {
                  if (memberPv.name.trim().isNotEmpty) {
                    addedMemberListPv.add(Member(name: memberPv.name));
                    print(addedMemberListPv.memberList.length);
                  }
                },
                child: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
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
      locale: const Locale("ja"),
      initialDate: eventPv.date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) eventPv.date = picked;
  }

  String dateFormat(DateTime dateTime) {
    var formatter = DateFormat('yyyy/MM/dd', "ja_JP");
    var formatted = formatter.format(dateTime); // DateからString
    return formatted;
  }
}
