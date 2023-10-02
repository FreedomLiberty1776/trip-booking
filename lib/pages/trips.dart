import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/bus.dart';
import '../utils/time.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({super.key});

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Bus> buses = [];
  List<Trip> trips = [];
  List<Trip> bookedTrips = [];
  List<int> seatNumbers = [];
  bool loading = true;

  @override
  void initState() {
    db.collection("trips").get().then((event) {
      // print('trip document .............');
      // print(event.docs);
      // print(event.docs[0]['bus']);
      // event.docs.forEach((element) {
      //   print(element.id);
      //   element.data().forEach((key, value) {
      //     print("$key-> $value");
      //   });
      // });

      String userId = _auth.currentUser!.phoneNumber!;
      trips = event.docs.map<Trip>((doc) => Trip.fromJson(doc)).toList();
      // for (var i = 0; i < trips.length; i++) {
      for (var trip in trips) {
        for (int j = 0; j < trip.seat.length; j++) {
          if (trip.seat[j] != "0") {
            if (trip.seat[j]['user_id'] == userId) {
              bookedTrips.add(trip);
              seatNumbers.add(j + 1);
            }
          }
        }
      }
      // }

      print('this booked trips');
      print(bookedTrips);
      loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
        elevation: 2,
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : trips.isEmpty
              ? const Center(
                  child: Text('You have not booked a trip'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: bookedTrips.length,
                  itemBuilder: (BuildContext context, int index) {
                    Trip trip = bookedTrips[index];
                    return Card(
                      color: Colors.green,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Report: ${dateFromTimestamp(trip.departureTime)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Seat NO: ${seatNumbers[index]}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'To: ${trip.to}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Depart: ${dateFromTimestamp(trip.reportingTime)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Fare: GHC${trip.fare}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Trip Date: ${tripDate(trip.reportingTime)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
