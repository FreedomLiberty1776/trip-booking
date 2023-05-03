import 'package:intl/intl.dart';

String getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(date);
}
