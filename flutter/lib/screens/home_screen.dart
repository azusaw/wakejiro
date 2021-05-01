import 'package:flutter/material.dart';
import 'package:flutter_sample/components/event_card.dart';
import 'package:flutter_sample/models/event.dart';

class HomeScreen extends StatelessWidget {
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
              return EventCard(eventList[index]);
            },
          ),
        ),
      ),
    );
  }
}
