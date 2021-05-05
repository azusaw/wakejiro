import 'package:flutter/material.dart';
import 'package:flutter_sample/models/member.dart';

class Payment {
  Payment({
    @required this.toMember,
    @required this.fromMember,
    @required this.amount,
    @required this.isDone,
  });

  Member toMember;
  Member fromMember;
  int amount;
  bool isDone;

  Payment copyWith(
          {Member toMember, Member fromMember, int amount, bool isDone}) =>
      Payment(
          toMember: toMember ?? this.toMember,
          fromMember: fromMember ?? this.fromMember,
          amount: amount ?? this.amount,
          isDone: isDone ?? this.isDone);
}
