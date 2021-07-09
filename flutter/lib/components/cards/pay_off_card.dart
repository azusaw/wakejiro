import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';
import 'package:flutter_sample/components/steps/pay_off_step.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentCard extends HookWidget {
  final int index;

  PaymentCard(this.index);

  @override
  Widget build(BuildContext context) {
    final _paymentListPv = useProvider(paymentListProvider);

    return Card(
      elevation: _paymentListPv.paymentList[index].isDone ? 1 : 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
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
                        _paymentListPv.paymentList[index].fromMember.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 18.0, color: Colors.blueGrey),
                      ),
                      Text(
                        _paymentListPv.paymentList[index].toMember.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      NumberFormat('#,##0').format(
                              _paymentListPv.paymentList[index].amount) +
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
                  decoration: _paymentListPv.paymentList[index].isDone
                      ? ShapeDecoration(
                          color: ThemeColor.accent,
                          shape: CircleBorder(),
                        )
                      : ShapeDecoration(
                          color: Colors.grey[300],
                          shape: CircleBorder(),
                        ),
                  child: IconButton(
                    icon: Icon(Icons.check, size: 30.0),
                    color: Colors.white,
                    onPressed: () {
                      _paymentListPv.inverseDone(index);
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
