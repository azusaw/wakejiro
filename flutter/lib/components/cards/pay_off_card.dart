import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/payment.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentCard extends HookWidget {
  final Payment payment;
  final int index;

  PaymentCard(this.payment, this.index);

  @override
  Widget build(BuildContext context) {
    final tmpListPv = useProvider(billingDetailsListProvider);

    return Card(
      elevation: payment.isDone ? 0 : 8,
      color: Colors.blueGrey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 4),
                    child: Text(
                      payment.toMember.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      NumberFormat('#,##0').format(payment.amount) + "円",
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
                  icon: payment.isDone
                      ? Icon(Icons.check_circle_rounded, size: 35.0)
                      : Icon(Icons.check_circle_rounded, size: 35.0),
                  color: payment.isDone ? Colors.green : Colors.lightBlueAccent,
                  onPressed: () {
                    payment.isDone = !payment.isDone;
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
