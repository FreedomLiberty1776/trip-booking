import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'navigator_service.dart';

void showInfo(String message, {Color color = Colors.red}) {
// first check if center is a valid delivery address.
  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
      .showSnackBar(
    SnackBar(
      content: Text(message),
      // action: SnackBarAction(
      //   label: 'Action',
      //   onPressed: () {
      //     // Code to execute.
      //   },
      // ),
    ),
  );

  // Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.TOP,
  //     timeInSecForIosWeb: 5,
  //     backgroundColor: color,
  //     textColor: Colors.white,
  //     fontSize: 16.sp);
}

class Badge extends StatelessWidget {
  final double top;
  final double right;
  final Widget child; // our Badge widget will wrap this child widget
  final String value; // what displays inside the badge
  final Color color; // the  background color of the badge - default is red

  Badge(
      {required this.child,
      required this.value,
      required this.color,
      required this.top,
      required this.right});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: right,
          top: top,
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: this.color),
            constraints: BoxConstraints(
              minWidth: 16.w,
              minHeight: 16.h,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
