import 'package:flutter/material.dart';
import 'package:flutter_sample/models/app_database.dart';
import 'package:flutter_sample/models/billing_details.dart';

class BillingDetailsViewModel extends BillingDetails with ChangeNotifier {
  BillingDetailsViewModel()
      : super(paidMember: null, paidCategory: null, amount: 0);
}

class BillingDetailsListViewModel with ChangeNotifier {
  List<BillingDetails> billingDetailsList = [];

  void add(BillingDetails billingDetails) {
    billingDetailsList.add(billingDetails.copyWith());
    notifyListeners();
  }

  void delete(int index) {
    billingDetailsList.removeAt(index);
    notifyListeners();
  }

  Future<void> refresh(int eventId) async {
    this.billingDetailsList = await database.findAllBillingDetails(eventId);
    notifyListeners();
  }

  int calcTotal() => billingDetailsList.fold<int>(
      0, (total, element) => total + element.amount);

  int size() => billingDetailsList.length;
}
