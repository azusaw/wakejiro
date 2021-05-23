import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/cards/event_card.dart';
import 'package:flutter_sample/models/event.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';

class HomeScreen extends HookWidget {
  // サンプルデータ
  final eventList = <Event>[
    new Event(name: "釣り", date: "2021/4/29", isAlreadyPaid: true),
    new Event(name: "麻雀", date: "2021/5/5", isAlreadyPaid: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.base,
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: [
            Column(
              children: List.generate(eventList.length, (index) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: EventCard(eventList[index]));
              }),
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.all(25),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEventScreen(),
                ));
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ThemeColor.accent),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    Text(
                      'イベントを作成する ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          letterSpacing: 2),
                    ),
                    Icon(Icons.add),
                  ]),
                ]),
          ),
        ),
      ),
    );
  }
}
