import 'package:flutter_sample/models/paid_category.dart';

String getPaidCategorySvg(PaidCategory paidCategory) {
  switch (paidCategory) {
    case PaidCategory.Food:
      return "meat.svg";
    case PaidCategory.Car:
      return "car.svg";
    case PaidCategory.Shopping:
      return "shopping.svg";
    case PaidCategory.Ticket:
      return "ticket.svg";
    case PaidCategory.Housing:
      return "housing.svg";
    case PaidCategory.Other:
      return "other.svg";
    default:
      return "empty.svg";
  }
}
