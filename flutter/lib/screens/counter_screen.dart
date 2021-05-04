import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/view_models/member_view_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/* Provider Sample*/
final memberProvider = ChangeNotifierProvider((ref) => MemberViewModel());

final _memberList = <Member>[
  Member(name: "選択してください"),
  Member(name: "八田"),
  Member(name: "渡邉"),
  Member(name: "半田"),
  Member(name: "宮谷"),
];

class CounterScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tmp = useProvider(memberProvider);
    return Scaffold(
      body: Center(
          child: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Text('選択中： ${tmp.member.name}'),
          FormField<String>(builder: (FormFieldState<String> state) {
            return DropdownButton<String>(
              value: tmp.member.name,
              isDense: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              onChanged: (String value) {
                tmp.setName(value);
              },
              items: _memberList.map<DropdownMenuItem<String>>((Member item) {
                return DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(item.name),
                );
              }).toList(),
            );
          }),
        ]),
      )),
      floatingActionButton: FloatingActionButton(
        child: Text("わ"),
        onPressed: () {
          tmp.setName("渡邉");
        },
      ),
    );
  }
}
