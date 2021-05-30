import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/buttons/step_control_buttons.dart';
import 'package:flutter_sample/components/cards/billing_details_card.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final billingDetailsProvider =
    ChangeNotifierProvider((ref) => BillingDetailsViewModel());

class BillingDetailsStep extends HookWidget {
  BillingDetailsStep({this.back, this.next});
  final Function back;
  final Function next;

  // サンプルデータ
  final _memberList = <Member>[
    Member(name: "八田"),
    Member(name: "渡邉"),
    Member(name: "半田"),
    Member(name: "宮谷"),
  ];

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
    final tmpPv = useProvider(billingDetailsProvider);
    final tmpListPv = useProvider(billingDetailsListProvider);

    void setDefaultValue() {
      tmpPv.setPaidPersonName(_memberList[0].name);
      tmpPv.setAmount(0);
      tmpPv.setPaidCategory(null);
    }

    useEffect(() {
      Future.microtask(() {
        setDefaultValue();
      });
      return;
    }, const []);

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
                      child: StatefulBuilder(builder: (context, setState) {
                        return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: '${tmpPv.billingDetails.paidPersonName}',
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          onChanged: (String value) {
                            setState(() {});
                            tmpPv.setPaidPersonName(value);
                          },
                          items: _memberList
                              .map<DropdownMenuItem<String>>((Member item) {
                            return DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(item.name),
                            );
                          }).toList(),
                        ));
                      }),
                    );
                  })),
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
                              tmpPv.setAmount(int.parse(amount));
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
                      if (tmpPv.billingDetails.amount > 0) {
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
                          onPressed: () {
                            if (tmpPv.billingDetails.amount > 0 &&
                                tmpPv.billingDetails.paidPersonName != "") {
                              tmpPv.setPaidCategory(_paidCategoryList[index]);
                              tmpListPv.add(tmpPv.billingDetails);
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

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      Column(
          children: List.generate(tmpListPv.billingDetailsList.length, (index) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child:
                BillingDetailsCard(tmpListPv.billingDetailsList[index], index));
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
        StepControlButtons(back: back, next: next)
      ]),
    ]);
  }
}
