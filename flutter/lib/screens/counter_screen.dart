import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/* Provider Sample*/
class CounterScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final member = useProvider(memberProvider).state;
    final Member member2 = Member(name: "wawawa!");

    return Scaffold(
      body: Center(child: Text('${member.name} ${member2.name}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(memberProvider).state = member.copyWith(name: "hatta");
        },
      ),
    );
  }
}
