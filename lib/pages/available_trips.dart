import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trip_booking/pages/seat_selection.dart';

import '../models/bus.dart';
import '../utils/time.dart';

class AvailableTrips extends StatefulWidget {
  final String from;
  final String to;
  final String datetime;
  const AvailableTrips(
      {super.key,
      required this.from,
      required this.to,
      required this.datetime});

  @override
  State<AvailableTrips> createState() => _AvailableTripsState();
}

class _AvailableTripsState extends State<AvailableTrips> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Bus> buses = [];
  List<Trip> trips = [];
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
      trips = event.docs.map<Trip>((doc) => Trip.fromJson(doc)).toList();
      trips = trips
          .where((element) =>
              element.from == widget.from && element.to == widget.to)
          .toList();
      loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Trips"),
        elevation: 2,
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : trips.isEmpty
              ? const Center(
                  child: Text(
                      'There is no trip(s) availabe for the selected route'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: trips.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 16),
                            child: Column(
                              children: [
                                Text(
                                  '${widget.from} -> ${widget.to}',
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.blue),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: (() => Navigator.push(
                                  context,
                                  PageTransition(
                                      curve: Curves.easeIn,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      type: PageTransitionType.rightToLeft,
                                      child: SelectSeat(
                                        trip: trips[index - 1],
                                      )),
                                )),
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/${busImage(trips[index - 1].busType)}.png',
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
                                            'Report: ${dateFromTimestamp(trips[index - 1].departureTime)}'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Depart: ${dateFromTimestamp(trips[index - 1].reportingTime)}'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Seat Left: ${seatsLeft(trips[index - 1].seat)}'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Fare: GHC${trips[index - 1].fare}.00'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  }),
    );
  }
}

int seatsLeft(List<dynamic> seats) {
  return 44 - seats.where((element) => element != "0").toList().length;
  // print(seats);
  // return '0'.allMatches(seats).length;
}

String busImage(String busType) {
  busType = busType.toLowerCase();
  if (busType.contains("metromass")) return "metromass";
  if (busType.contains('oa')) return "oa";
  if (busType.contains('stc')) return "stc";
  return 'stc'; // later turn this to vip if we get the image
}
