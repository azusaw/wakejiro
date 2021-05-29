import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime) {
  var formatter = DateFormat('yyyy/MM/dd', "ja_JP");
  var formatted = formatter.format(dateTime); // DateからString
  return formatted;
}
