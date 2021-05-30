import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/cards/event_card.dart';
import 'package:flutter_sample/models/event.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
import 'package:flutter_sample/view_models/event_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventProvider = ChangeNotifierProvider((ref) => EventViewModel(
    event: Event(name: "釣り", date: DateTime.now(), liquidated: false)));
final eventListProvider =
    ChangeNotifierProvider((ref) => EventListViewModel(eventList: [
          Event(name: "釣り", date: DateTime(2021, 4, 29), liquidated: true),
          Event(name: "麻雀", date: DateTime(2021, 5, 5), liquidated: false)
        ]));

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _eventPv = useProvider(eventProvider);
    final _eventListPv = useProvider(eventListProvider);

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
              children: List.generate(_eventListPv.eventList.length, (index) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: EventCard(_eventListPv.eventList[index]));
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
