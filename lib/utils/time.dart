import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateFromTimestamp(Timestamp timestamp) {
  DateTime time = timestamp.toDate();
  return DateFormat.jm().format(time);
}

String tripDate(Timestamp timestamp) {
  DateTime time = timestamp.toDate();

  return "${DateFormat.yMd().format(time)}";
}
