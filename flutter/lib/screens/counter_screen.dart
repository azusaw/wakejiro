import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/view_models/member_view_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/* Provider Sample*/
final memberProvider = ChangeNotifierProvider((ref) => MemberViewModel());
final memberListProvider =
    ChangeNotifierProvider((ref) => MemberListViewModel());

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
    final tmpPv = useProvider(memberProvider);
    final tmpListPv = useProvider(memberListProvider);

    return Scaffold(
      body: Center(
          child: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Text('選択中： ${tmpPv.member.name}'),
          SizedBox(height: 10),
          FormField<String>(builder: (FormFieldState<String> state) {
            return DropdownButton<String>(
              value: tmpPv.member.name,
              isDense: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              onChanged: (String value) {
                tmpPv.setName(value);
              },
              items: _memberList.map<DropdownMenuItem<String>>((Member item) {
                return DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(item.name),
                );
              }).toList(),
            );
          }),
          SizedBox(height: 20),
          Text('メンバーリスト'),
          ListView.builder(
            itemCount: tmpListPv.memberList.length,
            itemBuilder: (context, index) {
              return Text(tmpListPv.memberList[index].name);
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ]),
      )),
      floatingActionButton: FloatingActionButton(
        child: Text("＋"),
        onPressed: () {
          tmpListPv.add(tmpPv.member);
          print(tmpListPv.memberList);
        },
      ),
    );
  }
}
