import 'package:flutter/material.dart';
import 'package:flutter_sample/models/payment.dart';

class PaymentViewModel with ChangeNotifier {
  Payment payment =
      Payment(fromMember: null, toMember: null, amount: 0, isDone: false);
}

class PaymentListViewModel with ChangeNotifier {
  List<Payment> paymentList = [];

  void add(Payment payment) {
    paymentList.add(payment.copyWith());
    notifyListeners();
  }

  void delete(int index) {
    paymentList.removeAt(index);
    notifyListeners();
  }

  void deleteAll() {
    paymentList = [];
    notifyListeners();
  }

  void inverseDone(int index) {
    paymentList[index].isDone = (!paymentList[index].isDone);
    notifyListeners();
  }
}
