import 'package:flutter/material.dart';
import 'package:flutter_sample/components/billing_details_card.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/paid_category.dart';

class BillingDetailsScreen extends StatelessWidget {
  // サンプルデータ
  final billingDetailsList = <BillingDetails>[
    new BillingDetails(
        paidPersonName: "八田", paidCategory: PaidCategory.Food, amount: 1000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Car, amount: 6000),
    new BillingDetails(
        paidPersonName: "渡邉", paidCategory: PaidCategory.Ticket, amount: 1500)
  ];

  @override
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
          SizedBox(height: 40),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey[400]),
                minimumSize: MaterialStateProperty.all(Size(300, 50))),
            child: Text(
              '明細を追加する',
              style: TextStyle(fontSize: 18.0, letterSpacing: 3),
            ),
            onPressed: () {},
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
