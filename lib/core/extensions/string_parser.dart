import 'package:intl/intl.dart';

extension StringParser on String {
  String toDisplayDate() {
    final inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    final inputDate = inputFormat.parse(this);
    final outputFormat = DateFormat('HH:mm - dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}
