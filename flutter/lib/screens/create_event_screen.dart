import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 0;
  DateTime _date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('イベント情報'),
                      content: Column(
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
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('明細'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Home Address'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Postcode'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('清算'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Mobile Number'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
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

  String dateFormat (DateTime dateTime) {
    var formatter = new DateFormat('yyyy/MM/dd', "ja_JP");
    var formatted = formatter.format(dateTime); // DateからString
    return formatted;
  }
}
