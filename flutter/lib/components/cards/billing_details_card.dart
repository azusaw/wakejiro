import 'package:flutter/material.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BillingDetailsCard extends StatelessWidget {
  final BillingDetails billingDetails;

  BillingDetailsCard(this.billingDetails);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.blueGrey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SvgPicture.asset(
                'assets/' + getPaidCategorySvg(billingDetails.paidCategory),
                width: 40,
                height: 40,
              ),
            ]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 4),
                    child: Text(
                      billingDetails.paidPersonName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      NumberFormat('#,##0').format(billingDetails.amount) + "円",
                      style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
