import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
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
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                TitleWidget(
                  text: 'Personal Info',
                  fontSize: 42.sp,
                  canPop: true,
                ),
                SizedBox(height: 50.h),
                // buildPhone(),
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

  // Widget buildPhone() => buildTitle(
  //       // title: 'Phone',
  //       child: TextFormField(
  //         keyboardType: TextInputType.number,
  //         inputFormatters: <TextInputFormatter>[
  //           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  //           LengthLimitingTextInputFormatter(10)
  //         ],
  //         decoration: InputDecoration(
  //           // suffixIcon: icon,
  //           labelText: 'Phone',
  //           focusedBorder: OutlineInputBorder(
  //             borderSide:
  //                 BorderSide(color: Theme.of(context).colorScheme.primary),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(),
  //           ),
  //         ),
  //         validator: (value) {
  //           if (value == null ||
  //               value.isEmpty ||
  //               value.length != 10 ||
  //               mobileNumberIsValid(value) == null) {
  //             return 'Invalid Ghana phone number';
  //           }

  //           phone = value;
  //         },
  //       ),
  //     );

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
          FirebaseAuth.instance.currentUser!
              .updateDisplayName("$firstName|$lastName")
              .then((value) {
            Navigator.pushReplacementNamed(context, '/home');
          });
          // createUser(context, phone, password, firstName, lastName);
        }
      });

  Widget buildTitle({
    required Widget child,
  }) =>
      child;
}
