import 'package:flutter/material.dart';
import 'package:flutter_sample/models/event.dart';

class EventViewModel with ChangeNotifier {
  EventViewModel({
        @required this.event
  });

  Event event;
}
