import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trip_booking/pages/payment_page.dart';

import '../models/bus.dart';
import '../utils/time.dart';
import '../widget/button_widget.dart';

class ReviewTrip extends StatelessWidget {
  final String name;
  final String contact;
  final Trip trip;
  final List<int> selectedSeats;
  final List<dynamic> allSeats;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ReviewTrip(
      {super.key,
      required this.name,
      required this.contact,
      required this.trip,
      required this.selectedSeats,
      required this.allSeats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Trip'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 26),
        child: ListView(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Trip Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Departing From:',
                style: xStyle(true),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(trip.from)
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arriving At:',
                style: xStyle(true),
              ),
              Text(trip.to)
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Report At:',
                style: xStyle(true),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(dateFromTimestamp(trip.departureTime))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Departing AT:',
                style: xStyle(true),
              ),
              Text(dateFromTimestamp(trip.reportingTime))
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, bottom: 16),
                child: Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Text(
                    "Name:",
                    style: xStyle(true),
                  ),
                  Text(name)
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact:",
                    style: xStyle(true),
                  ),
                  Text(contact)
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booked Seat(s):",
                    style: xStyle(true),
                  ),
                  Text(
                    "[ ${selectedSeats.join(", ")} ]",
                    style: const TextStyle(
                      // color: Colors.green,
                      // fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: buildButton(context),
          )
        ]),
      ),
    );
  }

  Widget buildButton(BuildContext context) => ButtonWidget(
      text: 'Book Trip',
      onClicked: () => Navigator.push(
            context,
            PageTransition(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: PaymentPage(
                  amount: 11,
                  // itemReference: "s3232sdsd4fdsdsfewds",
                  trip: trip,
                  allSeats: allSeats,
                  selectedSeats: selectedSeats,
                  passengerInfo: {
                    "name": name,
                    "contact": contact,
                    'user_id': _auth.currentUser!.phoneNumber!
                  },
                )),
          ));
}

TextStyle xStyle(bool key) => TextStyle(
      color: key ? const Color.fromARGB(255, 121, 120, 120) : null,
      // fontSize: 18,
      // overflow: TextOverflow.ellipsis,
      // fontWeight: FontWeight.bold,
    );


    // Padding pad() => 
