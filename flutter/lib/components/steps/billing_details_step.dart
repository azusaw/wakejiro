import 'package:flutter/material.dart';
import 'package:flutter_sample/components/cards/billing_details_card.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/paid_category.dart';

class BillingDetailsStep extends StatefulWidget {
  @override
  _BillingDetailsStepState createState() => _BillingDetailsStepState();
}

class _BillingDetailsStepState extends State<BillingDetailsStep> {
  // サンプルデータ
  final billingDetailsList = <BillingDetails>[
    new BillingDetails(
        paidPersonName: "八田", paidCategory: PaidCategory.Food, amount: 1000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Car, amount: 6000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Ticket, amount: 1500)
  ];

  final memberList = <Member>[
    new Member(name: "八田"),
    new Member(name: "渡邉"),
    new Member(name: "半田"),
    new Member(name: "宮谷"),
  ];

  String _dropdownValue = "八田";

  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
            itemCount: billingDetailsList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: BillingDetailsCard(billingDetailsList[index]));
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          SizedBox(height: 30),
          Container(
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(8),
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey[50]),
                minimumSize: MaterialStateProperty.all(Size(250, 60)),
              ),
              child: Icon(Icons.add, color: Colors.blueGrey),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 20, bottom: 4),
                            child: DropdownButton<String>(
                              value: _dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                height: 1,
                                color: Colors.blueGrey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  _dropdownValue = newValue;
                                });
                              },
                              items: memberList
                                  .map<DropdownMenuItem<String>>((Member item) {
                                return DropdownMenuItem<String>(
                                  value: item.name,
                                  child: Text(item.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                minimumSize: MaterialStateProperty.all(Size(300, 60))),
            child: Text(
              '次へ',
              style: TextStyle(fontSize: 18.0, letterSpacing: 3),
            ),
            onPressed: () {},
          ),
        ]);
  }
}
