import 'package:flutter/material.dart';
import 'package:flutter_sample/models/paid_category.dart';

class BillingDetails {
  const BillingDetails({
    @required this.paidPersonName,
    @required this.paidCategory,
    @required this.amount,
  });

  final String paidPersonName;
  final PaidCategory paidCategory;
  final int amount;
}
