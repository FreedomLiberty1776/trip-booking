import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_booking/pages/review_trip.dart';

import '../models/bus.dart';
import '../widget/button_widget.dart';

class TripDetails extends StatefulWidget {
  final Trip trip;
  final List<int> selectedSeats;
  final List<dynamic> allSeats;

  const TripDetails(
      {super.key,
      required this.trip,
      required this.selectedSeats,
      required this.allSeats});

  @override
  TripDetailsState createState() => TripDetailsState();
}

class TripDetailsState extends State<TripDetails> {
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  String phone = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  // String referralCode = "";
  // bool hasReferral = false;
  // TextEditingController referralCodeCtrl = TextEditingController();

  // @override
  // void initState() {
  //   UserSecureStorage.getrefferedCode().then((value) {
  //     // print("get referral code called................................");
  //     if (value is String && value.isNotEmpty) {
  //       // print(value);
  //       setState(() {
  //         referralCodeCtrl.text = value;
  //         hasReferral = true;
  //       });
  //     } else {
  //       // print("it has not referral code...............................");
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Trip Details'),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                SizedBox(height: 50.h),
                buildPhone(),
                SizedBox(height: 24.h),
                buildFirstName(),
                SizedBox(height: 24.h),
                buildLastName(),
                SizedBox(height: 24.h),
                // passwordField(),
                // // SizedBox(height: 24.h),
                // // referralCodeField(),
                // SizedBox(height: 32.h),
                buildButton(),
                SizedBox(
                  height: 40.h,
                ),
                // Row(
                //   children: [
                //     InkWell(child: Text("Already have an account?")),
                //     SizedBox(
                //       width: 6.w,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         Navigator.pop(context);
                //         Navigator.pushNamed(context, '/sign_in');
                //       },
                //       child: Text(
                //         'Personal Info',
                //         style: TextStyle(
                //             fontSize: 18.sp,
                //             color: Theme.of(context).colorScheme.primary),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ));

  Widget buildPhone() => buildTitle(
        // title: 'Phone',
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(10)
          ],
          decoration: InputDecoration(
            // suffixIcon: icon,
            labelText: 'Contact',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                value.length != 10 ||
                mobileNumberIsValid(value) == null) {
              return 'Invalid Ghana phone number';
            }

            phone = value;
          },
        ),
      );

  Widget buildFirstName() => buildTitle(
        // title: 'First Name',
        child: TextFormField(
          decoration: InputDecoration(
            // suffixIcon: icon,
            labelText: 'First Name',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a proper name';
            }

            firstName = value;
          },
        ),
      );

  Widget buildLastName() => buildTitle(
        // title: 'Last Name',
        child: TextFormField(
          decoration: InputDecoration(
            // suffixIcon: icon,
            labelText: 'Last Name',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a proper name';
            }

            lastName = value;
          },
        ),
      );
  Widget passwordField() => buildTitle(
        // title: 'Password',
        child: TextFormField(
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(_passwordVisible
                  ? Icons.remove_red_eye
                  : Icons.visibility_off),
              onTap: () => setState(() {
                _passwordVisible = !_passwordVisible;
              }),
            ),
            labelText: 'Password',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 6) {
              return 'Password must be at least 6 characters';
            }

            password = value;
          },
        ),
      );
  // Widget referralCodeField() => buildTitle(
  //       // title: 'Password',
  //       child: TextFormField(
  //         readOnly: hasReferral,
  //         // initialValue: referralCode,
  //         maxLength: 14,
  //         decoration: InputDecoration(
  //           // suffixIcon: icon,
  //           labelText: 'Referral Code',
  //           focusedBorder: OutlineInputBorder(
  //             borderSide:
  //                 BorderSide(color: Theme.of(context).colorScheme.primary),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(),
  //           ),
  //         ),
  //         controller: referralCodeCtrl,
  //         // validator: (value) {
  //         //   if (value != null && value.isNotEmpty) {
  //         //     // referralCode = value;
  //         //   }
  //         //   return;
  //         // },
  //       ),
  //     );

  Widget buildButton() => ButtonWidget(
      text: 'Submit',
      onClicked: () {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReviewTrip(
                        name: "$firstName $lastName",
                        contact: phone,
                        trip: widget.trip,
                        allSeats: widget.allSeats,
                        selectedSeats: widget.selectedSeats,
                      )));
        }
      });

  Widget buildTitle({
    required Widget child,
  }) =>
      child;
}

mobileNumberIsValid(String number) {
  const mtnIdentifyers = ["024", "054", "055", "059", "025", "035"];
  const airtelTigoIdentifyers = ["027", "057", "026", "056"];
  const vodaIdentifyers = ["020", "050"];
  if (number.length >= 3) {
    var identifyer = number.substring(0, 3);
    if (mtnIdentifyers.any((e) => e == identifyer)) {
      return "mtn";
    } else if (airtelTigoIdentifyers.any((e) => e == identifyer)) {
      return "tgo";
    } else if (vodaIdentifyers.any((e) => e == identifyer)) {
      return "vod";
    } else {
      return null;
    }
  }
  return null;
}
