import 'package:flutter/material.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
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
              subtitle: Text(event.date),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  event.isAlreadyPaid ? "清算済み" : "未清算あり",
                  style: TextStyle(
                      color: event.isAlreadyPaid
                          ? ThemeColor.accent
                          : ThemeColor.error),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
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
