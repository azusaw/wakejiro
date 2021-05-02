import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:intl/intl.dart';

class EventInfoStep extends StatefulWidget {
  @override
  _EventInfoStepState createState() => _EventInfoStepState();
}

class _EventInfoStepState extends State<EventInfoStep> {
  // サンプルデータ
  var memberCheckedMap = {
    new Member(name: "八田"): false,
    new Member(name: "渡邉"): false,
    new Member(name: "宮谷"): false,
    new Member(name: "半田"): false
  };
  var _date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(dateFormat(_date)),
            IconButton(
                onPressed: () => selectDate(context),
                icon: Icon(Icons.calendar_today))
          ],
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'イベント名'),
        ),
        Text('参加メンバー'),
        ListView.builder(
          itemCount: memberCheckedMap.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(memberCheckedMap.entries.elementAt(index).key.name),
              value: memberCheckedMap.entries.elementAt(index).value,
              onChanged: (newValue) {
                setState(() {
                  // TODO
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        )
      ],
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: _date,
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  String dateFormat(DateTime dateTime) {
    var formatter = new DateFormat('yyyy/MM/dd', "ja_JP");
    var formatted = formatter.format(dateTime); // DateからString
    return formatted;
  }
}
