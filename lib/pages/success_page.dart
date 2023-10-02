import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bus.dart';
import '../utils/time.dart';

class SucessfulPage extends StatelessWidget {
  SucessfulPage({super.key, required this.trip, required this.selectedSeats});

  final Trip trip;
  final List<int> selectedSeats;

  TextStyle _textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    print("DocumentSnapshot successfully updated!");

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Payment Completed"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Trip information',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
          ),
          Card(
            color: Colors.green,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/${trip.busType.toLowerCase()}.png',
                        width: 50,
                        height: 50,
                      ),
                      // Text(
                      //   trips[index - 1].busType,
                      //   style: const TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'From: ${trip.from}',
                        style: TextStyle(color: Colors.white),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Report: ${dateFromTimestamp(trip.departureTime)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Seat NO: ${selectedSeats.join(", ")}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To: ${trip.to}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Depart: ${dateFromTimestamp(trip.reportingTime)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Fare: GHC${trip.fare * selectedSeats.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              'Thank you for choosing us. Enjoy your trip!',
              style: TextStyle(color: Colors.green, fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
