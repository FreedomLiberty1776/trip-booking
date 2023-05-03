import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableTrips extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  AvailableTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Create a new user with a first and last name
          final user = <String, dynamic>{
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
          };

// Add a new document with a generated ID
          db.collection("users").add(user).then((DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
        },
        child: Text("Submit"));
  }
}
