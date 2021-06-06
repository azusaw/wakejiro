import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';
import 'package:flutter_sample/models/paid_category.dart';

class BillingDetails {
  BillingDetails({
    @required this.paidMember,
    @required this.paidCategory,
    @required this.amount,
  });

  Member paidMember;
  PaidCategory paidCategory;
  int amount;

  BillingDetails copyWith(
          {Member paidMember, PaidCategory paidCategory, int amount}) =>
      BillingDetails(
          paidMember: paidMember ?? this.paidMember,
          paidCategory: paidCategory ?? this.paidCategory,
          amount: amount ?? this.amount);
}
