import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/event.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:flutter_sample/util/date_formatter.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventCard extends HookWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    final _eventListPv = useProvider(eventListProvider);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text(event.name),
              subtitle: Text(dateFormat(event.date)),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateEventScreen(),
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await database.deleteEvent(event);
                    _eventListPv.refresh();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
