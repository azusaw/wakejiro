import 'package:flutter/material.dart';
import 'package:flutter_sample/models/event.dart';

class EventViewModel extends Event with ChangeNotifier {
  EventViewModel() : super(name: "", date: DateTime.now(), liquidated: false);

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }
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
