import 'package:flutter/material.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/steps/billing_details_step.dart';
import 'package:flutter_sample/components/steps/event_info_step.dart';
import 'package:flutter_sample/components/steps/pay_off_step.dart';
import 'package:flutter_sample/models/event.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_sample/view_models/event_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_screen.dart';

final eventProvider = ChangeNotifierProvider((ref) => EventViewModel(
    event: Event(name: "釣り", date: DateTime.now(), liquidated: false)));

final billingDetailsListProvider =
    ChangeNotifierProvider((ref) => BillingDetailsListViewModel());

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 0;

  tapped(int step) => setState(() => _currentStep = step);

  continued() => _currentStep < 2 ? setState(() => _currentStep += 1) : null;

  cancel() => _currentStep > 0 ? setState(() => _currentStep -= 1) : null;

  finish() => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));

  displayState(int index) {
    if (_currentStep < index) {
      return StepState.disabled;
    } else if (_currentStep == index) {
      return StepState.indexed;
    } else {
      return StepState.complete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.base,
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
                  steps: <Step>[
                    Step(
                      title: Text('イベント'),
                      content: EventInfoStep(back: finish, next: continued),
                      isActive: true,
                      state: displayState(0),
                    ),
                    Step(
                      title: Text('明細'),
                      content:
                          BillingDetailsStep(back: cancel, next: continued),
                      isActive: true,
                      state: displayState(1),
                    ),
                    Step(
                      title: Text('清算'),
                      content: PayOffStep(back: cancel, next: finish),
                      isActive: true,
                      state: displayState(2),
                    ),
                  ],
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Container(child: null);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
