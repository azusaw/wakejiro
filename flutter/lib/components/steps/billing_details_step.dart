import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/components/cards/billing_details_card.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BillingDetailsStep extends HookWidget {
  // サンプルデータ
  final _billingDetailsList = <BillingDetails>[
    new BillingDetails(
        paidPersonName: "八田", paidCategory: PaidCategory.Food, amount: 1000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Car, amount: 6000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Ticket, amount: 1500)
  ];

  final _memberList = <Member>[
    Member(name: "八田"),
    Member(name: "渡邉"),
    Member(name: "半田"),
    Member(name: "宮谷"),
  ];

  final _paidCategoryList = <PaidCategory>[
    PaidCategory.Food,
    PaidCategory.Car,
    PaidCategory.Ticket,
    PaidCategory.Food,
    PaidCategory.Car,
    PaidCategory.Ticket
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
      setDefaultValue();
      _billingDetailsList.forEach((element) {
        tmpListPv.add(element);
      });
      return;
    }, const []);

    Widget _billingDetailInputModalContent() {
      return Container(
        height: 530,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(20),
                  child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                    return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: '${tmpPv.billingDetails.paidPersonName}',
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          onChanged: (String value) {
                            tmpPv.setPaidPersonName(value);
                          },
                          items: _memberList
                              .map<DropdownMenuItem<String>>((Member item) {
                            return DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(item.name),
                            );
                          }).toList(),
                        )));
                  })),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                    return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: TextField(
                            decoration: new InputDecoration(
                              hintText: "支払金額",
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
                margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                      return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                tmpPv.billingDetails.amount > 0
                                    ? Colors.cyan[100]
                                    : Colors.blueGrey[50]),
                            overlayColor: MaterialStateProperty.all<Color>(
                                tmpPv.billingDetails.amount > 0
                                    ? Colors.cyan[400]
                                    : Colors.blueGrey[50]),
                            elevation: MaterialStateProperty.all<double>(
                                tmpPv.billingDetails.amount > 0 ? 6 : 0),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                CircleBorder())),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            'assets/' +
                                getPaidCategorySvg(_paidCategoryList[index]),
                            width: 60,
                            height: 60,
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
          ListView.builder(
            itemCount: tmpListPv.billingDetailsList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: BillingDetailsCard(
                      tmpListPv.billingDetailsList[index], index));
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          SizedBox(height: 30),
          Container(
            child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blueGrey[50]),
                  minimumSize: MaterialStateProperty.all(Size(250, 60)),
                ),
                child: Icon(Icons.add, color: Colors.blueGrey),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(50.0),
                              topRight: const Radius.circular(50.0))),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return _billingDetailInputModalContent();
                      });
                }),
          ),
        ]);
  }
}
