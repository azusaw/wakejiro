import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/buttons/step_control_buttons.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:flutter_sample/util/date_formatter.dart';
import 'package:flutter_sample/view_models/event_view_model.dart';
import 'package:flutter_sample/view_models/member_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final memberProvider =
    ChangeNotifierProvider((ref) => MemberViewModel(name: "", isNew: true));
final memberListProvider =
    ChangeNotifierProvider((ref) => MemberListViewModel(memberList: [
          MemberViewModel(name: "八田", isNew: false),
          MemberViewModel(name: "渡邉", isNew: false),
          MemberViewModel(name: "宮谷", isNew: false),
          MemberViewModel(name: "半田", isNew: false)
        ]));

class EventInfoStep extends HookWidget {
  EventInfoStep({this.back, this.next});
  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final _eventPv = useProvider(eventProvider);
    final _memberPv = useProvider(memberProvider);
    final _memberListPv = useProvider(memberListProvider);
    final _eventNameController =
        TextEditingController.fromValue(TextEditingValue(
      text: _eventPv.name,
      selection: TextSelection.collapsed(offset: _eventPv.name.length),
    ));
    final _memberNameController =
        TextEditingController.fromValue(TextEditingValue(
      text: _memberPv.name,
      selection: TextSelection.collapsed(offset: _memberPv.name.length),
    ));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 20),
            child: FormField<String>(builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                        hintText: "イベント名を入力してください",
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(0)),
                    onChanged: (String name) {
                      _eventPv.setName(name);
                    }),
              );
            }),
          ),
          SizedBox(height: 40),
          Text('開催日', textAlign: TextAlign.start),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  dateFormat(_eventPv.date),
                  style: TextStyle(fontSize: 20.0, letterSpacing: 1),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  color: Colors.grey,
                  onPressed: () => selectDate(context, _eventPv),
                  icon: Icon(Icons.calendar_today),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Text('参加メンバー', textAlign: TextAlign.start),
          Column(
            children: List.generate(
              _memberListPv.memberList.length,
              (index) {
                return CheckboxListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _memberListPv.memberList[index].name,
                        ),
                      ),
                      if (_memberListPv.memberList[index].isNew)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: IconButton(
                                onPressed: () {
                                  _memberListPv.delete(index);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  value: _memberListPv.memberList[index].isChecked,
                  onChanged: (newValue) {
                    _memberListPv.changeChecked(index, newValue);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: ThemeColor.accent,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25, right: 30),
            child: Stack(alignment: Alignment.centerRight, children: [
              TextFormField(
                controller: _memberNameController,
                decoration: InputDecoration(
                  labelText: 'メンバー名',
                ),
                onChanged: (newValue) {
                  _memberPv.setName(newValue);
                },
              ),
              IconButton(
                color: Colors.grey,
                onPressed: () {
                  if (_memberPv.name.trim().isNotEmpty) {
                    _memberListPv.add(_memberPv.name, true);
                    _memberPv.setName("");
                    FocusScope.of(context).unfocus();
                  }
                },
                icon: Icon(Icons.add),
              ),
            ]),
          ),
          StepControlButtons(
            back: back,
            next: () async {
              _eventPv.id != null
                  ? await database.updateEvent(_eventPv)
                  : await database.insertEvent(_eventPv);
              next();
            },
            disabled: _eventPv.name == "" ||
                _memberListPv.memberList.where((v) => v.isChecked).length == 0,
          ),
        ]);
  }

  Future<Null> selectDate(BuildContext context, EventViewModel eventPv) async {
    final picked = await showDatePicker(
      context: context,
      helpText: "",
      locale: const Locale("ja"),
      initialDate: eventPv.date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme:
                ColorScheme.light().copyWith(primary: ThemeColor.accent),
          ),
          child: child,
        );
      },
    );
    if (picked != null) eventPv.setDate(picked);
  }
}
