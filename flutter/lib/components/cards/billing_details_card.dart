import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/paid_category.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class BillingDetailsCard extends HookWidget {
  final BillingDetails billingDetails;
  final int index;

  BillingDetailsCard(this.billingDetails, this.index);

  @override
  Widget build(BuildContext context) {
    final tmpListPv = useProvider(billingDetailsListProvider);

    return Card(
      elevation: 8,
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
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
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
                  color: Colors.grey,
                  onPressed: () {
                    tmpListPv.delete(index);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
