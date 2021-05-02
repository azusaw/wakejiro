import 'package:flutter/material.dart';
import 'package:flutter_sample/models/paid_category.dart';

class BillingDetails {
  BillingDetails({
    @required this.paidPersonName,
    @required this.paidCategory,
    @required this.amount,
  });

  String paidPersonName;
  PaidCategory paidCategory;
  int amount;
}
