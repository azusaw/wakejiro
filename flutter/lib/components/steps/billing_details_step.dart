import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/components/cards/billing_details_card.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:flutter_svg/svg.dart';

class BillingDetailsStep extends StatefulWidget {
  @override
  _BillingDetailsStepState createState() => _BillingDetailsStepState();
}

class _BillingDetailsStepState extends State<BillingDetailsStep> {
  // サンプルデータ
  var _billingDetailsList = <BillingDetails>[
    new BillingDetails(
        paidPersonName: "八田", paidCategory: PaidCategory.Food, amount: 1000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Car, amount: 6000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Ticket, amount: 1500)
  ];

  final _memberList = <Member>[
    new Member(name: "八田"),
    new Member(name: "渡邉"),
    new Member(name: "半田"),
    new Member(name: "宮谷"),
  ];

  final _paidCategoryList = <PaidCategory>[
    PaidCategory.Food,
    PaidCategory.Car,
    PaidCategory.Ticket,
    PaidCategory.Food,
    PaidCategory.Car,
    PaidCategory.Ticket
  ];

  BillingDetails _billingDetails =
      new BillingDetails(paidPersonName: "八田", paidCategory: null, amount: 0);

  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
            itemCount: _billingDetailsList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: BillingDetailsCard(_billingDetailsList[index]));
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
                backgroundColor: Colors.white,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: 530,
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(20,20,20,0),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                        value: _billingDetails.paidPersonName,
                                        isDense: true,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _billingDetails.paidPersonName =
                                                newValue;
                                          });
                                        },
                                        items: _memberList
                                            .map<DropdownMenuItem<String>>(
                                                (Member item) {
                                          return DropdownMenuItem<String>(
                                            value: item.name,
                                            child: Text(item.name),
                                          );
                                        }).toList(),
                                      ));
                                    }));
                              })),
                          Container(
                              margin: const EdgeInsets.all(20),
                              child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return TextField(
                                          decoration: new InputDecoration(
                                            hintText: "支払金額",
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _billingDetails.amount =
                                                  int.parse(newValue);
                                            });
                                          });
                                    }));
                              })),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _paidCategoryList.length,
                              itemBuilder: (context, index) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                _billingDetails.amount > 0
                                                    ? Colors.cyan[100]
                                                    : Colors.blueGrey[50]),
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                _billingDetails.amount > 0
                                                    ? Colors.cyan[400]
                                                    : Colors.blueGrey[50]),
                                        elevation: MaterialStateProperty.all<double>(
                                            _billingDetails.amount > 0 ? 6 : 0),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(CircleBorder())),
                                    child: ClipOval(
                                      child: SvgPicture.asset(
                                        'assets/' +
                                            getPaidCategorySvg(
                                                _paidCategoryList[index]),
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    onPressed: () {
                                      _billingDetails.amount <= 0
                                          ? null
                                          : setState(() {
                                              _billingDetails.paidCategory =
                                                  _paidCategoryList[index];
                                            });
                                    },
                                  );
                                });
                              },
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
