import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/components/steps/billing_details_step.dart';
import 'package:flutter_sample/components/steps/event_info_step.dart';
import 'package:flutter_sample/components/steps/pay_off_step.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 0;

  tapped(int step) => setState(() => _currentStep = step);

  continued() => _currentStep < 2 ? setState(() => _currentStep += 1) : null;

  cancel() => _currentStep > 0 ? setState(() => _currentStep -= 1) : null;

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
                      content: EventInfoStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('明細'),
                      content: BillingDetailsStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('清算'),
                      content: PayOffStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: onStepCancel,
                                child: const Text('前へ'),
                              ),
                              ElevatedButton(
                                onPressed: onStepContinue,
                                child: const Text('次へ'),
                              ),
                            ],
                          )
                        ]);
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
