import 'package:flutter/material.dart';
import 'package:flutter_sample/models/event.dart';

class EventViewModel with ChangeNotifier {
  Event event = Event(name: "", date: DateTime.now(), liquidated: false);
}

class EventListViewModel with ChangeNotifier {
  List<Event> eventList = [];

  void add(Event event) {
    eventList.add(event);
    notifyListeners();
  }

  void delete(int index) {
    eventList.removeAt(index);
    notifyListeners();
  }
}
