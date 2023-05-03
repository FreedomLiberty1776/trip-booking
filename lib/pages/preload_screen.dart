import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Preload extends StatefulWidget {
  const Preload({Key? key}) : super(key: key);

  @override
  State<Preload> createState() => _PreloadState();
}

class _PreloadState extends State<Preload> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool networkError = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_auth.currentUser != null) {
        if (_auth.currentUser!.displayName != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/update_profile');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/verify_phone');
      }
    });
    // User user = _auth.currentUser!;
    // print(user.displayName);
    // print(user.isAnonymous);
    // print(user.phoneNumber);
    // await _auth.signOut();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: setAccountNetworkRequestResult());
  }

  Widget setAccountNetworkRequestResult() {
    return !networkError
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : errorWidget();
  }
}

Widget errorWidget() {
  return Container(
    padding: EdgeInsets.only(top: 200.h),
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(children: [
          Image.asset(
            "assets/images/error.png",
            height: 95.h,
            width: 100.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
            child: const Text(
              'Connection Error. Please check your internet and try again',
              style: TextStyle(
                color: Color(0xffca054d),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(
                  color: const Color(0xffca054d),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
          )
        ]),
      ),
    ),
  );
}
