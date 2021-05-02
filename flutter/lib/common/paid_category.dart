import 'package:flutter_sample/models/paid_category.dart';

String getPaidCategorySvg(PaidCategory paidCategory) {
  switch (paidCategory) {
    case PaidCategory.Food:
      return "riceBall.svg";
    case PaidCategory.Car:
      return "car.svg";
    case PaidCategory.Ticket:
      return "ticket.svg";
    default:
      return "empty.svg";
  }
}
