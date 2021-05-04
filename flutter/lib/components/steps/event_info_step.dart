import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:intl/intl.dart';

class EventInfoStep extends StatefulWidget {
  @override
  _EventInfoStepState createState() => _EventInfoStepState();
}

class _EventInfoStepState extends State<EventInfoStep> {
  // サンプルデータ
  var _memberCheckedMap = {
    new Member(name: "八田"): false,
    new Member(name: "渡邉"): false,
    new Member(name: "宮谷"): false,
    new Member(name: "半田"): false
  };
  var _memberAddedList = [];
  var _date = new DateTime.now();
  var _memberNameToAdded = '';

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 30),
          Text('参加メンバー', textAlign: TextAlign.start),
          ListView.builder(
            itemCount: _memberCheckedMap.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title:
                    Text(_memberCheckedMap.entries.elementAt(index).key.name),
                value: _memberCheckedMap.entries.elementAt(index).value,
                onChanged: (newValue) {
                  setState(() {
                    _memberCheckedMap.update(
                        _memberCheckedMap.entries.elementAt(index).key,
                        (value) => newValue);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                      initialValue: _memberNameToAdded,
                      decoration: InputDecoration(labelText: 'メンバー名'),
                      onChanged: (newValue) {
                        setState(() {
                          _memberNameToAdded = newValue;
                        });
                      },
                      )),
              ElevatedButton(
                onPressed: () {
                  if (_memberNameToAdded.trim().isNotEmpty) {
                    _memberAddedList
                        .add(new Member(name: _memberNameToAdded.trim()));
                    setState(() => _memberNameToAdded = 'hoge');
                  }
                },
                child: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  shape: const CircleBorder(),
                ),
              ),
            ],
          )
        ]);
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
