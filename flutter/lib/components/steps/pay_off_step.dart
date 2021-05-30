import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/components/buttons/step_control_buttons.dart';
import 'package:flutter_sample/components/cards/pay_off_card.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/payment.dart';
import 'package:flutter_sample/screens/create_event_screen.dart';
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
      _paymentList.forEach((element) {
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
            title: Text("2021/4/5"),
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
          StepControlButtons(back: back, next: next)
        ]);
  }
}
