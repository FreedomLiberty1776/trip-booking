import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/messages_and_notifications.dart';
import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, required this.actionRoute}) : super(key: key);
  final String actionRoute;
  @override
  VerifyNumberState createState() => VerifyNumberState();
}

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class VerifyNumberState extends State<VerifyNumber> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final TextEditingController _txtFormCtrl = TextEditingController();
  final _phoneformKey = GlobalKey<FormState>();
  final _otpformKey = GlobalKey<FormState>();
  String otp = '';
  // late String username;
  String phone = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = "";

  bool showLoading = false;

  @override
  void initState() {
    // UserSecureStorage.getUserPhone().then((value) {
    //   if (value != null) {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //         (_) => Navigator.pushReplacementNamed(context, '/home'));
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    _txtFormCtrl.dispose();
    super.dispose();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        // User user = await _auth.currentUser!;
        // print(user.displayName);
        // print(user.isAnonymous);
        // print(user.phoneNumber);
        // await _auth.signOut();
        print("userinfo ##########################################");
        print(_auth.currentUser!.displayName);
        print(_auth.currentUser!.phoneNumber);
        print(_auth.currentUser!.isAnonymous);
        print(_auth.currentUser!.uid);

        if (_auth.currentUser!.displayName != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/update_profile');
        }
      }
    } on FirebaseAuthException catch (e) {
      // we have to check for the two types of exception as was state on the firebase phone auth website. in case the submitted otp is invalid.
      setState(() {
        showLoading = false;
      });

      showInfo(e.message!);
      // _scaffoldKey.currentState!
      //     .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Form(
          key: _phoneformKey,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              TitleWidget(
                text: 'Enter Phone',
                fontSize: 35.sp,
                canPop: true,
              ),
              SizedBox(height: 200.h),
              buildPhone(),
              SizedBox(height: 24.h),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Form(
          key: _otpformKey,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              TitleWidget(
                text: 'Submit OTP',
                fontSize: 42.sp,
                canPop: true,
              ),
              SizedBox(height: 200.h),
              buildOTP(),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  'Enter the 6 digits verfication code sent to your phone',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(height: 24.h),
              buildSubmitOTPButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: showLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context));

  Widget buildPhone() => buildTitle(
        // title: 'Phone',
        child: TextFormField(
          // initialValue: phone,
          // readOnly: true,
          controller: _txtFormCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(10)
          ],
          decoration: InputDecoration(
            // suffixIcon: icon,
            labelText: 'Phone',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            // if (value == null ||
            //     value.isEmpty ||
            //     value.length != 10 ||
            //     mobileNumberIsValid(value) == null) {
            //   return 'Invalid Ghana phone number';
            // }

            phone = value!;
            return null;
          },
        ),
      );

  Widget buildButton() => ButtonWidget(
      text: 'Submit',
      onClicked: () async {
        if (_phoneformKey.currentState!.validate()) {
          setState(() {
            showLoading = true;
          });
          await _auth.verifyPhoneNumber(
            phoneNumber: "+233${phone.substring(1)}",
            verificationCompleted: (phoneAuthCredential) async {
              setState(() {
                showLoading = false;
              });
              //signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            verificationFailed: (verificationFailed) async {
              setState(() {
                showLoading = false;
              });
              showInfo(verificationFailed.message!);
            },
            codeSent: (verificationId, resendingToken) async {
              setState(() {
                showLoading = false;
                //print("This is the verfication Id $verificationId");
                this.verificationId = verificationId;
                currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                // we have show submit opt here.
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {},
          );
          // verifyNumber(context, phone);
        }
      });

  Widget buildOTP() => buildTitle(
        // title: 'Phone',
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(6)
          ],
          decoration: InputDecoration(
            // suffixIcon: icon,
            labelText: 'OTP',
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
              return 'Please enter the 6 digits OTP sent to your phone number';
            }

            otp = value;
            return null;
          },
        ),
      );

  Widget buildSubmitOTPButton() => ButtonWidget(
      text: 'Submit',
      onClicked: () {
        if (_otpformKey.currentState!.validate()) {
          // networkCallLoading();
          FocusScope.of(context).unfocus();
          // submitOtp(context, otp, username);
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otp);

          signInWithPhoneAuthCredential(phoneAuthCredential);
        }
      });

  Widget buildTitle({
    required Widget child,
  }) =>
      child;
}

// should verify number and submit otp submit the token instead of user number?
// Future verifyNumber(BuildContext context, String number) async {
//   var responseString;
//   try {
//     final response = await http.post(
//       Uri.parse(verifyPhoneUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'user_phone': number,
//       }),
//     );
//     responseString = returnResponse(response);
//     final parsed = jsonDecode(responseString);
//     //print('status $parsed');
//     Navigator.pop(context);
//     Navigator.pop(context);
//     Navigator.pushNamed(context, '/submit_otp');
//   } on SocketException {
//     Navigator.pop(context);
//     showInfo("Internet Connection Error");
//   } catch (error) {
//     Navigator.pop(context);
//     showInfo(error.toString());
//   }
// }
