import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_sample/view_models/payment_view_model.dart';
import 'package:intl/intl.dart';

class PaymentCard extends HookWidget {
  final int index;

  PaymentCard(this.index);

  @override
  Widget build(BuildContext context) {
    final paymentListPv = useProvider(paymentListProvider);

    return Card(
      elevation: paymentListPv.paymentList[index].isDone ? 1 : 10,
      color: Colors.white,
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
                    margin: const EdgeInsets.only(left: 10, bottom: 4),
                    child: Row(children: <Widget>[
                      Text(
                        paymentListPv.paymentList[index].fromMember.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 18.0, color: Colors.blueGrey),
                      ),
                      Text(
                        paymentListPv.paymentList[index].toMember.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      NumberFormat('#,##0')
                              .format(paymentListPv.paymentList[index].amount) +
                          "円",
                      style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Ink(
                  decoration: paymentListPv.paymentList[index].isDone
                      ? ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        )
                      : ShapeDecoration(
                          color: Colors.grey,
                          shape: CircleBorder(),
                        ),
                  child: IconButton(
                    icon: Icon(Icons.check, size: 30.0),
                    color: Colors.white,
                    onPressed: () {
                      paymentListPv.inverseDone(index);
                      print(paymentListPv.paymentList[index].isDone);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
