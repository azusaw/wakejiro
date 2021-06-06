import 'dart:math';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/components/buttons/step_control_buttons.dart';
import 'package:flutter_sample/components/cards/pay_off_card.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/payment.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:flutter_sample/util/date_formatter.dart';
import 'package:flutter_sample/view_models/billing_details_view_model.dart';
import 'package:flutter_sample/view_models/payment_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final paymentProvider = ChangeNotifierProvider((ref) => PaymentViewModel());
final paymentListProvider =
    ChangeNotifierProvider((ref) => PaymentListViewModel());

class PayOffStep extends HookWidget {
  PayOffStep({this.back, this.next});

  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final _eventPv = useProvider(eventProvider);
    final _billingDetailsListPv = useProvider(billingDetailsListProvider);
    final _paymentListPv = useProvider(paymentListProvider);

    // サンプルデータ
    final _paymentList = <Payment>[
      Payment(
          toMember: Member(name: "八田"),
          fromMember: Member(name: "渡邉"),
          amount: 1000,
          isDone: false),
      Payment(
          toMember: Member(name: "八田"),
          fromMember: Member(name: "半田"),
          amount: 1500,
          isDone: false),
    ];

    void setListDefaultValue() {
      _paymentListPv.deleteAll();
      final list = _createPaymentList(
          _billingDetailsListPv,
          (_billingDetailsListPv.calcTotal() / _billingDetailsListPv.size())
              .round());
      list.forEach((element) {
        _paymentListPv.add(element);
      });
    }

    useEffect(() {
      Future.microtask(() {
        setListDefaultValue();
      });
      return;
    }, const []);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Text("イベント名",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            title: Text(dateFormat(_eventPv.date)),
          ),
          ListTile(
            leading: Text("合計",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            title: Text(NumberFormat('#,##0')
                    .format(_billingDetailsListPv.calcTotal()) +
                "円"),
          ),
          ListView.builder(
            itemCount: _paymentListPv.paymentList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: PaymentCard(index));
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
          StepControlButtons(
            back: back,
            next: next,
            disabled: false,
          )
        ]);
  }

  List<Payment> _createPaymentList(
      BillingDetailsListViewModel billingDetailsListPv, int average) {
    // 各メンバーについて1人当たり金額との差額を算出
    final memberToSum = billingDetailsListPv.billingDetailsList
        .groupFoldBy<Member, int>((e) => e.paidMember,
            (previous, element) => (previous ?? -average) + element.amount);
    final payers = memberToSum.entries
        .toList()
        .where((element) => element.value < 0)
        .sorted((a, b) => b.value - a.value);
    final payees = memberToSum.entries
        .toList()
        .where((element) => element.value > 0)
        .sorted((a, b) => a.value - b.value);

    // 支払額の多い人、受け取り額の多い人を優先して支払い処理
    final payment = <Payment>[];
    while (payers.length > 0 && payees.length > 0) {
      final payer = payers.last;
      final payee = payees.last;
      final amount = min(payer.value.abs(), payee.value.abs());
      payment.add(Payment(
          toMember: payee.key,
          fromMember: payer.key,
          amount: amount,
          isDone: false));
      payers.last = MapEntry(payer.key, payer.value + amount);
      payees.last = MapEntry(payee.key, payee.value - amount);
      if (payers.last.value == 0) payers.removeLast();
      if (payees.last.value == 0) payees.removeLast();
    }
    return payment;
  }
}
