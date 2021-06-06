import 'package:flutter/material.dart';
import 'package:flutter_sample/models/paid_category.dart';
import 'package:flutter_sample/models/participant.dart';

class BillingDetails {
  BillingDetails({
    this.id,
    @required this.paidMember,
    @required this.paidCategory,
    @required this.amount,
  });

  int id;
  Participant paidMember;
  PaidCategory paidCategory;
  int amount;

  BillingDetails copyWith(
          {Participant paidMember, PaidCategory paidCategory, int amount}) =>
      BillingDetails(
          paidMember: paidMember ?? this.paidMember,
          paidCategory: paidCategory ?? this.paidCategory,
          amount: amount ?? this.amount);

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'participant_id': paidMember.id,
      'category': paidCategory.index,
      'amount': amount,
    };
  }

  static BillingDetails of(Map<String, dynamic> m) => BillingDetails(
      id: m['id'],
      paidMember: Participant(id: m['participant_id'], name: m['name']),
      paidCategory: PaidCategory.values[m['category']],
      amount: m['amount']);

  @override
  String toString() {
    return "$id, $paidMember, $paidCategory, $amount";
  }
}
