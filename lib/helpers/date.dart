import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final digit = date.day % 10;
  var suffix = 'th';

  if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
    suffix = <String>[
      'st',
      'nd',
      'rd',
    ][digit - 1];
  }

  return DateFormat("MMMM d'$suffix'").format(date);
}
