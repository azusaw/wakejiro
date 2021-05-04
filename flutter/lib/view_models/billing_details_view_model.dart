import 'package:flutter/material.dart';
import 'package:flutter_sample/models/billing_details.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final billingDetailsProvider =
    ChangeNotifierProvider((ref) => BillingDetailsViewModel());
final billingDetailsListProvider =
    ChangeNotifierProvider((ref) => BillingDetailsListViewModel());

class BillingDetailsViewModel with ChangeNotifier {
  BillingDetails billingDetails =
      new BillingDetails(paidPersonName: "", paidCategory: null, amount: 0);

  void setPaidPersonName(String name) {
    billingDetails.paidPersonName = name;
    notifyListeners();
  }

  void setPaidCategory(PaidCategory paidCategory) {
    billingDetails.paidCategory = paidCategory;
    notifyListeners();
  }

  void setAmount(int amount) {
    billingDetails.amount = amount;
    notifyListeners();
  }
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
}
