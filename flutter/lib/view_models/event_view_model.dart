import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/event.dart';

class EventViewModel extends Event with ChangeNotifier {
  EventViewModel() : super(name: "", date: DateTime.now(), liquidated: false);

  void setDefaultValue() {
    this.id = null;
    this.name = "";
    this.date = DateTime.now();
    liquidated = false;
  }

  void setEvent(Event event) {
    this.id = event.id;
    this.name = event.name;
    this.date = event.date;
    this.liquidated = event.liquidated;
  }

  void setName(String name) {
    this.name = name;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  void setLiquidated(bool liquidated) {
    this.liquidated = liquidated;
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

  Future<void> refresh() async {
    await database.findAllEvents().then((v) => eventList = v).then((v) {
      notifyListeners();
    });
  }
}
