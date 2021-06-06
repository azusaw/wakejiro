import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/buttons/step_control_buttons.dart';
import 'package:flutter_sample/components/cards/billing_details_card.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:flutter_sample/models/participant.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'event_info_step.dart';

final billingDetailsProvider =
    ChangeNotifierProvider((ref) => BillingDetailsViewModel());

class BillingDetailsStep extends HookWidget {
  BillingDetailsStep({this.back, this.next});

  final Function back;
  final Function next;

  final _paidCategoryList = <PaidCategory>[
    PaidCategory.Food,
    PaidCategory.Car,
    PaidCategory.Shopping,
    PaidCategory.Ticket,
    PaidCategory.Housing,
    PaidCategory.Other
  ];

  @override
  Widget build(BuildContext context) {
    final _eventPv = useProvider(eventProvider);
    final _participantListPv = useProvider(participantListProvider);
    final _billingDetailsPv = useProvider(billingDetailsProvider);
    final _billingDetailsListPv = useProvider(billingDetailsListProvider);

    void setDefaultValue() async {
      _billingDetailsPv.paidMember = _participantListPv.participantList[0];
      _billingDetailsPv.amount = 0;
      _billingDetailsPv.paidCategory = null;
      await _billingDetailsListPv.refresh(_eventPv.id);
    }

    useEffect(() {
      Future.microtask(() {
        if (_participantListPv.participantList.length > 0) setDefaultValue();
      });
      return;
    }, [_participantListPv.participantList]);

    Widget _modalContent() {
      return Container(
        height: 530,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "明細の入力",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2,
                      color: Colors.grey[600]),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<Participant>(
                              value: _billingDetailsPv.paidMember,
                              isDense: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              onChanged: (Participant value) {
                                setState(() {});
                                _billingDetailsPv.paidMember = value;
                              },
                              items: _participantListPv.participantList
                                  .map<DropdownMenuItem<Participant>>(
                                (Participant item) {
                                  return DropdownMenuItem<Participant>(
                                    value: item,
                                    child: Text(item.name),
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                    return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: TextField(
                            decoration: InputDecoration(
                              hintText: "支払金額を入力してください",
                              suffixText: "円",
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            onChanged: (String amount) {
                              _billingDetailsPv.amount = int.parse(amount);
                            }));
                  })),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _paidCategoryList.length,
                    itemBuilder: (context, index) {
                      if (_billingDetailsPv.amount > 0) {
                        return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  ThemeColor.accent),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  CircleBorder())),
                          child: ClipOval(
                            child: SvgPicture.asset(
                              'assets/' +
                                  getPaidCategorySvg(_paidCategoryList[index]),
                              width: 80,
                              height: 80,
                            ),
                          ),
                          onPressed: () async {
                            if (_billingDetailsPv.amount > 0 &&
                                _billingDetailsPv.paidMember != null) {
                              _billingDetailsPv.paidCategory =
                                  _paidCategoryList[index];
                              await database
                                  .insertBillingDetails(_billingDetailsPv);
                              setDefaultValue();
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      } else {
                        return null;
                      }
                    }),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
              children: List.generate(
                  _billingDetailsListPv.billingDetailsList.length, (index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: BillingDetailsCard(
                    _billingDetailsListPv.billingDetailsList[index], index));
          })),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 30),
            Container(
              child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(250, 60)),
                  ),
                  child: Icon(Icons.add, color: Colors.grey),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(30.0),
                                topRight: const Radius.circular(30.0))),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        builder: (BuildContext context) => _modalContent());
                  }),
            ),
            StepControlButtons(
                back: back,
                next: next,
                disabled: _billingDetailsListPv.billingDetailsList.length < 1)
          ]),
        ]);
  }
}
