import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/components/cards/event_card.dart';
import 'package:flutter_sample/models/event.dart';

import 'create_event_screen.dart';

class HomeScreen extends HookWidget {
  // サンプルデータ
  final eventList = <Event>[
    new Event(name: "釣り", date: "2021/4/29", isAlreadyPaid: true),
    new Event(name: "麻雀", date: "2021/5/5", isAlreadyPaid: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: EventCard(eventList[index]));
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEventScreen(),
              ));
        },
        label: const Text('イベントを作成する'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
