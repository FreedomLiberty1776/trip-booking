import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trip_booking/pages/trip_details.dart';

import '../models/bus.dart';

class SelectSeat extends StatefulWidget {
  final Trip trip;
  const SelectSeat({super.key, required this.trip});

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  late Trip trip;
  late List<dynamic> allSeats;

  List<int> selectedSeats = [];

  @override
  void initState() {
    trip = widget.trip;
    allSeats =
        widget.trip.seat.isEmpty ? List.filled(44, "0") : widget.trip.seat;
    // print('seat length ${allSeats.length}...............');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView(
          children: [
            seats(allSeats.sublist(0, 4), 0),
            seats(allSeats.sublist(4, 8), 4),
            seats(allSeats.sublist(8, 12), 8),
            seats(allSeats.sublist(12, 16), 12),
            seats(allSeats.sublist(16, 20), 16),
            seats(allSeats.sublist(20, 24), 20),
            seats(allSeats.sublist(24, 28), 24),
            seats(allSeats.sublist(28, 32), 28),
            seats(allSeats.sublist(32, 36), 32),
            seats(allSeats.sublist(36, 40), 36),
            seats(allSeats.sublist(40, 44), 40),
            if (selectedSeats.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      "[ ${selectedSeats.join(", ")} ]",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 16.h),
                      // ),
                      alignment: Alignment.center,
                      // color: Colors.blue,
                      width: ScreenUtil().screenWidth,
                      child: Container(
                          // alignment: Alignment.center,
                          width: ScreenUtil().screenWidth * 0.9,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Theme.of(context).colorScheme.primary),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          // alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Book Trip',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp),
                              ),
                              Text(
                                'GHS${trip.fare * selectedSeats.length}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp),
                              )
                            ],
                          )),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child: TripDetails(
                            trip: trip,
                            allSeats: allSeats,
                            selectedSeats: selectedSeats,
                          ),
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                        )),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Padding seats(List<dynamic> seats, int starter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              seat(seats[0], starter),
              const SizedBox(
                width: 40,
              ),
              seat(seats[1], starter + 1),
            ],
          ),
          Row(
            children: [
              seat(seats[2], starter + 2),
              const SizedBox(
                width: 40,
              ),
              seat(seats[3], starter + 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget seat(dynamic seatState, int index) {
    return InkWell(
      onTap: (() => {
            print(seatState),
            if (seatState.runtimeType ==
                String) // if one it has been booked, do nothing
              {
                setState(() {
                  if (selectedSeats.contains(index + 1)) {
                    selectedSeats.remove(index + 1);
                  } else {
                    selectedSeats.add(index + 1);
                  }
                  allSeats[index] = seatState == "0" ? '*' : "0";
                  // print(allSeats);
                }),
              }
          }),
      child: Icon(
        Icons.living_outlined,
        color: seatState == "0"
            ? null
            : seatState == '*'
                ? Colors.amber
                : Colors.green,
      ),
    );
  }
}
