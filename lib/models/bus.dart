import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  final String bus;

  final String regNo;
  final int noSeats;

  Bus({required this.bus, required this.regNo, required this.noSeats});

  factory Bus.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Bus(
      bus: json['bus'],
      noSeats: json['noSeats'],
      regNo: json['regNo'],
    );
  }
}

class Trip {
  final String bus;
  final int availableSeats;
  final Timestamp departureTime;
  final int fare;
  final Timestamp reportingTime;
  final String from;
  final String to;
  String busType;
  List<dynamic> seat;
  String id;

  Trip({
    required this.bus,
    required this.availableSeats,
    required this.departureTime,
    required this.fare,
    required this.reportingTime,
    required this.from,
    required this.to,
    required this.busType,
    required this.seat,
    required this.id,
  });

  factory Trip.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    // print(json.id);
    // json.data().forEach((key, value) {
    //   print("$key -> $value");
    // });
    return Trip(
      id: json.id,
      bus: fieldValue(json, "bus"),
      from: json['from'] ?? json['from '],
      departureTime: fieldValue(json, "departureTime"),
      busType: fieldValue(json, "busType"),
      fare: fieldValue(json, "fare"),
      reportingTime: fieldValue(json, "reportingTime"),
      to: fieldValue(json, 'to'),
      availableSeats: fieldValue(json, "availableSeats"),
      seat: fieldValue(json, "seat"),
    );
  }
}

dynamic fieldValue(QueryDocumentSnapshot<Map<String, dynamic>> json, value) {
  // print(value);
  try {
    return json[value];
  } catch (e) {
    print('the error has been catched');
    print(value + "T");
    return json["$value "];
  }
}
